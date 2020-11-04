#ifndef __TRK_MISC_H__
#define __TRK_MISC_H__

#define ClearBit(a,b) (a &= ~(0x01 << b))
#define GetBit(a,b) ((a & (0x01 << b)) == (0x01 << b))
#define SetBit(a,b) (a |= (0x01 << b))

#define FALSE 0
#define TRUE 1

#define Binary(x) ((0x##x&0x0000000FLU)?1:0) \
+((0x##x&0x000000F0LU)?2:0) \
+((0x##x&0x00000F00LU)?4:0) \
+((0x##x&0x0000F000LU)?8:0) \
+((0x##x&0x000F0000LU)?16:0) \
+((0x##x&0x00F00000LU)?32:0) \
+((0x##x&0x0F000000LU)?64:0) \
+((0x##x&0xF0000000LU)?128:0)

#define minus_abs(x,y) ((x>y) ? (x-y) : (y-x))



#endif
