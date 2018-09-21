
Hardcode only, maybe improvement it lately
remove the following code from avs2_defs.h

#if (ARCH_X86 || ARCH_X86_64)
#include <xmmintrin.h>
#endif

