class KgToolkit
  
  # Hash methods:
  
  def self.recursive_symbolize_keys(obj)
    case obj
    when Array
      obj.inject([]){|res, val|
        res << case val
        when Hash, Array
          self.recursive_symbolize_keys(val)
        else
          val
        end
        res
      }
    when Hash
      obj.inject({}){|res, (key, val)|
        nkey = case key
        when String
          key.to_sym
        else
          key
        end
        nval = case val
        when Hash, Array
          self.recursive_symbolize_keys(val)
        else
          val
        end
        res[nkey] = nval
        res
      }
    else
      obj
    end
  end
  
  
  # Surely there exist simpler ways to do these three methods with CSV library... (todo)
  def self.csv_to_array(lines, enclosed_by = '"')
    array = []
    header = lines.shift.strip
    keys = header.split(',')
    lines.each do |line|
      params = {}
      values = line.strip.split(',')
      keys.each_with_index do |key,i|
        params[key] = values[i]
      end
      array.push(params)
    end
    return array
  end
  
  
  def self.csv_from_objects(od_objects, replacements = {})
    csv_string = CSV.generate({:force_quotes => true}) do |csv|
      keys = od_objects.first.attributes.keys
      csv << keys
      od_objects.each do |od_object|
        actual_values = od_object.attributes.values_at(*keys)
        puts actual_values.to_s
        if replacements.any?
          replacements.each do |value, replacement|
            actual_values.collect! { |actual_value| actual_value = (actual_value == value) ? replacement : actual_value }
            puts actual_values.to_s
          end
        end
        puts actual_values.to_s
        csv << actual_values
      end
    end
    return csv_string
  end
  
  def self.csv_from_array_of_hashes(array_of_hashes, replacements = {}, prefix = nil)
    csv_string = CSV.generate({:force_quotes => true}) do |csv|
      csv << (prefix ? (array_of_hashes.first.keys.collect { |key| prefix.to_s+key.to_s }) : array_of_hashes.first.keys)
      array_of_hashes.each do |hash|
        actual_values = hash.values
        if replacements.any?
          replacements.each do |value, replacement|
            actual_values.collect! { |actual_value| actual_value = (actual_value == value) ? replacement : actual_value }
          end
        end
        csv << actual_values
      end
    end
    return csv_string
  end
  
  # Get all unique keys from an array of hashes: (example: [{:a => 2, :b => 3, :c => 4},{:a => 5, :c => 7},{:a => 8, :b => 9, :c => 10, :d => 11}]) => returns [:a, :b, :c, :d]
  def self.fetch_all_uniq_keys(array_of_hashes)
    array_of_hashes.map{|hash|hash.keys}.flatten.uniq
  end
  
  def self.fill_keys_with_no_values_with(array_of_hashes, default_value, keys = nil)
    keys ||= self.fetch_all_uniq_keys(array_of_hashes)
    array_of_hashes.each do |hash|
      keys.each do |key|
        hash[key] = default_value unless hash.has_key? key # put default_value as a value if key was not provided for this hash
      end
    end
  end
  
  def self.remove_non_digits(string)
    string.gsub(/[^0-9]/i,"")
  end
  
  def self.yml_file_to_hash(yml_file_path)
    YAML.load(ERB.new(File.read(yml_file_path)).result)
  end
  
  def self.save_hash_to_yaml(hash, save_path, replace_if_exists = false)
    raise "File exists (#{save_path})" if File.exists?(save_path) && !replace_if_exists
    File.write(save_path, hash.to_yaml)
  end
  
  def self.hash_array_deep_copy(value)
    if value.is_a?(Hash)
      result = value.clone
      value.each{|k, v| result[k] = self.hash_array_deep_copy(v)}
      result
    elsif value.is_a?(Array)
      result = value.clone
      result.clear
      value.each{|v| result << self.hash_array_deep_copy(v)}
      result
    else
      value
    end
  end
  
  def self.optional_localized_string(optional_localized_string_or_hash, locale = I18n.locale)
    return optional_localized_string_or_hash unless optional_localized_string_or_hash.respond_to?(:has_key?)
    if optional_localized_string_or_hash.respond_to?(:has_key?) && (optional_localized_string_or_hash[locale.to_sym] || optional_localized_string_or_hash[locale])
      return optional_localized_string_or_hash[locale.to_sym] || optional_localized_string_or_hash[locale]
    else
      return ""
    end
  end
  
  
end