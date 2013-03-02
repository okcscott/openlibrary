require 'spec_helper'

describe 'Client' do
  let(:client)  { Openlibrary::Client.new() }

  describe '#new' do
    it 'requires an argument' do
      expect { Openlibrary::Client.new(nil) }.
        to raise_error ArgumentError, "Options hash required."
    end

    it 'requires a hash argument' do
      expect { Openlibrary::Client.new('foo') }.
        to raise_error ArgumentError, "Options hash required."
    end
  end

  describe '#book' do
    before do
      olid = 'OL23109860M'
      stub_get("/books/#{olid}", 'book.json')
    end

    it 'returns a book by its OLID' do
      expect { client.book('OL23109860M') }.not_to raise_error
    end

    it 'returns correct book details' do
      book = client.book('OL23109860M')

      book.should be_a Hashie::Mash
      book.should respond_to :title
    end
  end
end
