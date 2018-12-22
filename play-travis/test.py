import unittest

class NumbersTest(unittest.TestCase):

    def test_equal(self):
	i = 1 + 1
        self.assertEqual(1 + 1, i)

if __name__ == '__main__':
    unittest.main()
