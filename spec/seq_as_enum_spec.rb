# frozen_string_literal: true

RSpec.describe SeqAsEnum do
  it 'has a version number' do
    expect(SeqAsEnum::VERSION).not_to be nil
  end

  context 'without options' do
    class WithoutOptions
      extend SeqAsEnum

      seq_as_enum :FOO, :BAR, :BAZ
    end
    it 'defines constants with 0-based values' do
      expect(WithoutOptions::FOO).to eq 0
      expect(WithoutOptions::BAR).to eq 1
      expect(WithoutOptions::BAZ).to eq 2
    end
  end

  context 'with init option' do
    class WithInitOption
      extend SeqAsEnum

      seq_as_enum :FOO, :BAR, :BAZ, init: 10
    end
    it 'defines constants with 0-based values' do
      expect(WithInitOption::FOO).to eq 10
      expect(WithInitOption::BAR).to eq 11
      expect(WithInitOption::BAZ).to eq 12
    end
  end

  context 'with string init option' do
    class WithStringInitOption
      extend SeqAsEnum

      seq_as_enum :FOO, :BAR, :BAZ, init: 'a'
    end
    it 'defines constants with string sequences' do
      expect(WithStringInitOption::FOO).to eq 'a'
      expect(WithStringInitOption::BAR).to eq 'b'
      expect(WithStringInitOption::BAZ).to eq 'c'
    end
  end

  context 'with data_as option' do
    class WithDataAsOption
      extend SeqAsEnum

      seq_as_enum :Red, :Yellow, :Green, data_as: :Color
    end
    it 'defines constants as Data object' do
      expect(WithDataAsOption::Color.Red).to eq 0
      expect(WithDataAsOption::Color.Yellow).to eq 1
      expect(WithDataAsOption::Color.Green).to eq 2
    end

    context 'with prefix option' do
      it 'raises error' do
        expect {
          class WithDataAsAndPrefix
            extend SeqAsEnum

            seq_as_enum :Red, data_as: :Color, prefix: :Beautiful
          end
        }.to raise_error(ArgumentError, 'Cannot use prefix option with data_as option')
      end
    end
  end

  context 'with prefix option' do
    class WithPrefixOption
      extend SeqAsEnum

      seq_as_enum :NAME, :ADDRESS, :PHONE, prefix: :COL
    end
    it 'defines constants with prefix' do
      expect(WithPrefixOption::COL_NAME).to eq 0
      expect(WithPrefixOption::COL_ADDRESS).to eq 1
      expect(WithPrefixOption::COL_PHONE).to eq 2
    end
  end

  context 'with prefix and sep options' do
    class WithPrefixAndSepFalse
      extend SeqAsEnum

      seq_as_enum :Name, :Address, :Phone, prefix: :Col, sep: false
    end
    it 'defines constants with prefix' do
      expect(WithPrefixAndSepFalse::ColName).to eq 0
      expect(WithPrefixAndSepFalse::ColAddress).to eq 1
      expect(WithPrefixAndSepFalse::ColPhone).to eq 2
    end
  end

  context 'with sep option only' do
    it 'raises error' do
      expect {
        class WithSepOptionOnly
          extend SeqAsEnum

          seq_as_enum :NAME, sep: false
        end
      }.to raise_error(ArgumentError, 'Cannot use sep option without prefix option')
    end
  end

  context 'with two or more definitions' do
    class WithTwoDefinitions
      extend SeqAsEnum

      seq_as_enum :FOO, :BAR, :BAZ
      seq_as_enum :HOGE, :FUGA, :PIYO, init: 10
    end

    it 'defines constants for each' do
      expect(WithTwoDefinitions::FOO).to eq 0
      expect(WithTwoDefinitions::BAR).to eq 1
      expect(WithTwoDefinitions::BAZ).to eq 2

      expect(WithTwoDefinitions::HOGE).to eq 10
      expect(WithTwoDefinitions::FUGA).to eq 11
      expect(WithTwoDefinitions::PIYO).to eq 12
    end
  end

  context 'when constant already defined' do
    it 'raises error' do
      expect {
        class Foo
          extend SeqAsEnum

          BAR = 1
          seq_as_enum :BAR
        end
      }.to raise_error(StandardError, 'already initialized constant: Foo::BAR')
    end
  end
end
