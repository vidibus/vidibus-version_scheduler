require "spec_helper"

describe "Vidibus::VersionScheduler::MigrationJob" do
  let(:job) {Vidibus::VersionScheduler::MigrationJob.new("a02099608baa012e2ee258b035f038ab")}
  let(:now) {stub_time("2011-07-01 12:01")}
  let(:tomorrow) {now + 1.day}
  let(:book) {Book.create({:title => "title 1", :text => "text 1"})}
  let(:future_version) do
    book.version(:new, :title => "title 2").tap do |v|
      v.version_object.uuid = "a02099608baa012e2ee258b035f038ab"
      v.updated_at = tomorrow
      v.save
    end.version_object
  end

  describe "initializing" do
    it "should fail without params" do
      expect { Vidibus::VersionScheduler::MigrationJob.new }.
        to raise_error(ArgumentError)
    end

    it "should pass with a version uuid" do
      expect {job}.not_to raise_error(ArgumentError)
    end
  end

  describe "#perform" do
    it "should fetch the proper version" do
      mock(Vidibus::Versioning::Version).
        where(:uuid => "a02099608baa012e2ee258b035f038ab") { OpenStruct.new }
      job.perform
    end

    it "should fetch the versioned object" do
      future_version
      mock.any_instance_of(Vidibus::Versioning::Version).versioned
      job.perform
    end

    it "should migrate the versioned object" do
      future_version
      mock.any_instance_of(Book).migrate!(2)
      job.perform
    end

    it "should handle migration errors" do
      future_version
      stub.any_instance_of(Book).migrate!(2) do
        raise(Vidibus::Versioning::MigrationError)
      end
      job.perform
    end

    it "should destroy the scheduled version after a successful migration" do
      future_version
      stub.any_instance_of(Book).migrate!(2) {true}
      job.perform
      Vidibus::VersionScheduler::ScheduledVersion.count.should eql(0)
    end

    it "should not destroy any other scheduled versions" do
      another_book = Book.create(:title => "title 1", :text => "text 1")
      another_book.version(:new).update_attributes!({
        :title => "new title", :updated_at => tomorrow
      })
      future_version
      stub.any_instance_of(Book).migrate!(2) {true}
      job.perform
      Vidibus::VersionScheduler::ScheduledVersion.count.should eql(1)
    end
  end
end
