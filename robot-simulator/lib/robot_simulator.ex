defmodule RobotSimulator do
  defstruct direction: :north, x: 0, y: 0
  defguard is_direction(direction) when direction in [:north, :south, :east, :west]
  defguard is_position(x, y) when is_integer(x) and is_integer(y)
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(), do: %RobotSimulator{}

  def create(direction, _) when not is_direction(direction), do: {:error, "invalid direction"}

  def create(direction, {x, y}) when is_position(x, y), do: %RobotSimulator{direction: direction, x: x, y: y}

  def create(_, _) , do: {:error, "invalid position"}
  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.graphemes(instructions)
    |> Enum.reduce(robot, &move/2)
  end

  def move("L", %{direction: :north} = robot), do: %{robot | direction: :west}

  def move("L", %{direction: :west} = robot), do: %{robot | direction: :south}

  def move("L", %{direction: :south} = robot), do: %{robot | direction: :east}

  def move("L", %{direction: :east} = robot), do: %{robot | direction: :north}

  def move("R", %{direction: :north} = robot), do: %{robot | direction: :east}

  def move("R", %{direction: :east} = robot), do: %{robot | direction: :south}

  def move("R", %{direction: :south} = robot), do: %{robot | direction: :west}

  def move("R", %{direction: :west} = robot), do: %{robot | direction: :north}

  def move("A", %{direction: :north, y: y} = robot), do: %{robot | y: y + 1}

  def move("A", %{direction: :east, x: x} = robot), do: %{robot | x: x + 1}

  def move("A", %{direction: :south, y: y} = robot), do: %{robot | y: y - 1}

  def move("A", %{direction: :west, x: x} = robot), do: %{robot | x: x - 1}

  def move(_, _), do: {:error, "invalid instruction" }
  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """

  @spec position(robot :: any) :: {integer, integer}

  def position(robot) do
    {robot.x, robot.y}
  end

end
