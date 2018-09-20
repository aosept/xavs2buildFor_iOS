
只是hardcode，抛砖引玉，有空了再修改一下。
需要注释掉avs2_defs.h中的

#if (ARCH_X86 || ARCH_X86_64)
#include <xmmintrin.h>
#endif

