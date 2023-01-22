.macro mov (%rd , %rs)
  addi %rd , %rs , 0
.end_macro

.macro push (%reg)
  addi $sp , $sp , 4
  mov [$sp] , %reg
.end_macro

.macro pop (%reg)
  mov %reg , [$sp]
  subi $sp , $sp , 4
.end_macro

.macro mul (%rd , %rs , %rt)
  mult %rs , %rt
  mflo %rd
.end_macro

.macro div (%rd , %rs , %rt)
  div %rs , %rt
  mflo %rd
.end_macro

.macro mod (%rd , %rs , %rt)
  div %rs , %rt
  mfhi %rd
.end_macro

.macro not (%reg)
   xor %reg , %reg , b1000000000000000000000000
.end_macro

.macro  clear (%reg)
  mov %reg , 0
.end_macro

.macro ror (%reg , %inm)
  mov $at , %reg
  srlv $at , %inm
  sub %inm , 32 , %inm
  sllv %reg , %inm
  and %reg , %reg , $at
.end_macro

.macro rol (%reg , %inm)
  mov $at , %reg
  sllv $at , %inm
  sub %inm , 32 , %inm
  srlv %reg , %inm
  and %reg , %reg , $at
.end_macro









