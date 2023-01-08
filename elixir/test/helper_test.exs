defmodule Helper.Test do
  use ExUnit.Case
  doctest Helper
  require Helper

  test "#transpose" do
    assert [[1, 10, 11], [2, 20, 22], [3, 30, 33]] ==
             Helper.transpose([[1, 2, 3], [10, 20, 30], [11, 22, 33]])
  end

  test "#hflip" do
    assert [[3, 2, 1], [30, 20, 10], [33, 22, 11]] ==
             Helper.hflip([[1, 2, 3], [10, 20, 30], [11, 22, 33]])
  end

  test "#vflip" do
    assert [[11, 22, 33], [10, 20, 30], [1, 2, 3]] ==
             Helper.vflip([[1, 2, 3], [10, 20, 30], [11, 22, 33]])
  end

  test "#rotate" do
    assert [[11, 10, 1], [22, 20, 2], [33, 30, 3]] ==
             Helper.rotate([[1, 2, 3], [10, 20, 30], [11, 22, 33]])
  end
end
