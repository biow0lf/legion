require 'spec_helper'

describe Legion::ALTRPM::Base do
  let(:file) { 'spec/fixtures/catpkt-1.0-alt5.src.rpm' }

  subject { described_class.new(file) }

  describe '#initialize' do
    context 'default' do
      its(:file) { should eq(file) }

      its(:locale) { should eq('C') }
    end

    context 'with locale' do
      let(:locale) { double }

      subject { described_class.new(file, locale) }

      its(:file) { should eq(file) }

      its(:locale) { should eq(locale) }
    end
  end

  specify { expect(subject.name).to eq('catpkt') }

  specify { expect(subject.version).to eq('1.0') }

  specify { expect(subject.release).to eq('alt5') }

  describe '#epoch' do
    context 'epoch is not present' do
      specify { expect(subject.epoch).to eq(nil) }
    end

    context 'epoch is present'
  end

  specify { expect(subject.summary).to eq('FTS Packet Viewer') }

  specify { expect(subject.group).to eq('Text tools') }

  specify { expect(subject.license).to eq('BSD-like') }

  describe '#url' do
    context 'url is not present' do
      specify { expect(subject.url).to eq(nil) }
    end

    context 'url is present'
  end

  describe '#packager'

  describe '#vendor'

  describe '#distribution'

  describe '#description'

  describe '#buildhost'

  describe '#changelogname'

  describe '#changelogtext'

  describe '#buildtime'

  describe '#changelogtime'
end
