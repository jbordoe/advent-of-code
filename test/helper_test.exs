defmodule Helper.Test do
  use ExUnit.Case
  doctest Helper
  require Helper

  test "#transpose" do
    assert [[1, 10, 11], [2, 20, 22], [3, 30, 33]] ==
             Helper.transpose([[1, 2, 3], [10, 20, 30], [11, 22, 33]])
  end
end
