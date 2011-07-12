require "spec_helper"

describe "Vidibus::VersionScheduler::Mongoid" do
  let(:now) {stub_time("2011-07-01 12:01")}
  let(:book_attributes) {{:title => "title", :text => "text"}}
  let(:new_book) {Book.new(book_attributes)}
  let(:book) {Book.create(book_attributes)}
  let(:past_version) do
    book.update_attributes(:title => "past title")
    book.versions.last.tap do |v|
      v.created_at = now - 1.day
    end
  end
  let(:future_version) do
    book.reload.version(:next, :title => "future title").tap do |v|
      v.version_object.created_at = now + 1.day
      v.save
    end.version_object
  end

  describe "#scheduled_versions" do
    it "should be an empty array by default" do
      new_book.scheduled_versions.should eql([])
    end

    it "should contain scheduled versions that have created by the VersionObserver" do
      future_version
      book.reload.scheduled_versions.should have(1).item
      book.scheduled_versions.first.should be_a(Vidibus::VersionScheduler::ScheduledVersion)
    end
  end

  describe "#sync_scheduled_versions!" do
    before do
      now
      past_version
      future_version
      book.reload
    end

    it "should schedule future versions only" do
      book.scheduled_versions.delete_all
      book.sync_scheduled_versions!
      scheduled_versions = book.reload.scheduled_versions
      scheduled_versions.should have(1).item
      scheduled_versions.first.version_uuid.should eql(future_version.uuid)
    end

    it "should remove all scheduled versions if no versions exist anymore" do
      book.versions.delete_all
      book.reload.sync_scheduled_versions!
      book.scheduled_versions.should have(:no).items
    end
  end
end
