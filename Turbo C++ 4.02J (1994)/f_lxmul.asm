; *Not* the original file, but an edit to turn it into an includable slice.
; Changes include:
; * removal of RULES.ASI to eliminate redundancy
; * removal of the 'CODE' segment declaration (for obvious reasons)
; * the @@ prefix on any local labels

;[]-----------------------------------------------------------------[]
;|      F_LXMUL.ASM -- long multiply routine                         |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 5.0
; 
;       Copyright (c) 1987, 1992 by Borland International
;       All Rights Reserved.
; 
; calls to this routine are generated by the compiler to perform
; long multiplications.

; There is no check for overflow.  Consequently, the same routine
; is used for both signed and unsigned long multiplies.

;
; in:
;       (dx:ax) - 32bit arg1
;       (cx:bx) - 32bit arg2
; out:
;       (dx:ax) - 32bit product
;
; reg use: bx,cx destroyed, all others preserved or contain result.
;
; hi(result) := lo(hi(arg1) * lo(arg2)) +
;               lo(hi(arg2) * lo(arg1)) +
;               hi(lo(arg1) * lo(arg2))
; lo(result) := lo(lo(arg1) * lo(arg2))
;
;

        public  LXMUL@
        public  F_LXMUL@

LXMUL@          PROC    FAR
F_LXMUL@:
                push    si
                xchg    si,ax           ; save lo1
                xchg    ax,dx
                test    ax,ax           ; skip mul if hi1==0
                jz      @@nohi1
                mul     bx              ; hi1 * lo2

@@nohi1:        ; if we jumped here, ax==0 so the following swap works
                jcxz    @@nohi2         ; skip mul if hi2==0
                xchg    cx, ax          ; result <-> hi2
                mul     si              ; lo1 * hi2
                add     ax, cx          ; ax = hi1*lo2 + hi2*lo1
@@nohi2:
                xchg    ax,si
                mul     bx              ; lo1 * lo2
                add     dx,si           ; hi order result += partials
                pop     si
                ret
LXMUL@          ENDP
