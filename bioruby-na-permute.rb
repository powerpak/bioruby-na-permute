require 'bio'

module Bio
  class Sequence
    class NA
      
      # See http://en.wikipedia.org/wiki/Nucleic_acid_notation
      IUPAC_DEGENERATE_BASES = {
        'w' => ['a', 't'],
        's' => ['c', 'g'],
        'm' => ['a', 'c'],
        'k' => ['g', 't'],
        'r' => ['a', 'g'],
        'y' => ['c', 't'],
        'b' => ['c', 'g', 't'],
        'd' => ['a', 'g', 't'],
        'h' => ['a', 'c', 't'],
        'v' => ['a', 'c', 'g'],
        'n' => ['a', 'c', 'g', 't']
      }
      
      def permute
        ib = illegal_bases      # cache this so we're not re-searching repeatedly
        permute_positions = {}
        
        permutations = [self.dup]
        
        (0...size).each do |i|
          base = seq[i, 1]
          if ib.include? base
            permute_positions[i] = IUPAC_DEGENERATE_BASES[base.to_s.downcase]
          end
        end
        
        permute_positions.each do |pos, options|
          (permutations.size - 1).downto(0).each do |index|
            permutations[index..index] = options.map do |option|
              old_seq = permutations[index].dup
              old_seq[pos..pos] = option
              old_seq
            end
          end
        end
        
        permutations
      end
      
    end
  end
end

if __FILE__==$0
  Bio::FlatFile.auto(ARGF) do |ff|
    ff.each do |entry|
      entry.naseq.permute.each_with_index do |permutation, index|
        puts ">#{entry.entry_id}_#{index + 1}"
        puts permutation.to_s
      end
    end
  end
end