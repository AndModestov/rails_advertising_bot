class MyTarget::Logger

  def self.debug action_name, msg
    ap action_name + ':'
    ap msg
    puts
  end
end
