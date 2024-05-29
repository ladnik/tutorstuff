#include <immintrin.h>

// template...

float sdot(size_t n, const float x[n], const float y[n])
{
  __m128 res = _mm_setzero_ps();

  // using a single counter for both loops make things easier...
  size_t i = 0;
  for (; i < n - (n % 4); i += 4)
  {
    __m128 a = _mm_loadu_ps(&x[i]);
    __m128 b = _mm_loadu_ps(&y[i]);

    // here you could use */+ as well
    __m128 c = _mm_mul_ps(a, b);
    res = _mm_add_ps(c, res);
  }

  // add simd results together to form scalar
  float res_float = res[0] + res[1] + res[2] + res[3];

  // use scalar operations for remaining elements
  for (; i < n; i++)
  {
    res_float += x[i] * y[i];
  }

  return res_float;
}

// template...