class String
  def capitalize_first_char
    self.sub(/^(.)/) { $1.capitalize } rescue self.to_s
  end
end
