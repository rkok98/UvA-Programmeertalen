import pytest
import os

# We run the commands in a tempdir, but this dir contains the sudoku files.
ROOT_DIR = os.getcwd()


@pytest.fixture()
def executable(pytestconfig):
    return ("python3", ROOT_DIR + "/sudoku.py")


def build_sudoku_path(file):
    return ROOT_DIR + "/sudoku_boards/" + file


def test_hard_9_grid(executable, testdir):
    res = testdir.run(*executable, build_sudoku_path("hard_9_grid.txt"))
    res.stdout.fnmatch_lines([
        "8 1 2 7 5 3 6 4 9",
        "9 4 3 6 8 2 1 7 5",
        "6 7 5 4 9 1 2 8 3",
        "1 5 4 2 3 7 8 9 6",
        "3 6 9 8 4 5 7 2 1",
        "2 8 7 1 6 9 5 3 4",
        "5 2 1 9 7 4 3 6 8",
        "4 3 8 5 2 6 9 1 7",
        "7 9 6 3 1 8 4 5 2"
    ], consecutive=True)
    assert res.ret == 0


def test_16_grid(executable, testdir):
    res = testdir.run(*executable, build_sudoku_path("16_grid.txt"))
    res.stdout.fnmatch_lines([
            "8 15 11 1 6 2 10 14 12 7 13 3 16 9 4 5",
            "10 6 3 16 12 5 8 4 14 15 1 9 2 11 7 13",
            "14 5 9 7 11 3 15 13 8 2 16 4 12 10 1 6",
            "4 13 2 12 1 9 7 16 6 10 5 11 3 15 8 14",
            "9 2 6 15 14 1 11 7 3 5 10 16 4 8 13 12",
            "3 16 12 8 2 4 6 9 11 14 7 13 10 1 5 15",
            "11 10 5 13 8 12 3 15 1 9 4 2 7 6 14 16",
            "1 4 7 14 13 10 16 5 15 6 8 12 9 2 3 11",
            "13 7 16 5 9 6 1 12 2 8 3 10 11 14 15 4",
            "2 12 8 11 7 16 14 3 5 4 6 15 1 13 9 10",
            "6 3 14 4 10 15 13 8 7 11 9 1 5 12 16 2",
            "15 1 10 9 4 11 5 2 13 16 12 14 8 3 6 7",
            "12 8 4 3 16 7 2 10 9 13 14 6 15 5 11 1",
            "5 11 13 2 3 8 4 6 10 1 15 7 14 16 12 9",
            "7 9 1 6 15 14 12 11 16 3 2 5 13 4 10 8",
            "16 14 15 10 5 13 9 1 4 12 11 8 6 7 2 3"
     ], consecutive=True)
