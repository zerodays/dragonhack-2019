import numpy as np

# settings
start_year, end_year = 1998, 2019
k, start = 2.3, 380
error = 10

n  = start - start_year * k

for x in range(start_year, end_year, 1):
	y = k * x + n
	y = np.random.normal(y, scale=error)
	print('MyRow(DateTime({}), {}),'.format(x, int(y)))
