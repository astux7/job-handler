class ProgramError < StandardError
  def initialize(msg = "You've triggered a MyError")
    super(msg)
  end
end