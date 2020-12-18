require './e_methods.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:ha) { { 'key1': 'green', 'key2': 'purple', 'key3': 'black' } }
  let(:ra) { (0..10) }

  describe "#my_each" do
    it "returns an enumerator if no block is given" do
      expect(arr.my_each.is_a?(Enumerator)).to eql(true)
    end

    it "iterates to each one of the elements of an array" do
      i = 0
      arr.my_each do |el| 
        expect(el).to eql(arr[i])
        i += 1
      end
    end

    it "iterates to each one of the elements of a hash" do
      ha.my_each do |key, val|
        expect(val).to eql(ha[key])
      end
    end
  end

  describe "#my_each_with_index" do
    it "returns an enumerator if no block is given" do
      expect(arr.my_each_with_index.is_a?(Enumerator)).to eql(true)
    end

    it "iterates to each one of the elements of an array and check the index" do
      i = 0
      arr.my_each_with_index do |el, ind| 
        expect(el).to eql(arr[i])
        expect(ind).to eql(i)
        i += 1
      end
    end
  end

  describe "#my_select" do
    it "returns an enumerator if no block is given" do
      expect(arr.my_select.is_a?(Enumerator)).to eql(true)
    end

    it "returns a new array with the elements that return true from the passed block" do
      expect(ra.my_select(&:odd?)).to eql([1, 3, 5, 7, 9])
    end

    it "returns a new hash matching their keys and values" do
      expect(ha.my_select(key, val)).to eql()
    end
  end

  describe "#my_all?" do

  end

  describe "#my_any?" do

  end

  describe "#my_none?" do

  end

  describe "#my_count" do

  end

  describe "#my_map" do

  end

  describe "#my_inject" do

  end

  describe "#multiply_els" do

  end
end
