
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
int app_init_key(){
    init_key();
    return 0;
}

__attribute__((section(".boot"))) int main(int arg0) {
c0d00000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00002:	b08f      	sub	sp, #60	; 0x3c
c0d00004:	4604      	mov	r4, r0
    }
    END_TRY;

#else
    // exit critical section
    __asm volatile("cpsie i");
c0d00006:	b662      	cpsie	i

    if (arg0) {
c0d00008:	2c00      	cmp	r4, #0
c0d0000a:	d009      	beq.n	c0d00020 <main+0x20>
        // is ID 1 ?
        if (((unsigned int *)arg0)[0] != 0x100) {
c0d0000c:	2001      	movs	r0, #1
c0d0000e:	0200      	lsls	r0, r0, #8
c0d00010:	6821      	ldr	r1, [r4, #0]
c0d00012:	4281      	cmp	r1, r0
c0d00014:	d002      	beq.n	c0d0001c <main+0x1c>
            os_lib_throw(INVALID_PARAMETER);
c0d00016:	2002      	movs	r0, #2
c0d00018:	f003 fd68 	bl	c0d03aec <os_lib_throw>
        }
        // grab the coin config structure from the first parameter
        chainConfig = (chain_config_t *)((unsigned int *)arg0)[1];
c0d0001c:	6860      	ldr	r0, [r4, #4]
c0d0001e:	e003      	b.n	c0d00028 <main+0x28>
    } else {
        chainConfig = (chain_config_t *)PIC(&C_chain_config);
c0d00020:	483f      	ldr	r0, [pc, #252]	; (c0d00120 <main+0x120>)
c0d00022:	4478      	add	r0, pc
c0d00024:	f003 fc56 	bl	c0d038d4 <pic>
c0d00028:	4937      	ldr	r1, [pc, #220]	; (c0d00108 <main+0x108>)
c0d0002a:	6008      	str	r0, [r1, #0]
    }
    // init data
    selected_account = 0;
c0d0002c:	4837      	ldr	r0, [pc, #220]	; (c0d0010c <main+0x10c>)
c0d0002e:	2400      	movs	r4, #0
c0d00030:	6004      	str	r4, [r0, #0]
    hash_tainted = 1;
c0d00032:	4837      	ldr	r0, [pc, #220]	; (c0d00110 <main+0x110>)
c0d00034:	2101      	movs	r1, #1
c0d00036:	9101      	str	r1, [sp, #4]
c0d00038:	7001      	strb	r1, [r0, #0]
    sign_tx = &(all_data[sign_data_p]);
c0d0003a:	4836      	ldr	r0, [pc, #216]	; (c0d00114 <main+0x114>)
c0d0003c:	4936      	ldr	r1, [pc, #216]	; (c0d00118 <main+0x118>)
c0d0003e:	6001      	str	r1, [r0, #0]
    
    // ensure exception will work as planned
    os_boot();
c0d00040:	f002 feaf 	bl	c0d02da2 <os_boot>
c0d00044:	4d35      	ldr	r5, [pc, #212]	; (c0d0011c <main+0x11c>)
c0d00046:	4f37      	ldr	r7, [pc, #220]	; (c0d00124 <main+0x124>)
c0d00048:	447f      	add	r7, pc

    for(;;){
c0d0004a:	9700      	str	r7, [sp, #0]

        UX_INIT();
c0d0004c:	21fc      	movs	r1, #252	; 0xfc
c0d0004e:	4628      	mov	r0, r5
c0d00050:	f006 fee8 	bl	c0d06e24 <__aeabi_memclr>
c0d00054:	f006 fd30 	bl	c0d06ab8 <ux_stack_push>
c0d00058:	ae03      	add	r6, sp, #12

        BEGIN_TRY{
            TRY {
c0d0005a:	4630      	mov	r0, r6
c0d0005c:	f006 ff86 	bl	c0d06f6c <setjmp>
c0d00060:	85b0      	strh	r0, [r6, #44]	; 0x2c
c0d00062:	b286      	uxth	r6, r0
c0d00064:	2e00      	cmp	r6, #0
c0d00066:	d00a      	beq.n	c0d0007e <main+0x7e>
c0d00068:	a803      	add	r0, sp, #12
c0d0006a:	8584      	strh	r4, [r0, #44]	; 0x2c
c0d0006c:	980d      	ldr	r0, [sp, #52]	; 0x34

                app_show(UI_MAIN);
                
                app_handle_business();
            }
            CATCH(EXCEPTION_IO_RESET) {
c0d0006e:	f003 fda3 	bl	c0d03bb8 <try_context_set>
c0d00072:	980d      	ldr	r0, [sp, #52]	; 0x34
              // reset IO and UX before continuing
              CLOSE_TRY;
c0d00074:	f003 fda0 	bl	c0d03bb8 <try_context_set>
c0d00078:	2e10      	cmp	r6, #16
c0d0007a:	d0e7      	beq.n	c0d0004c <main+0x4c>
c0d0007c:	e03f      	b.n	c0d000fe <main+0xfe>
c0d0007e:	a803      	add	r0, sp, #12
    for(;;){

        UX_INIT();

        BEGIN_TRY{
            TRY {
c0d00080:	f003 fd9a 	bl	c0d03bb8 <try_context_set>
c0d00084:	900d      	str	r0, [sp, #52]	; 0x34
                io_seproxyhal_init();
c0d00086:	f002 ffff 	bl	c0d03088 <io_seproxyhal_init>
void app_handle_business(){
    handle_business();
}

int app_init_key(){
    init_key();
c0d0008a:	f000 f9a5 	bl	c0d003d8 <init_key>
            TRY {
                io_seproxyhal_init();

                app_init_key();

                if (N_storage.initialized != 0x01) {
c0d0008e:	4638      	mov	r0, r7
c0d00090:	f003 fc20 	bl	c0d038d4 <pic>
c0d00094:	6800      	ldr	r0, [r0, #0]
c0d00096:	2801      	cmp	r0, #1
c0d00098:	d017      	beq.n	c0d000ca <main+0xca>
c0d0009a:	4625      	mov	r5, r4
c0d0009c:	9c01      	ldr	r4, [sp, #4]
                    int x;
                    x = 1;
c0d0009e:	9402      	str	r4, [sp, #8]
                    nvm_write(&N_storage.account_number, (void*)&x, sizeof(int));
c0d000a0:	4638      	mov	r0, r7
c0d000a2:	f003 fc17 	bl	c0d038d4 <pic>
c0d000a6:	1d00      	adds	r0, r0, #4
c0d000a8:	ae02      	add	r6, sp, #8
c0d000aa:	2704      	movs	r7, #4
c0d000ac:	4631      	mov	r1, r6
c0d000ae:	463a      	mov	r2, r7
c0d000b0:	f003 fc3e 	bl	c0d03930 <nvm_write>
                    x = 1;
c0d000b4:	9402      	str	r4, [sp, #8]
c0d000b6:	462c      	mov	r4, r5
c0d000b8:	4d18      	ldr	r5, [pc, #96]	; (c0d0011c <main+0x11c>)
                    nvm_write(&N_storage.initialized, (void*)&x, sizeof(int));
c0d000ba:	9800      	ldr	r0, [sp, #0]
c0d000bc:	f003 fc0a 	bl	c0d038d4 <pic>
c0d000c0:	4631      	mov	r1, r6
c0d000c2:	463a      	mov	r2, r7
c0d000c4:	9f00      	ldr	r7, [sp, #0]
c0d000c6:	f003 fc33 	bl	c0d03930 <nvm_write>
c0d000ca:	2600      	movs	r6, #0
                    // restart IOs
                    BLE_power(1, NULL);
                }
    #endif

                USB_power(0);
c0d000cc:	4630      	mov	r0, r6
c0d000ce:	f006 fc47 	bl	c0d06960 <USB_power>
                USB_power(1);
c0d000d2:	2001      	movs	r0, #1
c0d000d4:	f006 fc44 	bl	c0d06960 <USB_power>
    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

void app_show(enum ui_state_e state){
    show(state);
c0d000d8:	4630      	mov	r0, r6
c0d000da:	f004 fc91 	bl	c0d04a00 <show>
}

void app_handle_business(){
    handle_business();
c0d000de:	f000 f983 	bl	c0d003e8 <handle_business>
            }
            CATCH_ALL {
              CLOSE_TRY;             
              break;
            }
            FINALLY {
c0d000e2:	f003 fd5d 	bl	c0d03ba0 <try_context_get>
c0d000e6:	a903      	add	r1, sp, #12
c0d000e8:	4288      	cmp	r0, r1
c0d000ea:	d102      	bne.n	c0d000f2 <main+0xf2>
c0d000ec:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d000ee:	f003 fd63 	bl	c0d03bb8 <try_context_set>
c0d000f2:	a803      	add	r0, sp, #12
            }
        }

        END_TRY;
c0d000f4:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d000f6:	2800      	cmp	r0, #0
c0d000f8:	d0a8      	beq.n	c0d0004c <main+0x4c>
c0d000fa:	f002 fe92 	bl	c0d02e22 <os_longjmp>
    }
    app_exit();
c0d000fe:	f000 fb2d 	bl	c0d0075c <app_exit>
#endif
    return 0;
c0d00102:	2000      	movs	r0, #0
c0d00104:	b00f      	add	sp, #60	; 0x3c
c0d00106:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00108:	20001f6c 	.word	0x20001f6c
c0d0010c:	20001d20 	.word	0x20001d20
c0d00110:	20001ca8 	.word	0x20001ca8
c0d00114:	20001d1c 	.word	0x20001d1c
c0d00118:	20001800 	.word	0x20001800
c0d0011c:	20001e70 	.word	0x20001e70
c0d00120:	000070ba 	.word	0x000070ba
c0d00124:	00007bb4 	.word	0x00007bb4

c0d00128 <btchip_encode_base58>:
  *outlen = length;
  return 0;
}

int btchip_encode_base58(const unsigned char *in, size_t length,
                         unsigned char *out, size_t outlen, const unsigned char *cache) {
c0d00128:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0012a:	b089      	sub	sp, #36	; 0x24
c0d0012c:	461d      	mov	r5, r3
c0d0012e:	4614      	mov	r4, r2
c0d00130:	460f      	mov	r7, r1
c0d00132:	9007      	str	r0, [sp, #28]
c0d00134:	9e0e      	ldr	r6, [sp, #56]	; 0x38
  // unsigned char buffer_58[MAX_ENC_INPUT_SIZE * 138 / 100 + 1];

  unsigned char *buffer_58 = cache;

  for(int index = 0; index < MAX_ENC_INPUT_SIZE * 138 / 100 + 1; index++){
    buffer_58[index] = 0;
c0d00136:	21a6      	movs	r1, #166	; 0xa6
c0d00138:	4630      	mov	r0, r6
c0d0013a:	f006 fe73 	bl	c0d06e24 <__aeabi_memclr>
c0d0013e:	2001      	movs	r0, #1
c0d00140:	43c0      	mvns	r0, r0
  size_t i = 0, j;
  size_t startAt, stopAt;
  size_t zeroCount = 0;
  size_t outputSize;

  if (length > MAX_ENC_INPUT_SIZE) {
c0d00142:	2f78      	cmp	r7, #120	; 0x78
c0d00144:	d86b      	bhi.n	c0d0021e <btchip_encode_base58+0xf6>
c0d00146:	9002      	str	r0, [sp, #8]
c0d00148:	2200      	movs	r2, #0
  }

  PRINTF("Length to encode %d\n", length);
  PRINTF("To encode\n%.*H\n",length,in);

  while ((zeroCount < length) && (in[zeroCount] == 0)) {
c0d0014a:	2f00      	cmp	r7, #0
c0d0014c:	d007      	beq.n	c0d0015e <btchip_encode_base58+0x36>
c0d0014e:	2200      	movs	r2, #0
c0d00150:	9807      	ldr	r0, [sp, #28]
c0d00152:	5c80      	ldrb	r0, [r0, r2]
c0d00154:	2800      	cmp	r0, #0
c0d00156:	d102      	bne.n	c0d0015e <btchip_encode_base58+0x36>
    ++zeroCount;
c0d00158:	1c52      	adds	r2, r2, #1
  }

  PRINTF("Length to encode %d\n", length);
  PRINTF("To encode\n%.*H\n",length,in);

  while ((zeroCount < length) && (in[zeroCount] == 0)) {
c0d0015a:	42ba      	cmp	r2, r7
c0d0015c:	d3f8      	bcc.n	c0d00150 <btchip_encode_base58+0x28>
c0d0015e:	9500      	str	r5, [sp, #0]
c0d00160:	9401      	str	r4, [sp, #4]
    ++zeroCount;
  }

  outputSize = (length - zeroCount) * 138 / 100 + 1;
c0d00162:	1ab9      	subs	r1, r7, r2
c0d00164:	208a      	movs	r0, #138	; 0x8a
c0d00166:	4348      	muls	r0, r1
c0d00168:	2164      	movs	r1, #100	; 0x64
c0d0016a:	4614      	mov	r4, r2
c0d0016c:	f006 fcb8 	bl	c0d06ae0 <__aeabi_uidiv>
c0d00170:	9006      	str	r0, [sp, #24]
c0d00172:	1c40      	adds	r0, r0, #1
c0d00174:	9003      	str	r0, [sp, #12]
c0d00176:	9404      	str	r4, [sp, #16]
  stopAt = outputSize - 1;
  for (startAt = zeroCount; startAt < length; startAt++) {
c0d00178:	42bc      	cmp	r4, r7
c0d0017a:	d224      	bcs.n	c0d001c6 <btchip_encode_base58+0x9e>
c0d0017c:	9906      	ldr	r1, [sp, #24]
c0d0017e:	9a04      	ldr	r2, [sp, #16]
c0d00180:	9705      	str	r7, [sp, #20]
    int carry = in[startAt];
c0d00182:	9807      	ldr	r0, [sp, #28]
c0d00184:	9208      	str	r2, [sp, #32]
c0d00186:	5c80      	ldrb	r0, [r0, r2]
c0d00188:	1e4d      	subs	r5, r1, #1
c0d0018a:	9f06      	ldr	r7, [sp, #24]
    for (j = outputSize - 1; (int)j >= 0; j--) {
      carry += 256 * buffer_58[j];
c0d0018c:	5df1      	ldrb	r1, [r6, r7]
c0d0018e:	0209      	lsls	r1, r1, #8
c0d00190:	180c      	adds	r4, r1, r0
      buffer_58[j] = carry % 58;
c0d00192:	213a      	movs	r1, #58	; 0x3a
c0d00194:	4620      	mov	r0, r4
c0d00196:	f006 fe13 	bl	c0d06dc0 <__aeabi_idivmod>
c0d0019a:	55f1      	strb	r1, [r6, r7]
      carry /= 58;

      if (j <= stopAt - 1 && carry == 0) {
c0d0019c:	4620      	mov	r0, r4
c0d0019e:	3039      	adds	r0, #57	; 0x39
c0d001a0:	42af      	cmp	r7, r5
c0d001a2:	d801      	bhi.n	c0d001a8 <btchip_encode_base58+0x80>
c0d001a4:	2873      	cmp	r0, #115	; 0x73
c0d001a6:	d308      	bcc.n	c0d001ba <btchip_encode_base58+0x92>
  for (startAt = zeroCount; startAt < length; startAt++) {
    int carry = in[startAt];
    for (j = outputSize - 1; (int)j >= 0; j--) {
      carry += 256 * buffer_58[j];
      buffer_58[j] = carry % 58;
      carry /= 58;
c0d001a8:	213a      	movs	r1, #58	; 0x3a
c0d001aa:	4620      	mov	r0, r4
c0d001ac:	f006 fd22 	bl	c0d06bf4 <__aeabi_idiv>

  outputSize = (length - zeroCount) * 138 / 100 + 1;
  stopAt = outputSize - 1;
  for (startAt = zeroCount; startAt < length; startAt++) {
    int carry = in[startAt];
    for (j = outputSize - 1; (int)j >= 0; j--) {
c0d001b0:	1e79      	subs	r1, r7, #1
c0d001b2:	2f00      	cmp	r7, #0
c0d001b4:	460f      	mov	r7, r1
c0d001b6:	dce9      	bgt.n	c0d0018c <btchip_encode_base58+0x64>
c0d001b8:	e000      	b.n	c0d001bc <btchip_encode_base58+0x94>
c0d001ba:	4639      	mov	r1, r7
c0d001bc:	9a08      	ldr	r2, [sp, #32]
    ++zeroCount;
  }

  outputSize = (length - zeroCount) * 138 / 100 + 1;
  stopAt = outputSize - 1;
  for (startAt = zeroCount; startAt < length; startAt++) {
c0d001be:	1c52      	adds	r2, r2, #1
c0d001c0:	9f05      	ldr	r7, [sp, #20]
c0d001c2:	42ba      	cmp	r2, r7
c0d001c4:	d1dd      	bne.n	c0d00182 <btchip_encode_base58+0x5a>
c0d001c6:	2400      	movs	r4, #0
c0d001c8:	9f01      	ldr	r7, [sp, #4]
c0d001ca:	9900      	ldr	r1, [sp, #0]
c0d001cc:	9d04      	ldr	r5, [sp, #16]
c0d001ce:	9b03      	ldr	r3, [sp, #12]
    }
    stopAt = j;
  }

  j = 0;
  while (j < outputSize && buffer_58[j] == 0) {
c0d001d0:	5d30      	ldrb	r0, [r6, r4]
c0d001d2:	2800      	cmp	r0, #0
c0d001d4:	d102      	bne.n	c0d001dc <btchip_encode_base58+0xb4>
    j += 1;
c0d001d6:	1c64      	adds	r4, r4, #1
    }
    stopAt = j;
  }

  j = 0;
  while (j < outputSize && buffer_58[j] == 0) {
c0d001d8:	429c      	cmp	r4, r3
c0d001da:	d3f9      	bcc.n	c0d001d0 <btchip_encode_base58+0xa8>
    j += 1;
  }

  if (outlen < zeroCount + outputSize - j) {
c0d001dc:	1958      	adds	r0, r3, r5
c0d001de:	1b00      	subs	r0, r0, r4
c0d001e0:	4288      	cmp	r0, r1
c0d001e2:	d905      	bls.n	c0d001f0 <btchip_encode_base58+0xc8>
    // *outlen = zeroCount + outputSize - j;
    out[0] = zeroCount;
c0d001e4:	703d      	strb	r5, [r7, #0]
    out[1] = outputSize;
c0d001e6:	707b      	strb	r3, [r7, #1]
    out[2] = j;
c0d001e8:	70bc      	strb	r4, [r7, #2]
c0d001ea:	9802      	ldr	r0, [sp, #8]
c0d001ec:	1c40      	adds	r0, r0, #1
c0d001ee:	e016      	b.n	c0d0021e <btchip_encode_base58+0xf6>
    return -1;
  }

  os_memset(out, BASE58ALPHABET[0], zeroCount);
c0d001f0:	2131      	movs	r1, #49	; 0x31
c0d001f2:	4638      	mov	r0, r7
c0d001f4:	462a      	mov	r2, r5
c0d001f6:	f002 fdf4 	bl	c0d02de2 <os_memset>
c0d001fa:	9a03      	ldr	r2, [sp, #12]
c0d001fc:	2000      	movs	r0, #0

  i = zeroCount;
  while (j < outputSize) {
c0d001fe:	4294      	cmp	r4, r2
c0d00200:	d20d      	bcs.n	c0d0021e <btchip_encode_base58+0xf6>
c0d00202:	9002      	str	r0, [sp, #8]
    out[i++] = BASE58ALPHABET[buffer_58[j++]];
c0d00204:	1978      	adds	r0, r7, r5
c0d00206:	1931      	adds	r1, r6, r4
c0d00208:	1b12      	subs	r2, r2, r4
c0d0020a:	4c06      	ldr	r4, [pc, #24]	; (c0d00224 <btchip_encode_base58+0xfc>)
c0d0020c:	447c      	add	r4, pc
c0d0020e:	780b      	ldrb	r3, [r1, #0]
c0d00210:	5ce3      	ldrb	r3, [r4, r3]
c0d00212:	7003      	strb	r3, [r0, #0]
  }

  os_memset(out, BASE58ALPHABET[0], zeroCount);

  i = zeroCount;
  while (j < outputSize) {
c0d00214:	1c40      	adds	r0, r0, #1
c0d00216:	1c49      	adds	r1, r1, #1
c0d00218:	1e52      	subs	r2, r2, #1
c0d0021a:	d1f8      	bne.n	c0d0020e <btchip_encode_base58+0xe6>
c0d0021c:	9802      	ldr	r0, [sp, #8]
  }
  // // *outlen = i;
  // PRINTF("Length encoded %d\n", i);
  // PRINTF("Encoded\n%.*H\n",i,out);
  return 0;
}
c0d0021e:	b009      	add	sp, #36	; 0x24
c0d00220:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00222:	46c0      	nop			; (mov r8, r8)
c0d00224:	00006e90 	.word	0x00006e90

c0d00228 <get_address>:
union {
    cx_sha512_t shasha;
    cx_ripemd160_t riprip;
} u;

int get_address(int num, char *output){
c0d00228:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0022a:	b083      	sub	sp, #12
c0d0022c:	9102      	str	r1, [sp, #8]
    os_perso_derive_node_bip32(CX_CURVE_256K1, key_path, 5,
                               private_component, NULL);
    cx_ecdsa_init_private_key(CX_CURVE_256K1, private_component, 32, &private_key);
    
    // io_seproxyhal_io_heartbeat();
    cx_ecfp_generate_pair(CX_CURVE_256K1, &public_key, &private_key, 1);
c0d0022e:	2401      	movs	r4, #1

int get_address(int num, char *output){

    // char address_cache[38];
    
    key_path[0] = 44 | 0x80000000;
c0d00230:	07e2      	lsls	r2, r4, #31
c0d00232:	4613      	mov	r3, r2
c0d00234:	332c      	adds	r3, #44	; 0x2c
c0d00236:	4912      	ldr	r1, [pc, #72]	; (c0d00280 <get_address+0x58>)
c0d00238:	600b      	str	r3, [r1, #0]
    key_path[1] = 34952 | 0x80000000;
c0d0023a:	4b12      	ldr	r3, [pc, #72]	; (c0d00284 <get_address+0x5c>)
c0d0023c:	604b      	str	r3, [r1, #4]
    key_path[2] = 0 | 0x80000000;
c0d0023e:	608a      	str	r2, [r1, #8]
c0d00240:	2200      	movs	r2, #0
    key_path[3] = 0;
c0d00242:	60ca      	str	r2, [r1, #12]
    key_path[4] = num;
c0d00244:	6108      	str	r0, [r1, #16]

    // cx_ecfp_private_key_t private_key_cache;
    // cx_ecfp_public_key_t public_key_cache;

    // io_seproxyhal_io_heartbeat();
    os_perso_derive_node_bip32(CX_CURVE_256K1, key_path, 5,
c0d00246:	4668      	mov	r0, sp
c0d00248:	6002      	str	r2, [r0, #0]
c0d0024a:	2621      	movs	r6, #33	; 0x21
c0d0024c:	2205      	movs	r2, #5
c0d0024e:	4f0e      	ldr	r7, [pc, #56]	; (c0d00288 <get_address+0x60>)
c0d00250:	4630      	mov	r0, r6
c0d00252:	463b      	mov	r3, r7
c0d00254:	f003 fc14 	bl	c0d03a80 <os_perso_derive_node_bip32>
                               private_component, NULL);
    cx_ecdsa_init_private_key(CX_CURVE_256K1, private_component, 32, &private_key);
c0d00258:	2220      	movs	r2, #32
c0d0025a:	4d0c      	ldr	r5, [pc, #48]	; (c0d0028c <get_address+0x64>)
c0d0025c:	4630      	mov	r0, r6
c0d0025e:	4639      	mov	r1, r7
c0d00260:	462b      	mov	r3, r5
c0d00262:	f003 fbb9 	bl	c0d039d8 <cx_ecfp_init_private_key>
    
    // io_seproxyhal_io_heartbeat();
    cx_ecfp_generate_pair(CX_CURVE_256K1, &public_key, &private_key, 1);
c0d00266:	490a      	ldr	r1, [pc, #40]	; (c0d00290 <get_address+0x68>)
c0d00268:	4630      	mov	r0, r6
c0d0026a:	462a      	mov	r2, r5
c0d0026c:	4623      	mov	r3, r4
c0d0026e:	f003 fbc3 	bl	c0d039f8 <cx_ecfp_generate_pair>

    return public_key_hash160(public_key.W, 65, output);
c0d00272:	9802      	ldr	r0, [sp, #8]
c0d00274:	f000 f80e 	bl	c0d00294 <public_key_hash160>
c0d00278:	4620      	mov	r0, r4
c0d0027a:	b003      	add	sp, #12
c0d0027c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0027e:	46c0      	nop			; (mov r8, r8)
c0d00280:	20001c00 	.word	0x20001c00
c0d00284:	80008888 	.word	0x80008888
c0d00288:	20001c14 	.word	0x20001c14
c0d0028c:	20001c34 	.word	0x20001c34
c0d00290:	20001c5c 	.word	0x20001c5c

c0d00294 <public_key_hash160>:
    set_key(0);
    return 0;
}

static int public_key_hash160(unsigned char *in, unsigned short inlen,
                               unsigned char *out) {
c0d00294:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00296:	b081      	sub	sp, #4
c0d00298:	4604      	mov	r4, r0
    unsigned char *buffer4 = &(all_data[100]);
    unsigned char *address = &(all_data[130]);
    unsigned char *buffer_58 = &(all_data[170]);

    // io_seproxyhal_io_heartbeat();
    cx_sha512_init(&u.shasha);
c0d0029a:	4e31      	ldr	r6, [pc, #196]	; (c0d00360 <public_key_hash160+0xcc>)
c0d0029c:	4630      	mov	r0, r6
c0d0029e:	f003 fb8f 	bl	c0d039c0 <cx_sha512_init>
    cx_hash(&u.shasha.header, CX_LAST, in, inlen, buffer1);
c0d002a2:	4d30      	ldr	r5, [pc, #192]	; (c0d00364 <public_key_hash160+0xd0>)
c0d002a4:	4668      	mov	r0, sp
c0d002a6:	6005      	str	r5, [r0, #0]
c0d002a8:	4a2f      	ldr	r2, [pc, #188]	; (c0d00368 <public_key_hash160+0xd4>)
c0d002aa:	3208      	adds	r2, #8
c0d002ac:	2701      	movs	r7, #1
c0d002ae:	2341      	movs	r3, #65	; 0x41
c0d002b0:	4630      	mov	r0, r6
c0d002b2:	4639      	mov	r1, r7
c0d002b4:	f000 f9c8 	bl	c0d00648 <cx_hash_X>

    // io_seproxyhal_io_heartbeat();
    cx_ripemd160_init(&u.riprip);
c0d002b8:	4630      	mov	r0, r6
c0d002ba:	f003 fb69 	bl	c0d03990 <cx_ripemd160_init>
    cx_hash(&u.riprip.header, CX_LAST, buffer1, 32, buffer2);
c0d002be:	462e      	mov	r6, r5
c0d002c0:	3628      	adds	r6, #40	; 0x28
c0d002c2:	4668      	mov	r0, sp
c0d002c4:	6006      	str	r6, [r0, #0]
c0d002c6:	2320      	movs	r3, #32
c0d002c8:	4825      	ldr	r0, [pc, #148]	; (c0d00360 <public_key_hash160+0xcc>)
c0d002ca:	4639      	mov	r1, r7
c0d002cc:	462a      	mov	r2, r5
c0d002ce:	f000 f9bb 	bl	c0d00648 <cx_hash_X>
c0d002d2:	4823      	ldr	r0, [pc, #140]	; (c0d00360 <public_key_hash160+0xcc>)

    // io_seproxyhal_io_heartbeat();
    cx_ripemd160_init(&u.riprip);
c0d002d4:	f003 fb5c 	bl	c0d03990 <cx_ripemd160_init>
    cx_hash(&u.riprip.header, CX_LAST, buffer2, 20, buffer3);
c0d002d8:	4628      	mov	r0, r5
c0d002da:	3046      	adds	r0, #70	; 0x46
c0d002dc:	4669      	mov	r1, sp
c0d002de:	6008      	str	r0, [r1, #0]
c0d002e0:	2314      	movs	r3, #20
c0d002e2:	481f      	ldr	r0, [pc, #124]	; (c0d00360 <public_key_hash160+0xcc>)
c0d002e4:	4639      	mov	r1, r7
c0d002e6:	4632      	mov	r2, r6
c0d002e8:	f000 f9ae 	bl	c0d00648 <cx_hash_X>
c0d002ec:	2028      	movs	r0, #40	; 0x28

    // io_seproxyhal_io_heartbeat();
    for (size_t i = 0; i < 20; ++i) {
        buffer4[i] = buffer2[i];
c0d002ee:	5c29      	ldrb	r1, [r5, r0]
c0d002f0:	182a      	adds	r2, r5, r0
c0d002f2:	233c      	movs	r3, #60	; 0x3c
c0d002f4:	54d1      	strb	r1, [r2, r3]
    // io_seproxyhal_io_heartbeat();
    cx_ripemd160_init(&u.riprip);
    cx_hash(&u.riprip.header, CX_LAST, buffer2, 20, buffer3);

    // io_seproxyhal_io_heartbeat();
    for (size_t i = 0; i < 20; ++i) {
c0d002f6:	1c40      	adds	r0, r0, #1
c0d002f8:	283c      	cmp	r0, #60	; 0x3c
c0d002fa:	d1f8      	bne.n	c0d002ee <public_key_hash160+0x5a>
        buffer4[i] = buffer2[i];
    }
    buffer4[20] = buffer3[0];
c0d002fc:	2046      	movs	r0, #70	; 0x46
c0d002fe:	5c28      	ldrb	r0, [r5, r0]
c0d00300:	2178      	movs	r1, #120	; 0x78
c0d00302:	5468      	strb	r0, [r5, r1]
    buffer4[21] = buffer3[1];
c0d00304:	2047      	movs	r0, #71	; 0x47
c0d00306:	5c28      	ldrb	r0, [r5, r0]
c0d00308:	2179      	movs	r1, #121	; 0x79
c0d0030a:	5468      	strb	r0, [r5, r1]
    buffer4[22] = buffer3[2];
c0d0030c:	2048      	movs	r0, #72	; 0x48
c0d0030e:	5c28      	ldrb	r0, [r5, r0]
c0d00310:	217a      	movs	r1, #122	; 0x7a
c0d00312:	5468      	strb	r0, [r5, r1]
    buffer4[23] = buffer3[3];
c0d00314:	2049      	movs	r0, #73	; 0x49
c0d00316:	5c28      	ldrb	r0, [r5, r0]
c0d00318:	217b      	movs	r1, #123	; 0x7b
c0d0031a:	5468      	strb	r0, [r5, r1]

    // int respon = btchip_encode_base58((const char *) buffer4, 24, address, 34, buffer_58);
    int respon = btchip_encode_base58(buffer4, 24, address, 34, buffer_58);
c0d0031c:	4628      	mov	r0, r5
c0d0031e:	30aa      	adds	r0, #170	; 0xaa
c0d00320:	4669      	mov	r1, sp
c0d00322:	6008      	str	r0, [r1, #0]
c0d00324:	4628      	mov	r0, r5
c0d00326:	3064      	adds	r0, #100	; 0x64
c0d00328:	462a      	mov	r2, r5
c0d0032a:	3282      	adds	r2, #130	; 0x82
c0d0032c:	2118      	movs	r1, #24
c0d0032e:	2322      	movs	r3, #34	; 0x22
c0d00330:	f7ff fefa 	bl	c0d00128 <btchip_encode_base58>
    // char *cache_buffer = get_cache_buffer();
    // cache_buffer[0] = '/';
    // cache_buffer[1] = respon + 65;
    // cache_buffer[2] = '/';
            
    if (respon < 0) {
c0d00334:	2800      	cmp	r0, #0
c0d00336:	db10      	blt.n	c0d0035a <public_key_hash160+0xc6>
    //     }
        // THROW(EXCEPTION);
        return 1;
    }

    out[0] = 'B';
c0d00338:	2042      	movs	r0, #66	; 0x42
c0d0033a:	7020      	strb	r0, [r4, #0]
    out[1] = 'T';
c0d0033c:	2054      	movs	r0, #84	; 0x54
c0d0033e:	7060      	strb	r0, [r4, #1]
    out[2] = 'T';
c0d00340:	70a0      	strb	r0, [r4, #2]
c0d00342:	2082      	movs	r0, #130	; 0x82
    // cache_buffer[3] = 'B';
    // cache_buffer[4] = 'T';
    // cache_buffer[5] = 'T';
    size_t j;
    for (j = 0; j < 34; j++) {
        out[j + 3] = address[j];
c0d00344:	5c29      	ldrb	r1, [r5, r0]
c0d00346:	1822      	adds	r2, r4, r0
c0d00348:	237e      	movs	r3, #126	; 0x7e
c0d0034a:	43db      	mvns	r3, r3
c0d0034c:	54d1      	strb	r1, [r2, r3]
    out[2] = 'T';
    // cache_buffer[3] = 'B';
    // cache_buffer[4] = 'T';
    // cache_buffer[5] = 'T';
    size_t j;
    for (j = 0; j < 34; j++) {
c0d0034e:	1c40      	adds	r0, r0, #1
c0d00350:	28a4      	cmp	r0, #164	; 0xa4
c0d00352:	d1f7      	bne.n	c0d00344 <public_key_hash160+0xb0>
        out[j + 3] = address[j];
        // cache_buffer[j + 6] = address[j];
    }
    out[j + 3] = '\0';
c0d00354:	2025      	movs	r0, #37	; 0x25
c0d00356:	2100      	movs	r1, #0
c0d00358:	5421      	strb	r1, [r4, r0]
c0d0035a:	b001      	add	sp, #4
c0d0035c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0035e:	46c0      	nop			; (mov r8, r8)
c0d00360:	20001d24 	.word	0x20001d24
c0d00364:	20001800 	.word	0x20001800
c0d00368:	20001c5c 	.word	0x20001c5c

c0d0036c <set_key>:
    // io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);

    // return 0;
}

int set_key(int num){
c0d0036c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0036e:	b081      	sub	sp, #4
    os_perso_derive_node_bip32(CX_CURVE_256K1, key_path, 5,
                               private_component, NULL);    
    cx_ecdsa_init_private_key(CX_CURVE_256K1, private_component, 32, &private_key);
    
    // io_seproxyhal_io_heartbeat();
    cx_ecfp_generate_pair(CX_CURVE_256K1, &public_key, &private_key, 1);
c0d00370:	2401      	movs	r4, #1
    // return 0;
}

int set_key(int num){

    key_path[0] = 44 | 0x80000000;
c0d00372:	07e2      	lsls	r2, r4, #31
c0d00374:	4613      	mov	r3, r2
c0d00376:	332c      	adds	r3, #44	; 0x2c
c0d00378:	4911      	ldr	r1, [pc, #68]	; (c0d003c0 <set_key+0x54>)
c0d0037a:	600b      	str	r3, [r1, #0]
    key_path[1] = 34952 | 0x80000000;
c0d0037c:	4b11      	ldr	r3, [pc, #68]	; (c0d003c4 <set_key+0x58>)
c0d0037e:	604b      	str	r3, [r1, #4]
    key_path[2] = 0 | 0x80000000;
c0d00380:	608a      	str	r2, [r1, #8]
c0d00382:	2500      	movs	r5, #0
    key_path[3] = 0;
c0d00384:	60cd      	str	r5, [r1, #12]
    key_path[4] = num;
c0d00386:	6108      	str	r0, [r1, #16]

    os_perso_derive_node_bip32(CX_CURVE_256K1, key_path, 5,
c0d00388:	4668      	mov	r0, sp
c0d0038a:	6005      	str	r5, [r0, #0]
c0d0038c:	2621      	movs	r6, #33	; 0x21
c0d0038e:	2205      	movs	r2, #5
c0d00390:	4f0d      	ldr	r7, [pc, #52]	; (c0d003c8 <set_key+0x5c>)
c0d00392:	4630      	mov	r0, r6
c0d00394:	463b      	mov	r3, r7
c0d00396:	f003 fb73 	bl	c0d03a80 <os_perso_derive_node_bip32>
                               private_component, NULL);    
    cx_ecdsa_init_private_key(CX_CURVE_256K1, private_component, 32, &private_key);
c0d0039a:	2220      	movs	r2, #32
c0d0039c:	4b0b      	ldr	r3, [pc, #44]	; (c0d003cc <set_key+0x60>)
c0d0039e:	4630      	mov	r0, r6
c0d003a0:	4639      	mov	r1, r7
c0d003a2:	461f      	mov	r7, r3
c0d003a4:	f003 fb18 	bl	c0d039d8 <cx_ecfp_init_private_key>
    
    // io_seproxyhal_io_heartbeat();
    cx_ecfp_generate_pair(CX_CURVE_256K1, &public_key, &private_key, 1);
c0d003a8:	4909      	ldr	r1, [pc, #36]	; (c0d003d0 <set_key+0x64>)
c0d003aa:	4630      	mov	r0, r6
c0d003ac:	463a      	mov	r2, r7
c0d003ae:	4623      	mov	r3, r4
c0d003b0:	f003 fb22 	bl	c0d039f8 <cx_ecfp_generate_pair>

    public_key_hash160(public_key.W, 65, (char *) ui_address);
c0d003b4:	4807      	ldr	r0, [pc, #28]	; (c0d003d4 <set_key+0x68>)
c0d003b6:	f7ff ff6d 	bl	c0d00294 <public_key_hash160>
    return 0;
c0d003ba:	4628      	mov	r0, r5
c0d003bc:	b001      	add	sp, #4
c0d003be:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d003c0:	20001c00 	.word	0x20001c00
c0d003c4:	80008888 	.word	0x80008888
c0d003c8:	20001c14 	.word	0x20001c14
c0d003cc:	20001c34 	.word	0x20001c34
c0d003d0:	20001c5c 	.word	0x20001c5c
c0d003d4:	20001b58 	.word	0x20001b58

c0d003d8 <init_key>:
}

int init_key() {
c0d003d8:	b510      	push	{r4, lr}
    set_key(0);
c0d003da:	2400      	movs	r4, #0
c0d003dc:	4620      	mov	r0, r4
c0d003de:	f7ff ffc5 	bl	c0d0036c <set_key>
    return 0;
c0d003e2:	4620      	mov	r0, r4
c0d003e4:	bd10      	pop	{r4, pc}
	...

c0d003e8 <handle_business>:
    // cache_buffer[j + 6] = '\0';

    return 1;
}

void handle_business(void){
c0d003e8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d003ea:	b091      	sub	sp, #68	; 0x44
c0d003ec:	2700      	movs	r7, #0
    volatile unsigned int rx = 0;
c0d003ee:	9710      	str	r7, [sp, #64]	; 0x40
    volatile unsigned int txi = 0;
c0d003f0:	970f      	str	r7, [sp, #60]	; 0x3c
    volatile unsigned int flags = 0;
c0d003f2:	970e      	str	r7, [sp, #56]	; 0x38

    // next timer callback in 500 ms
    UX_CALLBACK_SET_INTERVAL(500);
c0d003f4:	207d      	movs	r0, #125	; 0x7d
c0d003f6:	0080      	lsls	r0, r0, #2
c0d003f8:	497b      	ldr	r1, [pc, #492]	; (c0d005e8 <handle_business+0x200>)
c0d003fa:	63c8      	str	r0, [r1, #60]	; 0x3c
c0d003fc:	4e7d      	ldr	r6, [pc, #500]	; (c0d005f4 <handle_business+0x20c>)
c0d003fe:	e049      	b.n	c0d00494 <handle_business+0xac>
                        
                    }

                    case CHOOSE_ADDRESS:{
                        
                        account_number = G_io_apdu_buffer[5];
c0d00400:	7975      	ldrb	r5, [r6, #5]

                        if(account_number < N_storage.account_number){
c0d00402:	4884      	ldr	r0, [pc, #528]	; (c0d00614 <handle_business+0x22c>)
c0d00404:	4478      	add	r0, pc
c0d00406:	f003 fa65 	bl	c0d038d4 <pic>
c0d0040a:	6840      	ldr	r0, [r0, #4]
c0d0040c:	4285      	cmp	r5, r0
c0d0040e:	db00      	blt.n	c0d00412 <handle_business+0x2a>
c0d00410:	e0e3      	b.n	c0d005da <handle_business+0x1f2>
                            confirm_account = account_number;
c0d00412:	4879      	ldr	r0, [pc, #484]	; (c0d005f8 <handle_business+0x210>)
c0d00414:	6005      	str	r5, [r0, #0]
                            set_key(confirm_account);
c0d00416:	4628      	mov	r0, r5
c0d00418:	f7ff ffa8 	bl	c0d0036c <set_key>
                            show(UI_CONFIRM_ACCOUNT);
c0d0041c:	2007      	movs	r0, #7
c0d0041e:	e032      	b.n	c0d00486 <handle_business+0x9e>
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d00420:	4873      	ldr	r0, [pc, #460]	; (c0d005f0 <handle_business+0x208>)
c0d00422:	4004      	ands	r4, r0
c0d00424:	200d      	movs	r0, #13
c0d00426:	02c0      	lsls	r0, r0, #11
c0d00428:	4320      	orrs	r0, r4
c0d0042a:	a90d      	add	r1, sp, #52	; 0x34
c0d0042c:	8008      	strh	r0, [r1, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[txi] = sw >> 8;
c0d0042e:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d00430:	0a00      	lsrs	r0, r0, #8
c0d00432:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d00434:	5470      	strb	r0, [r6, r1]
                G_io_apdu_buffer[txi + 1] = sw;
c0d00436:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d00438:	990f      	ldr	r1, [sp, #60]	; 0x3c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[txi] = sw >> 8;
c0d0043a:	1871      	adds	r1, r6, r1
                G_io_apdu_buffer[txi + 1] = sw;
c0d0043c:	7048      	strb	r0, [r1, #1]
                txi += 2;
c0d0043e:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d00440:	1c80      	adds	r0, r0, #2
c0d00442:	900f      	str	r0, [sp, #60]	; 0x3c
            }
            FINALLY {
c0d00444:	f003 fbac 	bl	c0d03ba0 <try_context_get>
c0d00448:	a901      	add	r1, sp, #4
c0d0044a:	4288      	cmp	r0, r1
c0d0044c:	d102      	bne.n	c0d00454 <handle_business+0x6c>
c0d0044e:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00450:	f003 fbb2 	bl	c0d03bb8 <try_context_set>
c0d00454:	a801      	add	r0, sp, #4
            }
        }
        END_TRY;
c0d00456:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00458:	2800      	cmp	r0, #0
c0d0045a:	d01b      	beq.n	c0d00494 <handle_business+0xac>
c0d0045c:	e08b      	b.n	c0d00576 <handle_business+0x18e>
c0d0045e:	2909      	cmp	r1, #9
c0d00460:	dc09      	bgt.n	c0d00476 <handle_business+0x8e>
c0d00462:	2908      	cmp	r1, #8
c0d00464:	d000      	beq.n	c0d00468 <handle_business+0x80>
c0d00466:	e08f      	b.n	c0d00588 <handle_business+0x1a0>
                        THROW(0x9000);
                    }break;

                    case TX_SIGN_PRE_MESSAGE:{

                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d00468:	7930      	ldrb	r0, [r6, #4]
c0d0046a:	1830      	adds	r0, r6, r0
c0d0046c:	2100      	movs	r1, #0
c0d0046e:	7141      	strb	r1, [r0, #5]

                        display_tx_pre_part();
c0d00470:	f005 f898 	bl	c0d055a4 <display_tx_pre_part>
c0d00474:	e7e6      	b.n	c0d00444 <handle_business+0x5c>
c0d00476:	290a      	cmp	r1, #10
c0d00478:	d000      	beq.n	c0d0047c <handle_business+0x94>
c0d0047a:	e0b0      	b.n	c0d005de <handle_business+0x1f6>

                    case TX_SIGN:{
                        
                        // Wait for the UI to be completed
                        
                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d0047c:	7930      	ldrb	r0, [r6, #4]
c0d0047e:	1830      	adds	r0, r6, r0
c0d00480:	2100      	movs	r1, #0
c0d00482:	7141      	strb	r1, [r0, #5]

                        show(UI_SIGN_TX);
c0d00484:	2008      	movs	r0, #8
c0d00486:	f004 fabb 	bl	c0d04a00 <show>
c0d0048a:	2010      	movs	r0, #16
c0d0048c:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0048e:	4301      	orrs	r1, r0
c0d00490:	910e      	str	r1, [sp, #56]	; 0x38
c0d00492:	e7d7      	b.n	c0d00444 <handle_business+0x5c>
c0d00494:	a80d      	add	r0, sp, #52	; 0x34
    // next timer callback in 500 ms
    UX_CALLBACK_SET_INTERVAL(500);

    for (;;) {

        volatile unsigned short sw = 0;
c0d00496:	8007      	strh	r7, [r0, #0]
c0d00498:	ad01      	add	r5, sp, #4

        BEGIN_TRY {
            TRY {
c0d0049a:	4628      	mov	r0, r5
c0d0049c:	f006 fd66 	bl	c0d06f6c <setjmp>
c0d004a0:	4604      	mov	r4, r0
c0d004a2:	85ac      	strh	r4, [r5, #44]	; 0x2c
c0d004a4:	4851      	ldr	r0, [pc, #324]	; (c0d005ec <handle_business+0x204>)
c0d004a6:	4204      	tst	r4, r0
c0d004a8:	d012      	beq.n	c0d004d0 <handle_business+0xe8>
c0d004aa:	a801      	add	r0, sp, #4
                    default:
                        THROW(0x6D00);
                        break;
                }
            }
            CATCH_OTHER(e) {
c0d004ac:	8587      	strh	r7, [r0, #44]	; 0x2c
c0d004ae:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d004b0:	f003 fb82 	bl	c0d03bb8 <try_context_set>
c0d004b4:	200f      	movs	r0, #15
c0d004b6:	0300      	lsls	r0, r0, #12
                switch (e & 0xF000) {
c0d004b8:	4020      	ands	r0, r4
c0d004ba:	2109      	movs	r1, #9
c0d004bc:	0309      	lsls	r1, r1, #12
c0d004be:	4288      	cmp	r0, r1
c0d004c0:	d003      	beq.n	c0d004ca <handle_business+0xe2>
c0d004c2:	2103      	movs	r1, #3
c0d004c4:	0349      	lsls	r1, r1, #13
c0d004c6:	4288      	cmp	r0, r1
c0d004c8:	d1aa      	bne.n	c0d00420 <handle_business+0x38>
c0d004ca:	a80d      	add	r0, sp, #52	; 0x34
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d004cc:	8004      	strh	r4, [r0, #0]
c0d004ce:	e7ae      	b.n	c0d0042e <handle_business+0x46>
c0d004d0:	a801      	add	r0, sp, #4
    for (;;) {

        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
c0d004d2:	f003 fb71 	bl	c0d03bb8 <try_context_set>
c0d004d6:	900b      	str	r0, [sp, #44]	; 0x2c
                rx = txi;
c0d004d8:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d004da:	9010      	str	r0, [sp, #64]	; 0x40
c0d004dc:	2500      	movs	r5, #0
                txi = 0; // ensure no race in catch_other if io_exchange throws
c0d004de:	950f      	str	r5, [sp, #60]	; 0x3c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d004e0:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d004e2:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d004e4:	b2c0      	uxtb	r0, r0
c0d004e6:	b289      	uxth	r1, r1
c0d004e8:	f002 ff1e 	bl	c0d03328 <io_exchange>
c0d004ec:	9010      	str	r0, [sp, #64]	; 0x40
                flags = 0;
c0d004ee:	950e      	str	r5, [sp, #56]	; 0x38

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d004f0:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d004f2:	2800      	cmp	r0, #0
c0d004f4:	d041      	beq.n	c0d0057a <handle_business+0x192>
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] == 0xF0) {
c0d004f6:	7831      	ldrb	r1, [r6, #0]
c0d004f8:	206d      	movs	r0, #109	; 0x6d
c0d004fa:	0200      	lsls	r0, r0, #8
c0d004fc:	29e0      	cmp	r1, #224	; 0xe0
c0d004fe:	d13f      	bne.n	c0d00580 <handle_business+0x198>
c0d00500:	7871      	ldrb	r1, [r6, #1]
c0d00502:	2209      	movs	r2, #9
c0d00504:	0314      	lsls	r4, r2, #12
                    THROW(0x6E00);
                }

                int account_number;

                switch (G_io_apdu_buffer[1]){
c0d00506:	290d      	cmp	r1, #13
c0d00508:	dda9      	ble.n	c0d0045e <handle_business+0x76>
c0d0050a:	290e      	cmp	r1, #14
c0d0050c:	d006      	beq.n	c0d0051c <handle_business+0x134>
c0d0050e:	2914      	cmp	r1, #20
c0d00510:	d100      	bne.n	c0d00514 <handle_business+0x12c>
c0d00512:	e775      	b.n	c0d00400 <handle_business+0x18>
c0d00514:	29ff      	cmp	r1, #255	; 0xff
c0d00516:	d162      	bne.n	c0d005de <handle_business+0x1f6>
        END_TRY;
    }

return_to_dashboard:
    return;
}
c0d00518:	b011      	add	sp, #68	; 0x44
c0d0051a:	bdf0      	pop	{r4, r5, r6, r7, pc}
                        flags |= IO_ASYNCH_REPLY;
                    }break;

                    case TX_SIGN_TEST:{

                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';
c0d0051c:	7930      	ldrb	r0, [r6, #4]
c0d0051e:	1830      	adds	r0, r6, r0
c0d00520:	7145      	strb	r5, [r0, #5]

                        display_tx_part();
c0d00522:	f005 f86b 	bl	c0d055fc <display_tx_part>

                        if(*(tx.encode_p) < 128){
c0d00526:	4935      	ldr	r1, [pc, #212]	; (c0d005fc <handle_business+0x214>)
c0d00528:	6a88      	ldr	r0, [r1, #40]	; 0x28
c0d0052a:	6802      	ldr	r2, [r0, #0]
c0d0052c:	2a80      	cmp	r2, #128	; 0x80
c0d0052e:	da0a      	bge.n	c0d00546 <handle_business+0x15e>
c0d00530:	2200      	movs	r2, #0
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
c0d00532:	6803      	ldr	r3, [r0, #0]
c0d00534:	429a      	cmp	r2, r3
c0d00536:	da14      	bge.n	c0d00562 <handle_business+0x17a>
                                G_io_apdu_buffer[i] = (char)(tx.encode[i]);
c0d00538:	6a0b      	ldr	r3, [r1, #32]
c0d0053a:	5c9b      	ldrb	r3, [r3, r2]
c0d0053c:	54b3      	strb	r3, [r6, r2]
                        G_io_apdu_buffer[5 + G_io_apdu_buffer[4]] = '\0';

                        display_tx_part();

                        if(*(tx.encode_p) < 128){
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
c0d0053e:	1c52      	adds	r2, r2, #1
c0d00540:	2a80      	cmp	r2, #128	; 0x80
c0d00542:	dbf6      	blt.n	c0d00532 <handle_business+0x14a>
c0d00544:	e00d      	b.n	c0d00562 <handle_business+0x17a>
                                G_io_apdu_buffer[i] = (char)(tx.encode[i]);
                            }
                        } else {
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
c0d00546:	6802      	ldr	r2, [r0, #0]
c0d00548:	4295      	cmp	r5, r2
c0d0054a:	da0a      	bge.n	c0d00562 <handle_business+0x17a>
                                G_io_apdu_buffer[i] = (char)(tx.encode[*(tx.encode_p) - 128 + i]);
c0d0054c:	6a0a      	ldr	r2, [r1, #32]
c0d0054e:	6803      	ldr	r3, [r0, #0]
c0d00550:	18d2      	adds	r2, r2, r3
c0d00552:	1952      	adds	r2, r2, r5
c0d00554:	237f      	movs	r3, #127	; 0x7f
c0d00556:	43db      	mvns	r3, r3
c0d00558:	5cd2      	ldrb	r2, [r2, r3]
c0d0055a:	5572      	strb	r2, [r6, r5]
                        if(*(tx.encode_p) < 128){
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
                                G_io_apdu_buffer[i] = (char)(tx.encode[i]);
                            }
                        } else {
                            for(int i = 0; i < 128 && i < *(tx.encode_p); i++){
c0d0055c:	1c6d      	adds	r5, r5, #1
c0d0055e:	2d80      	cmp	r5, #128	; 0x80
c0d00560:	dbf1      	blt.n	c0d00546 <handle_business+0x15e>
                                G_io_apdu_buffer[i] = (char)(tx.encode[*(tx.encode_p) - 128 + i]);
                            }
                        }
                        
                        
                        if(*(tx.encode_p) < 128){
c0d00562:	6801      	ldr	r1, [r0, #0]
c0d00564:	297f      	cmp	r1, #127	; 0x7f
c0d00566:	dc01      	bgt.n	c0d0056c <handle_business+0x184>
                            txi = *(tx.encode_p);
c0d00568:	6800      	ldr	r0, [r0, #0]
c0d0056a:	e000      	b.n	c0d0056e <handle_business+0x186>
                        } else {
                            txi = 128;
c0d0056c:	2080      	movs	r0, #128	; 0x80
c0d0056e:	900f      	str	r0, [sp, #60]	; 0x3c
c0d00570:	4620      	mov	r0, r4
c0d00572:	f002 fc56 	bl	c0d02e22 <os_longjmp>
                txi += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
c0d00576:	f002 fc54 	bl	c0d02e22 <os_longjmp>
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
c0d0057a:	4824      	ldr	r0, [pc, #144]	; (c0d0060c <handle_business+0x224>)
c0d0057c:	f002 fc51 	bl	c0d02e22 <os_longjmp>
c0d00580:	29f0      	cmp	r1, #240	; 0xf0
c0d00582:	d116      	bne.n	c0d005b2 <handle_business+0x1ca>
c0d00584:	f002 fc4d 	bl	c0d02e22 <os_longjmp>
c0d00588:	2902      	cmp	r1, #2
c0d0058a:	d016      	beq.n	c0d005ba <handle_business+0x1d2>
c0d0058c:	2906      	cmp	r1, #6
c0d0058e:	d126      	bne.n	c0d005de <handle_business+0x1f6>
c0d00590:	78b0      	ldrb	r0, [r6, #2]
                            THROW(0x9020);
                        }
                    }break;

                    case TX_SIGN_START:{
                        if ((G_io_apdu_buffer[2] != P1_MORE) &&
c0d00592:	2180      	movs	r1, #128	; 0x80
c0d00594:	4301      	orrs	r1, r0
c0d00596:	2980      	cmp	r1, #128	; 0x80
c0d00598:	d123      	bne.n	c0d005e2 <handle_business+0x1fa>
                            (G_io_apdu_buffer[2] != P1_LAST)) {
                            THROW(0x6A86);
                        }
                        if (hash_tainted) {
c0d0059a:	4d19      	ldr	r5, [pc, #100]	; (c0d00600 <handle_business+0x218>)
c0d0059c:	7828      	ldrb	r0, [r5, #0]
c0d0059e:	2800      	cmp	r0, #0
c0d005a0:	d004      	beq.n	c0d005ac <handle_business+0x1c4>
                            cx_sha256_init(&hash);
c0d005a2:	4818      	ldr	r0, [pc, #96]	; (c0d00604 <handle_business+0x21c>)
c0d005a4:	f003 fa00 	bl	c0d039a8 <cx_sha256_init>
                            hash_tainted = 0;
c0d005a8:	2000      	movs	r0, #0
c0d005aa:	7028      	strb	r0, [r5, #0]
                        }
                        clean_tx();
c0d005ac:	f004 ffec 	bl	c0d05588 <clean_tx>
c0d005b0:	e7de      	b.n	c0d00570 <handle_business+0x188>
                    CLOSE_TRY;
                    return; 
                }

                if (G_io_apdu_buffer[0] != CLA) {
                    THROW(0x6E00);
c0d005b2:	2037      	movs	r0, #55	; 0x37
c0d005b4:	0240      	lsls	r0, r0, #9
c0d005b6:	f002 fc34 	bl	c0d02e22 <os_longjmp>

                switch (G_io_apdu_buffer[1]){

                    case GET_ADDRESS:{

                        account_number = G_io_apdu_buffer[5];
c0d005ba:	7975      	ldrb	r5, [r6, #5]

                        if(account_number < N_storage.account_number && account_number < 5){
c0d005bc:	4814      	ldr	r0, [pc, #80]	; (c0d00610 <handle_business+0x228>)
c0d005be:	4478      	add	r0, pc
c0d005c0:	f003 f988 	bl	c0d038d4 <pic>
c0d005c4:	6840      	ldr	r0, [r0, #4]
c0d005c6:	2d04      	cmp	r5, #4
c0d005c8:	d807      	bhi.n	c0d005da <handle_business+0x1f2>
c0d005ca:	4285      	cmp	r5, r0
c0d005cc:	da05      	bge.n	c0d005da <handle_business+0x1f2>
                            // flags |= IO_ASYNCH_REPLY;
                            get_address(account_number, &(G_io_apdu_buffer[0]));
c0d005ce:	4909      	ldr	r1, [pc, #36]	; (c0d005f4 <handle_business+0x20c>)
c0d005d0:	4628      	mov	r0, r5
c0d005d2:	f7ff fe29 	bl	c0d00228 <get_address>

                            txi = 38;
c0d005d6:	2026      	movs	r0, #38	; 0x26
c0d005d8:	e7c9      	b.n	c0d0056e <handle_business+0x186>
c0d005da:	3420      	adds	r4, #32
c0d005dc:	e7c8      	b.n	c0d00570 <handle_business+0x188>

                    case 0xFF: // return to dashboard
                        goto return_to_dashboard;

                    default:
                        THROW(0x6D00);
c0d005de:	f002 fc20 	bl	c0d02e22 <os_longjmp>
                    }break;

                    case TX_SIGN_START:{
                        if ((G_io_apdu_buffer[2] != P1_MORE) &&
                            (G_io_apdu_buffer[2] != P1_LAST)) {
                            THROW(0x6A86);
c0d005e2:	4809      	ldr	r0, [pc, #36]	; (c0d00608 <handle_business+0x220>)
c0d005e4:	f002 fc1d 	bl	c0d02e22 <os_longjmp>
c0d005e8:	20001e70 	.word	0x20001e70
c0d005ec:	0000ffff 	.word	0x0000ffff
c0d005f0:	000007ff 	.word	0x000007ff
c0d005f4:	20001fbc 	.word	0x20001fbc
c0d005f8:	20001d18 	.word	0x20001d18
c0d005fc:	20002200 	.word	0x20002200
c0d00600:	20001ca8 	.word	0x20001ca8
c0d00604:	20001cac 	.word	0x20001cac
c0d00608:	00006a86 	.word	0x00006a86
c0d0060c:	00006982 	.word	0x00006982
c0d00610:	0000763e 	.word	0x0000763e
c0d00614:	000077f8 	.word	0x000077f8

c0d00618 <io_seproxyhal_touch_deny>:

return_to_dashboard:
    return;
}

const bagl_element_t *io_seproxyhal_touch_deny(const bagl_element_t *e) {
c0d00618:	b510      	push	{r4, lr}
    hash_tainted = 1;
c0d0061a:	4809      	ldr	r0, [pc, #36]	; (c0d00640 <io_seproxyhal_touch_deny+0x28>)
c0d0061c:	2101      	movs	r1, #1
c0d0061e:	7001      	strb	r1, [r0, #0]
    G_io_apdu_buffer[0] = 0x69;
c0d00620:	4808      	ldr	r0, [pc, #32]	; (c0d00644 <io_seproxyhal_touch_deny+0x2c>)
c0d00622:	2169      	movs	r1, #105	; 0x69
c0d00624:	7001      	strb	r1, [r0, #0]
    G_io_apdu_buffer[1] = 0x85;
c0d00626:	2185      	movs	r1, #133	; 0x85
c0d00628:	7041      	strb	r1, [r0, #1]
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d0062a:	2020      	movs	r0, #32
c0d0062c:	2102      	movs	r1, #2
c0d0062e:	f002 fe7b 	bl	c0d03328 <io_exchange>
c0d00632:	2400      	movs	r4, #0
    // Display back the original UX
    show(UI_MAIN);
c0d00634:	4620      	mov	r0, r4
c0d00636:	f004 f9e3 	bl	c0d04a00 <show>
    return 0; // do not redraw the widget
c0d0063a:	4620      	mov	r0, r4
c0d0063c:	bd10      	pop	{r4, pc}
c0d0063e:	46c0      	nop			; (mov r8, r8)
c0d00640:	20001ca8 	.word	0x20001ca8
c0d00644:	20001fbc 	.word	0x20001fbc

c0d00648 <cx_hash_X>:
}

int cx_hash_X(cx_hash_t *hash ,
              int mode,
              unsigned char WIDE *in , unsigned int len,
              unsigned char *out) {
c0d00648:	b570      	push	{r4, r5, r6, lr}
c0d0064a:	b082      	sub	sp, #8
c0d0064c:	7804      	ldrb	r4, [r0, #0]
c0d0064e:	2514      	movs	r5, #20
   unsigned int hsz = 0;

    switch (hash->algo) {
c0d00650:	2c05      	cmp	r4, #5
c0d00652:	dc09      	bgt.n	c0d00668 <cx_hash_X+0x20>
c0d00654:	2c02      	cmp	r4, #2
c0d00656:	dd0f      	ble.n	c0d00678 <cx_hash_X+0x30>
c0d00658:	2c03      	cmp	r4, #3
c0d0065a:	d01f      	beq.n	c0d0069c <cx_hash_X+0x54>
c0d0065c:	2c04      	cmp	r4, #4
c0d0065e:	d01f      	beq.n	c0d006a0 <cx_hash_X+0x58>
c0d00660:	2c05      	cmp	r4, #5
c0d00662:	d11f      	bne.n	c0d006a4 <cx_hash_X+0x5c>
c0d00664:	2540      	movs	r5, #64	; 0x40
c0d00666:	e012      	b.n	c0d0068e <cx_hash_X+0x46>
c0d00668:	2c08      	cmp	r4, #8
c0d0066a:	dc0b      	bgt.n	c0d00684 <cx_hash_X+0x3c>
c0d0066c:	1fa5      	subs	r5, r4, #6
c0d0066e:	2d02      	cmp	r5, #2
c0d00670:	d30c      	bcc.n	c0d0068c <cx_hash_X+0x44>
c0d00672:	2c08      	cmp	r4, #8
c0d00674:	d00a      	beq.n	c0d0068c <cx_hash_X+0x44>
c0d00676:	e015      	b.n	c0d006a4 <cx_hash_X+0x5c>
c0d00678:	2c01      	cmp	r4, #1
c0d0067a:	d008      	beq.n	c0d0068e <cx_hash_X+0x46>
c0d0067c:	2c02      	cmp	r4, #2
c0d0067e:	d111      	bne.n	c0d006a4 <cx_hash_X+0x5c>
c0d00680:	251c      	movs	r5, #28
c0d00682:	e004      	b.n	c0d0068e <cx_hash_X+0x46>
c0d00684:	2c09      	cmp	r4, #9
c0d00686:	d001      	beq.n	c0d0068c <cx_hash_X+0x44>
c0d00688:	2c0b      	cmp	r4, #11
c0d0068a:	d10b      	bne.n	c0d006a4 <cx_hash_X+0x5c>
c0d0068c:	6885      	ldr	r5, [r0, #8]
c0d0068e:	9c06      	ldr	r4, [sp, #24]
    default:
        THROW(INVALID_PARAMETER);
        return 0;
    }

    return cx_hash(hash, mode, in, len, out, hsz);
c0d00690:	466e      	mov	r6, sp
c0d00692:	c630      	stmia	r6!, {r4, r5}
c0d00694:	f003 f968 	bl	c0d03968 <cx_hash>
c0d00698:	b002      	add	sp, #8
c0d0069a:	bd70      	pop	{r4, r5, r6, pc}
c0d0069c:	2520      	movs	r5, #32
c0d0069e:	e7f6      	b.n	c0d0068e <cx_hash_X+0x46>
c0d006a0:	2530      	movs	r5, #48	; 0x30
c0d006a2:	e7f4      	b.n	c0d0068e <cx_hash_X+0x46>
        break;  
    case CX_BLAKE2B:
        hsz =   ((cx_blake2b_t*)hash)->output_size;
        break;
    default:
        THROW(INVALID_PARAMETER);
c0d006a4:	2002      	movs	r0, #2
c0d006a6:	f002 fbbc 	bl	c0d02e22 <os_longjmp>

c0d006aa <cx_ecfp_get_domain_length>:
    exponent[3] = pub_exponent>>0;

    return cx_rsa_generate_pair(modulus_len, public_key, private_key, exponent, 4, externalPQ);
}

static unsigned int cx_ecfp_get_domain_length(cx_curve_t curve) {
c0d006aa:	b580      	push	{r7, lr}
c0d006ac:	4601      	mov	r1, r0
c0d006ae:	2020      	movs	r0, #32
    switch(curve) {
c0d006b0:	2928      	cmp	r1, #40	; 0x28
c0d006b2:	dd0b      	ble.n	c0d006cc <cx_ecfp_get_domain_length+0x22>
c0d006b4:	292c      	cmp	r1, #44	; 0x2c
c0d006b6:	dd15      	ble.n	c0d006e4 <cx_ecfp_get_domain_length+0x3a>
c0d006b8:	2941      	cmp	r1, #65	; 0x41
c0d006ba:	dd24      	ble.n	c0d00706 <cx_ecfp_get_domain_length+0x5c>
c0d006bc:	2942      	cmp	r1, #66	; 0x42
c0d006be:	d02d      	beq.n	c0d0071c <cx_ecfp_get_domain_length+0x72>
c0d006c0:	2961      	cmp	r1, #97	; 0x61
c0d006c2:	d02c      	beq.n	c0d0071e <cx_ecfp_get_domain_length+0x74>
c0d006c4:	2962      	cmp	r1, #98	; 0x62
c0d006c6:	d12b      	bne.n	c0d00720 <cx_ecfp_get_domain_length+0x76>
c0d006c8:	2038      	movs	r0, #56	; 0x38
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
    return 0;
}
c0d006ca:	bd80      	pop	{r7, pc}
c0d006cc:	460a      	mov	r2, r1
c0d006ce:	2924      	cmp	r1, #36	; 0x24
c0d006d0:	dc10      	bgt.n	c0d006f4 <cx_ecfp_get_domain_length+0x4a>
c0d006d2:	3a21      	subs	r2, #33	; 0x21
c0d006d4:	2a02      	cmp	r2, #2
c0d006d6:	d322      	bcc.n	c0d0071e <cx_ecfp_get_domain_length+0x74>
c0d006d8:	2923      	cmp	r1, #35	; 0x23
c0d006da:	d009      	beq.n	c0d006f0 <cx_ecfp_get_domain_length+0x46>
c0d006dc:	2924      	cmp	r1, #36	; 0x24
c0d006de:	d11f      	bne.n	c0d00720 <cx_ecfp_get_domain_length+0x76>
c0d006e0:	2042      	movs	r0, #66	; 0x42
c0d006e2:	bd80      	pop	{r7, pc}
c0d006e4:	292a      	cmp	r1, #42	; 0x2a
c0d006e6:	dc13      	bgt.n	c0d00710 <cx_ecfp_get_domain_length+0x66>
c0d006e8:	2929      	cmp	r1, #41	; 0x29
c0d006ea:	d001      	beq.n	c0d006f0 <cx_ecfp_get_domain_length+0x46>
c0d006ec:	292a      	cmp	r1, #42	; 0x2a
c0d006ee:	d117      	bne.n	c0d00720 <cx_ecfp_get_domain_length+0x76>
c0d006f0:	2030      	movs	r0, #48	; 0x30
c0d006f2:	bd80      	pop	{r7, pc}
c0d006f4:	3a25      	subs	r2, #37	; 0x25
c0d006f6:	2a02      	cmp	r2, #2
c0d006f8:	d311      	bcc.n	c0d0071e <cx_ecfp_get_domain_length+0x74>
c0d006fa:	2927      	cmp	r1, #39	; 0x27
c0d006fc:	d001      	beq.n	c0d00702 <cx_ecfp_get_domain_length+0x58>
c0d006fe:	2928      	cmp	r1, #40	; 0x28
c0d00700:	d10e      	bne.n	c0d00720 <cx_ecfp_get_domain_length+0x76>
c0d00702:	2028      	movs	r0, #40	; 0x28
c0d00704:	bd80      	pop	{r7, pc}
c0d00706:	292d      	cmp	r1, #45	; 0x2d
c0d00708:	d009      	beq.n	c0d0071e <cx_ecfp_get_domain_length+0x74>
c0d0070a:	2941      	cmp	r1, #65	; 0x41
c0d0070c:	d007      	beq.n	c0d0071e <cx_ecfp_get_domain_length+0x74>
c0d0070e:	e007      	b.n	c0d00720 <cx_ecfp_get_domain_length+0x76>
c0d00710:	292b      	cmp	r1, #43	; 0x2b
c0d00712:	d001      	beq.n	c0d00718 <cx_ecfp_get_domain_length+0x6e>
c0d00714:	292c      	cmp	r1, #44	; 0x2c
c0d00716:	d103      	bne.n	c0d00720 <cx_ecfp_get_domain_length+0x76>
c0d00718:	2040      	movs	r0, #64	; 0x40
c0d0071a:	bd80      	pop	{r7, pc}
c0d0071c:	2039      	movs	r0, #57	; 0x39
c0d0071e:	bd80      	pop	{r7, pc}
    case CX_CURVE_Curve448:
        return 56;
    default:
        break;
    }
    THROW(INVALID_PARAMETER);
c0d00720:	2002      	movs	r0, #2
c0d00722:	f002 fb7e 	bl	c0d02e22 <os_longjmp>

c0d00726 <cx_ecdsa_sign_X>:
}

int cx_ecdsa_sign_X(cx_ecfp_private_key_t WIDE *pv_key,
                    int mode,  cx_md_t hashID, unsigned char  WIDE *hash, unsigned int hash_len,
                    unsigned char *sig ,
                    unsigned int *info) {
c0d00726:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00728:	b085      	sub	sp, #20
c0d0072a:	461c      	mov	r4, r3
c0d0072c:	4615      	mov	r5, r2
c0d0072e:	460e      	mov	r6, r1
c0d00730:	4607      	mov	r7, r0
    const unsigned int  domain_length =  cx_ecfp_get_domain_length(pv_key->curve);
c0d00732:	7838      	ldrb	r0, [r7, #0]
c0d00734:	f7ff ffb9 	bl	c0d006aa <cx_ecfp_get_domain_length>
c0d00738:	990c      	ldr	r1, [sp, #48]	; 0x30
    return cx_ecdsa_sign(pv_key, mode, hashID, hash, hash_len, sig,  6+2*(domain_length+1), info);
c0d0073a:	466a      	mov	r2, sp
c0d0073c:	60d1      	str	r1, [r2, #12]
c0d0073e:	0040      	lsls	r0, r0, #1
c0d00740:	3008      	adds	r0, #8
c0d00742:	6090      	str	r0, [r2, #8]
c0d00744:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00746:	6050      	str	r0, [r2, #4]
c0d00748:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0074a:	6010      	str	r0, [r2, #0]
c0d0074c:	4638      	mov	r0, r7
c0d0074e:	4631      	mov	r1, r6
c0d00750:	462a      	mov	r2, r5
c0d00752:	4623      	mov	r3, r4
c0d00754:	f003 f960 	bl	c0d03a18 <cx_ecdsa_sign>
c0d00758:	b005      	add	sp, #20
c0d0075a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0075c <app_exit>:
#endif // TARGET_BLUE
};

chain_config_t *chainConfig;

void app_exit(void) {
c0d0075c:	b510      	push	{r4, lr}
c0d0075e:	b08c      	sub	sp, #48	; 0x30
c0d00760:	466c      	mov	r4, sp

    BEGIN_TRY_L(exit) {
        TRY_L(exit) {
c0d00762:	4620      	mov	r0, r4
c0d00764:	f006 fc02 	bl	c0d06f6c <setjmp>
c0d00768:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0076a:	490d      	ldr	r1, [pc, #52]	; (c0d007a0 <app_exit+0x44>)
c0d0076c:	4208      	tst	r0, r1
c0d0076e:	d106      	bne.n	c0d0077e <app_exit+0x22>
c0d00770:	4668      	mov	r0, sp
c0d00772:	f003 fa21 	bl	c0d03bb8 <try_context_set>
c0d00776:	900a      	str	r0, [sp, #40]	; 0x28
            os_sched_exit(-1);
c0d00778:	20ff      	movs	r0, #255	; 0xff
c0d0077a:	f003 f9dd 	bl	c0d03b38 <os_sched_exit>
        }
        FINALLY_L(exit) {
c0d0077e:	f003 fa0f 	bl	c0d03ba0 <try_context_get>
c0d00782:	4669      	mov	r1, sp
c0d00784:	4288      	cmp	r0, r1
c0d00786:	d102      	bne.n	c0d0078e <app_exit+0x32>
c0d00788:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0078a:	f003 fa15 	bl	c0d03bb8 <try_context_set>
c0d0078e:	4668      	mov	r0, sp

        }
    }
    END_TRY_L(exit);
c0d00790:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d00792:	2800      	cmp	r0, #0
c0d00794:	d101      	bne.n	c0d0079a <app_exit+0x3e>
}
c0d00796:	b00c      	add	sp, #48	; 0x30
c0d00798:	bd10      	pop	{r4, pc}
        }
        FINALLY_L(exit) {

        }
    }
    END_TRY_L(exit);
c0d0079a:	f002 fb42 	bl	c0d02e22 <os_longjmp>
c0d0079e:	46c0      	nop			; (mov r8, r8)
c0d007a0:	0000ffff 	.word	0x0000ffff

c0d007a4 <io_seproxyhal_display>:
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d007a4:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d007a6:	f002 fce5 	bl	c0d03174 <io_seproxyhal_display_default>
};
c0d007aa:	bd80      	pop	{r7, pc}

c0d007ac <io_exchange_al>:

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d007ac:	b5b0      	push	{r4, r5, r7, lr}
c0d007ae:	4605      	mov	r5, r0
c0d007b0:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d007b2:	4028      	ands	r0, r5
c0d007b4:	2400      	movs	r4, #0
c0d007b6:	2801      	cmp	r0, #1
c0d007b8:	d013      	beq.n	c0d007e2 <io_exchange_al+0x36>
c0d007ba:	2802      	cmp	r0, #2
c0d007bc:	d113      	bne.n	c0d007e6 <io_exchange_al+0x3a>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d007be:	2900      	cmp	r1, #0
c0d007c0:	d008      	beq.n	c0d007d4 <io_exchange_al+0x28>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d007c2:	480a      	ldr	r0, [pc, #40]	; (c0d007ec <io_exchange_al+0x40>)
c0d007c4:	f003 f9c4 	bl	c0d03b50 <io_seph_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d007c8:	b268      	sxtb	r0, r5
c0d007ca:	2800      	cmp	r0, #0
c0d007cc:	da09      	bge.n	c0d007e2 <io_exchange_al+0x36>
                reset();
c0d007ce:	f003 f8a5 	bl	c0d0391c <halt>
c0d007d2:	e006      	b.n	c0d007e2 <io_exchange_al+0x36>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d007d4:	21ff      	movs	r1, #255	; 0xff
c0d007d6:	3152      	adds	r1, #82	; 0x52
c0d007d8:	4804      	ldr	r0, [pc, #16]	; (c0d007ec <io_exchange_al+0x40>)
c0d007da:	2200      	movs	r2, #0
c0d007dc:	f003 f9d0 	bl	c0d03b80 <io_seph_recv>
c0d007e0:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d007e2:	4620      	mov	r0, r4
c0d007e4:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d007e6:	2002      	movs	r0, #2
c0d007e8:	f002 fb1b 	bl	c0d02e22 <os_longjmp>
c0d007ec:	20001fbc 	.word	0x20001fbc

c0d007f0 <io_event>:
    }
    return 0;
}

unsigned char io_event(unsigned char channel) {
c0d007f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d007f2:	b081      	sub	sp, #4
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d007f4:	4ef0      	ldr	r6, [pc, #960]	; (c0d00bb8 <io_event+0x3c8>)
c0d007f6:	7830      	ldrb	r0, [r6, #0]
            UX_DISPLAYED_EVENT();
        // }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d007f8:	25aa      	movs	r5, #170	; 0xaa
unsigned char io_event(unsigned char channel) {
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d007fa:	280c      	cmp	r0, #12
c0d007fc:	dd10      	ble.n	c0d00820 <io_event+0x30>
c0d007fe:	280d      	cmp	r0, #13
c0d00800:	d068      	beq.n	c0d008d4 <io_event+0xe4>
c0d00802:	280e      	cmp	r0, #14
c0d00804:	d100      	bne.n	c0d00808 <io_event+0x18>
c0d00806:	e0ae      	b.n	c0d00966 <io_event+0x176>
c0d00808:	2815      	cmp	r0, #21
c0d0080a:	d10f      	bne.n	c0d0082c <io_event+0x3c>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_STATUS_EVENT:
        if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&
c0d0080c:	48eb      	ldr	r0, [pc, #940]	; (c0d00bbc <io_event+0x3cc>)
c0d0080e:	7980      	ldrb	r0, [r0, #6]
c0d00810:	2801      	cmp	r0, #1
c0d00812:	d10b      	bne.n	c0d0082c <io_event+0x3c>
            !(U4BE(G_io_seproxyhal_spi_buffer, 3) &
c0d00814:	79b0      	ldrb	r0, [r6, #6]
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_STATUS_EVENT:
        if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&
c0d00816:	0700      	lsls	r0, r0, #28
c0d00818:	d408      	bmi.n	c0d0082c <io_event+0x3c>
            !(U4BE(G_io_seproxyhal_spi_buffer, 3) &
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
c0d0081a:	2010      	movs	r0, #16
c0d0081c:	f002 fb01 	bl	c0d02e22 <os_longjmp>
c0d00820:	2805      	cmp	r0, #5
c0d00822:	d100      	bne.n	c0d00826 <io_event+0x36>
c0d00824:	e0f4      	b.n	c0d00a10 <io_event+0x220>
c0d00826:	280c      	cmp	r0, #12
c0d00828:	d100      	bne.n	c0d0082c <io_event+0x3c>
c0d0082a:	e241      	b.n	c0d00cb0 <io_event+0x4c0>
c0d0082c:	462e      	mov	r6, r5
        }
        // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d0082e:	2064      	movs	r0, #100	; 0x64
c0d00830:	4ce3      	ldr	r4, [pc, #908]	; (c0d00bc0 <io_event+0x3d0>)
c0d00832:	2101      	movs	r1, #1
c0d00834:	5421      	strb	r1, [r4, r0]
c0d00836:	2500      	movs	r5, #0
c0d00838:	66a5      	str	r5, [r4, #104]	; 0x68
c0d0083a:	4620      	mov	r0, r4
c0d0083c:	3064      	adds	r0, #100	; 0x64
c0d0083e:	f003 f949 	bl	c0d03ad4 <os_ux>
c0d00842:	2004      	movs	r0, #4
c0d00844:	f003 f9c4 	bl	c0d03bd0 <os_sched_last_status>
c0d00848:	66a0      	str	r0, [r4, #104]	; 0x68
c0d0084a:	2869      	cmp	r0, #105	; 0x69
c0d0084c:	d000      	beq.n	c0d00850 <io_event+0x60>
c0d0084e:	e137      	b.n	c0d00ac0 <io_event+0x2d0>
c0d00850:	f002 fc34 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d00854:	f002 fc34 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d00858:	84e5      	strh	r5, [r4, #38]	; 0x26
c0d0085a:	2004      	movs	r0, #4
c0d0085c:	f003 f9b8 	bl	c0d03bd0 <os_sched_last_status>
c0d00860:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00862:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00864:	2900      	cmp	r1, #0
c0d00866:	4635      	mov	r5, r6
c0d00868:	d100      	bne.n	c0d0086c <io_event+0x7c>
c0d0086a:	e221      	b.n	c0d00cb0 <io_event+0x4c0>
c0d0086c:	2800      	cmp	r0, #0
c0d0086e:	d100      	bne.n	c0d00872 <io_event+0x82>
c0d00870:	e21e      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00872:	2897      	cmp	r0, #151	; 0x97
c0d00874:	d100      	bne.n	c0d00878 <io_event+0x88>
c0d00876:	e21b      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00878:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d0087a:	212c      	movs	r1, #44	; 0x2c
c0d0087c:	5c61      	ldrb	r1, [r4, r1]
c0d0087e:	b280      	uxth	r0, r0
c0d00880:	4288      	cmp	r0, r1
c0d00882:	d300      	bcc.n	c0d00886 <io_event+0x96>
c0d00884:	e214      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00886:	f003 f96f 	bl	c0d03b68 <io_seph_is_status_sent>
c0d0088a:	2800      	cmp	r0, #0
c0d0088c:	d000      	beq.n	c0d00890 <io_event+0xa0>
c0d0088e:	e20f      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00890:	f003 f8ea 	bl	c0d03a68 <os_perso_isonboarded>
c0d00894:	42a8      	cmp	r0, r5
c0d00896:	d104      	bne.n	c0d008a2 <io_event+0xb2>
c0d00898:	f003 f910 	bl	c0d03abc <os_global_pin_is_validated>
c0d0089c:	42a8      	cmp	r0, r5
c0d0089e:	d000      	beq.n	c0d008a2 <io_event+0xb2>
c0d008a0:	e206      	b.n	c0d00cb0 <io_event+0x4c0>
c0d008a2:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d008a4:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d008a6:	0149      	lsls	r1, r1, #5
c0d008a8:	1840      	adds	r0, r0, r1
c0d008aa:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d008ac:	2900      	cmp	r1, #0
c0d008ae:	d002      	beq.n	c0d008b6 <io_event+0xc6>
c0d008b0:	4788      	blx	r1
c0d008b2:	2800      	cmp	r0, #0
c0d008b4:	d007      	beq.n	c0d008c6 <io_event+0xd6>
c0d008b6:	2801      	cmp	r0, #1
c0d008b8:	d103      	bne.n	c0d008c2 <io_event+0xd2>
c0d008ba:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d008bc:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d008be:	0149      	lsls	r1, r1, #5
c0d008c0:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d008c2:	f002 fc57 	bl	c0d03174 <io_seproxyhal_display_default>
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
        // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d008c6:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d008c8:	1c40      	adds	r0, r0, #1
c0d008ca:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d008cc:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d008ce:	2900      	cmp	r1, #0
c0d008d0:	d1d3      	bne.n	c0d0087a <io_event+0x8a>
c0d008d2:	e1ed      	b.n	c0d00cb0 <io_event+0x4c0>
        //         show(UI_APPROVAL);
        //     } else {
        //         UX_REDISPLAY();
        //     }
        // } else {
            UX_DISPLAYED_EVENT();
c0d008d4:	2064      	movs	r0, #100	; 0x64
c0d008d6:	4cfb      	ldr	r4, [pc, #1004]	; (c0d00cc4 <io_event+0x4d4>)
c0d008d8:	2101      	movs	r1, #1
c0d008da:	5421      	strb	r1, [r4, r0]
c0d008dc:	2600      	movs	r6, #0
c0d008de:	66a6      	str	r6, [r4, #104]	; 0x68
c0d008e0:	4620      	mov	r0, r4
c0d008e2:	3064      	adds	r0, #100	; 0x64
c0d008e4:	f003 f8f6 	bl	c0d03ad4 <os_ux>
c0d008e8:	2004      	movs	r0, #4
c0d008ea:	f003 f971 	bl	c0d03bd0 <os_sched_last_status>
c0d008ee:	66a0      	str	r0, [r4, #104]	; 0x68
c0d008f0:	2800      	cmp	r0, #0
c0d008f2:	d100      	bne.n	c0d008f6 <io_event+0x106>
c0d008f4:	e1dc      	b.n	c0d00cb0 <io_event+0x4c0>
c0d008f6:	2869      	cmp	r0, #105	; 0x69
c0d008f8:	d100      	bne.n	c0d008fc <io_event+0x10c>
c0d008fa:	e163      	b.n	c0d00bc4 <io_event+0x3d4>
c0d008fc:	2897      	cmp	r0, #151	; 0x97
c0d008fe:	d100      	bne.n	c0d00902 <io_event+0x112>
c0d00900:	e1d6      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00902:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00904:	2800      	cmp	r0, #0
c0d00906:	d100      	bne.n	c0d0090a <io_event+0x11a>
c0d00908:	e1cb      	b.n	c0d00ca2 <io_event+0x4b2>
c0d0090a:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d0090c:	212c      	movs	r1, #44	; 0x2c
c0d0090e:	5c61      	ldrb	r1, [r4, r1]
c0d00910:	b280      	uxth	r0, r0
c0d00912:	4288      	cmp	r0, r1
c0d00914:	d300      	bcc.n	c0d00918 <io_event+0x128>
c0d00916:	e1c4      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00918:	f003 f926 	bl	c0d03b68 <io_seph_is_status_sent>
c0d0091c:	2800      	cmp	r0, #0
c0d0091e:	d000      	beq.n	c0d00922 <io_event+0x132>
c0d00920:	e1bf      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00922:	f003 f8a1 	bl	c0d03a68 <os_perso_isonboarded>
c0d00926:	42a8      	cmp	r0, r5
c0d00928:	d104      	bne.n	c0d00934 <io_event+0x144>
c0d0092a:	f003 f8c7 	bl	c0d03abc <os_global_pin_is_validated>
c0d0092e:	42a8      	cmp	r0, r5
c0d00930:	d000      	beq.n	c0d00934 <io_event+0x144>
c0d00932:	e1b6      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00934:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00936:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00938:	0149      	lsls	r1, r1, #5
c0d0093a:	1840      	adds	r0, r0, r1
c0d0093c:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d0093e:	2900      	cmp	r1, #0
c0d00940:	d002      	beq.n	c0d00948 <io_event+0x158>
c0d00942:	4788      	blx	r1
c0d00944:	2800      	cmp	r0, #0
c0d00946:	d007      	beq.n	c0d00958 <io_event+0x168>
c0d00948:	2801      	cmp	r0, #1
c0d0094a:	d103      	bne.n	c0d00954 <io_event+0x164>
c0d0094c:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d0094e:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00950:	0149      	lsls	r1, r1, #5
c0d00952:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00954:	f002 fc0e 	bl	c0d03174 <io_seproxyhal_display_default>
        //         show(UI_APPROVAL);
        //     } else {
        //         UX_REDISPLAY();
        //     }
        // } else {
            UX_DISPLAYED_EVENT();
c0d00958:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d0095a:	1c40      	adds	r0, r0, #1
c0d0095c:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d0095e:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00960:	2900      	cmp	r1, #0
c0d00962:	d1d3      	bne.n	c0d0090c <io_event+0x11c>
c0d00964:	e19d      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00966:	9500      	str	r5, [sp, #0]
        // }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00968:	2764      	movs	r7, #100	; 0x64
c0d0096a:	4ed6      	ldr	r6, [pc, #856]	; (c0d00cc4 <io_event+0x4d4>)
c0d0096c:	2001      	movs	r0, #1
c0d0096e:	55f0      	strb	r0, [r6, r7]
c0d00970:	2500      	movs	r5, #0
c0d00972:	66b5      	str	r5, [r6, #104]	; 0x68
c0d00974:	4630      	mov	r0, r6
c0d00976:	3064      	adds	r0, #100	; 0x64
c0d00978:	f003 f8ac 	bl	c0d03ad4 <os_ux>
c0d0097c:	2004      	movs	r0, #4
c0d0097e:	f003 f927 	bl	c0d03bd0 <os_sched_last_status>
c0d00982:	4604      	mov	r4, r0
c0d00984:	66b4      	str	r4, [r6, #104]	; 0x68
c0d00986:	2c69      	cmp	r4, #105	; 0x69
c0d00988:	d000      	beq.n	c0d0098c <io_event+0x19c>
c0d0098a:	e0cc      	b.n	c0d00b26 <io_event+0x336>
c0d0098c:	f002 fb96 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d00990:	f002 fb96 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d00994:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d00996:	2004      	movs	r0, #4
c0d00998:	f003 f91a 	bl	c0d03bd0 <os_sched_last_status>
c0d0099c:	66b0      	str	r0, [r6, #104]	; 0x68
c0d0099e:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d009a0:	2900      	cmp	r1, #0
c0d009a2:	9c00      	ldr	r4, [sp, #0]
c0d009a4:	d100      	bne.n	c0d009a8 <io_event+0x1b8>
c0d009a6:	e183      	b.n	c0d00cb0 <io_event+0x4c0>
c0d009a8:	2800      	cmp	r0, #0
c0d009aa:	d100      	bne.n	c0d009ae <io_event+0x1be>
c0d009ac:	e180      	b.n	c0d00cb0 <io_event+0x4c0>
c0d009ae:	2897      	cmp	r0, #151	; 0x97
c0d009b0:	d100      	bne.n	c0d009b4 <io_event+0x1c4>
c0d009b2:	e17d      	b.n	c0d00cb0 <io_event+0x4c0>
c0d009b4:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d009b6:	212c      	movs	r1, #44	; 0x2c
c0d009b8:	5c71      	ldrb	r1, [r6, r1]
c0d009ba:	b280      	uxth	r0, r0
c0d009bc:	4288      	cmp	r0, r1
c0d009be:	d300      	bcc.n	c0d009c2 <io_event+0x1d2>
c0d009c0:	e176      	b.n	c0d00cb0 <io_event+0x4c0>
c0d009c2:	f003 f8d1 	bl	c0d03b68 <io_seph_is_status_sent>
c0d009c6:	2800      	cmp	r0, #0
c0d009c8:	d000      	beq.n	c0d009cc <io_event+0x1dc>
c0d009ca:	e171      	b.n	c0d00cb0 <io_event+0x4c0>
c0d009cc:	f003 f84c 	bl	c0d03a68 <os_perso_isonboarded>
c0d009d0:	42a0      	cmp	r0, r4
c0d009d2:	d104      	bne.n	c0d009de <io_event+0x1ee>
c0d009d4:	f003 f872 	bl	c0d03abc <os_global_pin_is_validated>
c0d009d8:	42a0      	cmp	r0, r4
c0d009da:	d000      	beq.n	c0d009de <io_event+0x1ee>
c0d009dc:	e168      	b.n	c0d00cb0 <io_event+0x4c0>
c0d009de:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d009e0:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d009e2:	0149      	lsls	r1, r1, #5
c0d009e4:	1840      	adds	r0, r0, r1
c0d009e6:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d009e8:	2900      	cmp	r1, #0
c0d009ea:	d002      	beq.n	c0d009f2 <io_event+0x202>
c0d009ec:	4788      	blx	r1
c0d009ee:	2800      	cmp	r0, #0
c0d009f0:	d007      	beq.n	c0d00a02 <io_event+0x212>
c0d009f2:	2801      	cmp	r0, #1
c0d009f4:	d103      	bne.n	c0d009fe <io_event+0x20e>
c0d009f6:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d009f8:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d009fa:	0149      	lsls	r1, r1, #5
c0d009fc:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d009fe:	f002 fbb9 	bl	c0d03174 <io_seproxyhal_display_default>
            UX_DISPLAYED_EVENT();
        // }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00a02:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00a04:	1c40      	adds	r0, r0, #1
c0d00a06:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00a08:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00a0a:	2900      	cmp	r1, #0
c0d00a0c:	d1d3      	bne.n	c0d009b6 <io_event+0x1c6>
c0d00a0e:	e14f      	b.n	c0d00cb0 <io_event+0x4c0>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00a10:	2064      	movs	r0, #100	; 0x64
c0d00a12:	4cac      	ldr	r4, [pc, #688]	; (c0d00cc4 <io_event+0x4d4>)
c0d00a14:	2101      	movs	r1, #1
c0d00a16:	5421      	strb	r1, [r4, r0]
c0d00a18:	2700      	movs	r7, #0
c0d00a1a:	66a7      	str	r7, [r4, #104]	; 0x68
c0d00a1c:	4620      	mov	r0, r4
c0d00a1e:	3064      	adds	r0, #100	; 0x64
c0d00a20:	f003 f858 	bl	c0d03ad4 <os_ux>
c0d00a24:	2004      	movs	r0, #4
c0d00a26:	f003 f8d3 	bl	c0d03bd0 <os_sched_last_status>
c0d00a2a:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00a2c:	2800      	cmp	r0, #0
c0d00a2e:	d100      	bne.n	c0d00a32 <io_event+0x242>
c0d00a30:	e13e      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a32:	2897      	cmp	r0, #151	; 0x97
c0d00a34:	d100      	bne.n	c0d00a38 <io_event+0x248>
c0d00a36:	e13b      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a38:	2869      	cmp	r0, #105	; 0x69
c0d00a3a:	d000      	beq.n	c0d00a3e <io_event+0x24e>
c0d00a3c:	e0fd      	b.n	c0d00c3a <io_event+0x44a>
c0d00a3e:	f002 fb3d 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d00a42:	f002 fb3d 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d00a46:	84e7      	strh	r7, [r4, #38]	; 0x26
c0d00a48:	2004      	movs	r0, #4
c0d00a4a:	f003 f8c1 	bl	c0d03bd0 <os_sched_last_status>
c0d00a4e:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00a50:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00a52:	2900      	cmp	r1, #0
c0d00a54:	d100      	bne.n	c0d00a58 <io_event+0x268>
c0d00a56:	e12b      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a58:	2800      	cmp	r0, #0
c0d00a5a:	d100      	bne.n	c0d00a5e <io_event+0x26e>
c0d00a5c:	e128      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a5e:	2897      	cmp	r0, #151	; 0x97
c0d00a60:	d100      	bne.n	c0d00a64 <io_event+0x274>
c0d00a62:	e125      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a64:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00a66:	212c      	movs	r1, #44	; 0x2c
c0d00a68:	5c61      	ldrb	r1, [r4, r1]
c0d00a6a:	b280      	uxth	r0, r0
c0d00a6c:	4288      	cmp	r0, r1
c0d00a6e:	d300      	bcc.n	c0d00a72 <io_event+0x282>
c0d00a70:	e11e      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a72:	f003 f879 	bl	c0d03b68 <io_seph_is_status_sent>
c0d00a76:	2800      	cmp	r0, #0
c0d00a78:	d000      	beq.n	c0d00a7c <io_event+0x28c>
c0d00a7a:	e119      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a7c:	f002 fff4 	bl	c0d03a68 <os_perso_isonboarded>
c0d00a80:	42a8      	cmp	r0, r5
c0d00a82:	d104      	bne.n	c0d00a8e <io_event+0x29e>
c0d00a84:	f003 f81a 	bl	c0d03abc <os_global_pin_is_validated>
c0d00a88:	42a8      	cmp	r0, r5
c0d00a8a:	d000      	beq.n	c0d00a8e <io_event+0x29e>
c0d00a8c:	e110      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00a8e:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00a90:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00a92:	0149      	lsls	r1, r1, #5
c0d00a94:	1840      	adds	r0, r0, r1
c0d00a96:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00a98:	2900      	cmp	r1, #0
c0d00a9a:	d002      	beq.n	c0d00aa2 <io_event+0x2b2>
c0d00a9c:	4788      	blx	r1
c0d00a9e:	2800      	cmp	r0, #0
c0d00aa0:	d007      	beq.n	c0d00ab2 <io_event+0x2c2>
c0d00aa2:	2801      	cmp	r0, #1
c0d00aa4:	d103      	bne.n	c0d00aae <io_event+0x2be>
c0d00aa6:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00aa8:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00aaa:	0149      	lsls	r1, r1, #5
c0d00aac:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00aae:	f002 fb61 	bl	c0d03174 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00ab2:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00ab4:	1c40      	adds	r0, r0, #1
c0d00ab6:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00ab8:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00aba:	2900      	cmp	r1, #0
c0d00abc:	d1d3      	bne.n	c0d00a66 <io_event+0x276>
c0d00abe:	e0f7      	b.n	c0d00cb0 <io_event+0x4c0>
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
        // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d00ac0:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00ac2:	2800      	cmp	r0, #0
c0d00ac4:	4635      	mov	r5, r6
c0d00ac6:	d100      	bne.n	c0d00aca <io_event+0x2da>
c0d00ac8:	e0eb      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00aca:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00acc:	212c      	movs	r1, #44	; 0x2c
c0d00ace:	5c61      	ldrb	r1, [r4, r1]
c0d00ad0:	b280      	uxth	r0, r0
c0d00ad2:	4288      	cmp	r0, r1
c0d00ad4:	d300      	bcc.n	c0d00ad8 <io_event+0x2e8>
c0d00ad6:	e0e4      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00ad8:	f003 f846 	bl	c0d03b68 <io_seph_is_status_sent>
c0d00adc:	2800      	cmp	r0, #0
c0d00ade:	d000      	beq.n	c0d00ae2 <io_event+0x2f2>
c0d00ae0:	e0df      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00ae2:	f002 ffc1 	bl	c0d03a68 <os_perso_isonboarded>
c0d00ae6:	42a8      	cmp	r0, r5
c0d00ae8:	d104      	bne.n	c0d00af4 <io_event+0x304>
c0d00aea:	f002 ffe7 	bl	c0d03abc <os_global_pin_is_validated>
c0d00aee:	42a8      	cmp	r0, r5
c0d00af0:	d000      	beq.n	c0d00af4 <io_event+0x304>
c0d00af2:	e0d6      	b.n	c0d00ca2 <io_event+0x4b2>
c0d00af4:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00af6:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00af8:	0149      	lsls	r1, r1, #5
c0d00afa:	1840      	adds	r0, r0, r1
c0d00afc:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00afe:	2900      	cmp	r1, #0
c0d00b00:	d002      	beq.n	c0d00b08 <io_event+0x318>
c0d00b02:	4788      	blx	r1
c0d00b04:	2800      	cmp	r0, #0
c0d00b06:	d007      	beq.n	c0d00b18 <io_event+0x328>
c0d00b08:	2801      	cmp	r0, #1
c0d00b0a:	d103      	bne.n	c0d00b14 <io_event+0x324>
c0d00b0c:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00b0e:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00b10:	0149      	lsls	r1, r1, #5
c0d00b12:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00b14:	f002 fb2e 	bl	c0d03174 <io_seproxyhal_display_default>
              SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
            THROW(EXCEPTION_IO_RESET);
        }
        // no break is intentional
    default:
        UX_DEFAULT_EVENT();
c0d00b18:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00b1a:	1c40      	adds	r0, r0, #1
c0d00b1c:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00b1e:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00b20:	2900      	cmp	r1, #0
c0d00b22:	d1d3      	bne.n	c0d00acc <io_event+0x2dc>
c0d00b24:	e0bd      	b.n	c0d00ca2 <io_event+0x4b2>
            UX_DISPLAYED_EVENT();
        // }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00b26:	6bf0      	ldr	r0, [r6, #60]	; 0x3c
c0d00b28:	2800      	cmp	r0, #0
c0d00b2a:	9d00      	ldr	r5, [sp, #0]
c0d00b2c:	d00d      	beq.n	c0d00b4a <io_event+0x35a>
c0d00b2e:	2864      	cmp	r0, #100	; 0x64
c0d00b30:	4601      	mov	r1, r0
c0d00b32:	d300      	bcc.n	c0d00b36 <io_event+0x346>
c0d00b34:	4639      	mov	r1, r7
c0d00b36:	1a40      	subs	r0, r0, r1
c0d00b38:	63f0      	str	r0, [r6, #60]	; 0x3c
c0d00b3a:	d106      	bne.n	c0d00b4a <io_event+0x35a>
c0d00b3c:	6bb1      	ldr	r1, [r6, #56]	; 0x38
c0d00b3e:	2900      	cmp	r1, #0
c0d00b40:	d003      	beq.n	c0d00b4a <io_event+0x35a>
c0d00b42:	6c30      	ldr	r0, [r6, #64]	; 0x40
c0d00b44:	63f0      	str	r0, [r6, #60]	; 0x3c
c0d00b46:	2000      	movs	r0, #0
c0d00b48:	4788      	blx	r1
c0d00b4a:	2c00      	cmp	r4, #0
c0d00b4c:	d100      	bne.n	c0d00b50 <io_event+0x360>
c0d00b4e:	e0af      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00b50:	2c97      	cmp	r4, #151	; 0x97
c0d00b52:	d100      	bne.n	c0d00b56 <io_event+0x366>
c0d00b54:	e0ac      	b.n	c0d00cb0 <io_event+0x4c0>
c0d00b56:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00b58:	2800      	cmp	r0, #0
c0d00b5a:	d029      	beq.n	c0d00bb0 <io_event+0x3c0>
c0d00b5c:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00b5e:	212c      	movs	r1, #44	; 0x2c
c0d00b60:	5c71      	ldrb	r1, [r6, r1]
c0d00b62:	b280      	uxth	r0, r0
c0d00b64:	4288      	cmp	r0, r1
c0d00b66:	d223      	bcs.n	c0d00bb0 <io_event+0x3c0>
c0d00b68:	f002 fffe 	bl	c0d03b68 <io_seph_is_status_sent>
c0d00b6c:	2800      	cmp	r0, #0
c0d00b6e:	d11f      	bne.n	c0d00bb0 <io_event+0x3c0>
c0d00b70:	f002 ff7a 	bl	c0d03a68 <os_perso_isonboarded>
c0d00b74:	42a8      	cmp	r0, r5
c0d00b76:	d103      	bne.n	c0d00b80 <io_event+0x390>
c0d00b78:	f002 ffa0 	bl	c0d03abc <os_global_pin_is_validated>
c0d00b7c:	42a8      	cmp	r0, r5
c0d00b7e:	d117      	bne.n	c0d00bb0 <io_event+0x3c0>
c0d00b80:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00b82:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d00b84:	0149      	lsls	r1, r1, #5
c0d00b86:	1840      	adds	r0, r0, r1
c0d00b88:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d00b8a:	2900      	cmp	r1, #0
c0d00b8c:	d002      	beq.n	c0d00b94 <io_event+0x3a4>
c0d00b8e:	4788      	blx	r1
c0d00b90:	2800      	cmp	r0, #0
c0d00b92:	d007      	beq.n	c0d00ba4 <io_event+0x3b4>
c0d00b94:	2801      	cmp	r0, #1
c0d00b96:	d103      	bne.n	c0d00ba0 <io_event+0x3b0>
c0d00b98:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d00b9a:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d00b9c:	0149      	lsls	r1, r1, #5
c0d00b9e:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00ba0:	f002 fae8 	bl	c0d03174 <io_seproxyhal_display_default>
            UX_DISPLAYED_EVENT();
        // }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {
c0d00ba4:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d00ba6:	1c40      	adds	r0, r0, #1
c0d00ba8:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d00baa:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d00bac:	2900      	cmp	r1, #0
c0d00bae:	d1d6      	bne.n	c0d00b5e <io_event+0x36e>
c0d00bb0:	202c      	movs	r0, #44	; 0x2c
c0d00bb2:	5c30      	ldrb	r0, [r6, r0]
c0d00bb4:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d00bb6:	e077      	b.n	c0d00ca8 <io_event+0x4b8>
c0d00bb8:	20001df0 	.word	0x20001df0
c0d00bbc:	20002110 	.word	0x20002110
c0d00bc0:	20001e70 	.word	0x20001e70
        //         show(UI_APPROVAL);
        //     } else {
        //         UX_REDISPLAY();
        //     }
        // } else {
            UX_DISPLAYED_EVENT();
c0d00bc4:	f002 fa7a 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d00bc8:	f002 fa7a 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d00bcc:	84e6      	strh	r6, [r4, #38]	; 0x26
c0d00bce:	2004      	movs	r0, #4
c0d00bd0:	f002 fffe 	bl	c0d03bd0 <os_sched_last_status>
c0d00bd4:	66a0      	str	r0, [r4, #104]	; 0x68
c0d00bd6:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00bd8:	2900      	cmp	r1, #0
c0d00bda:	d069      	beq.n	c0d00cb0 <io_event+0x4c0>
c0d00bdc:	2800      	cmp	r0, #0
c0d00bde:	d067      	beq.n	c0d00cb0 <io_event+0x4c0>
c0d00be0:	2897      	cmp	r0, #151	; 0x97
c0d00be2:	d065      	beq.n	c0d00cb0 <io_event+0x4c0>
c0d00be4:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00be6:	212c      	movs	r1, #44	; 0x2c
c0d00be8:	5c61      	ldrb	r1, [r4, r1]
c0d00bea:	b280      	uxth	r0, r0
c0d00bec:	4288      	cmp	r0, r1
c0d00bee:	d25f      	bcs.n	c0d00cb0 <io_event+0x4c0>
c0d00bf0:	f002 ffba 	bl	c0d03b68 <io_seph_is_status_sent>
c0d00bf4:	2800      	cmp	r0, #0
c0d00bf6:	d15b      	bne.n	c0d00cb0 <io_event+0x4c0>
c0d00bf8:	f002 ff36 	bl	c0d03a68 <os_perso_isonboarded>
c0d00bfc:	42a8      	cmp	r0, r5
c0d00bfe:	d103      	bne.n	c0d00c08 <io_event+0x418>
c0d00c00:	f002 ff5c 	bl	c0d03abc <os_global_pin_is_validated>
c0d00c04:	42a8      	cmp	r0, r5
c0d00c06:	d153      	bne.n	c0d00cb0 <io_event+0x4c0>
c0d00c08:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c0a:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c0c:	0149      	lsls	r1, r1, #5
c0d00c0e:	1840      	adds	r0, r0, r1
c0d00c10:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00c12:	2900      	cmp	r1, #0
c0d00c14:	d002      	beq.n	c0d00c1c <io_event+0x42c>
c0d00c16:	4788      	blx	r1
c0d00c18:	2800      	cmp	r0, #0
c0d00c1a:	d007      	beq.n	c0d00c2c <io_event+0x43c>
c0d00c1c:	2801      	cmp	r0, #1
c0d00c1e:	d103      	bne.n	c0d00c28 <io_event+0x438>
c0d00c20:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c22:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c24:	0149      	lsls	r1, r1, #5
c0d00c26:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c28:	f002 faa4 	bl	c0d03174 <io_seproxyhal_display_default>
        //         show(UI_APPROVAL);
        //     } else {
        //         UX_REDISPLAY();
        //     }
        // } else {
            UX_DISPLAYED_EVENT();
c0d00c2c:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00c2e:	1c40      	adds	r0, r0, #1
c0d00c30:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00c32:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00c34:	2900      	cmp	r1, #0
c0d00c36:	d1d6      	bne.n	c0d00be6 <io_event+0x3f6>
c0d00c38:	e03a      	b.n	c0d00cb0 <io_event+0x4c0>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c3a:	6b60      	ldr	r0, [r4, #52]	; 0x34
c0d00c3c:	2800      	cmp	r0, #0
c0d00c3e:	d003      	beq.n	c0d00c48 <io_event+0x458>
c0d00c40:	78f1      	ldrb	r1, [r6, #3]
c0d00c42:	0849      	lsrs	r1, r1, #1
c0d00c44:	f002 fb06 	bl	c0d03254 <io_seproxyhal_button_push>
c0d00c48:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c4a:	2800      	cmp	r0, #0
c0d00c4c:	d029      	beq.n	c0d00ca2 <io_event+0x4b2>
c0d00c4e:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00c50:	212c      	movs	r1, #44	; 0x2c
c0d00c52:	5c61      	ldrb	r1, [r4, r1]
c0d00c54:	b280      	uxth	r0, r0
c0d00c56:	4288      	cmp	r0, r1
c0d00c58:	d223      	bcs.n	c0d00ca2 <io_event+0x4b2>
c0d00c5a:	f002 ff85 	bl	c0d03b68 <io_seph_is_status_sent>
c0d00c5e:	2800      	cmp	r0, #0
c0d00c60:	d11f      	bne.n	c0d00ca2 <io_event+0x4b2>
c0d00c62:	f002 ff01 	bl	c0d03a68 <os_perso_isonboarded>
c0d00c66:	42a8      	cmp	r0, r5
c0d00c68:	d103      	bne.n	c0d00c72 <io_event+0x482>
c0d00c6a:	f002 ff27 	bl	c0d03abc <os_global_pin_is_validated>
c0d00c6e:	42a8      	cmp	r0, r5
c0d00c70:	d117      	bne.n	c0d00ca2 <io_event+0x4b2>
c0d00c72:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c74:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c76:	0149      	lsls	r1, r1, #5
c0d00c78:	1840      	adds	r0, r0, r1
c0d00c7a:	6b21      	ldr	r1, [r4, #48]	; 0x30
c0d00c7c:	2900      	cmp	r1, #0
c0d00c7e:	d002      	beq.n	c0d00c86 <io_event+0x496>
c0d00c80:	4788      	blx	r1
c0d00c82:	2800      	cmp	r0, #0
c0d00c84:	d007      	beq.n	c0d00c96 <io_event+0x4a6>
c0d00c86:	2801      	cmp	r0, #1
c0d00c88:	d103      	bne.n	c0d00c92 <io_event+0x4a2>
c0d00c8a:	6aa0      	ldr	r0, [r4, #40]	; 0x28
c0d00c8c:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00c8e:	0149      	lsls	r1, r1, #5
c0d00c90:	1840      	adds	r0, r0, r1
    }
    END_TRY_L(exit);
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00c92:	f002 fa6f 	bl	c0d03174 <io_seproxyhal_display_default>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00c96:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d00c98:	1c40      	adds	r0, r0, #1
c0d00c9a:	84e0      	strh	r0, [r4, #38]	; 0x26
c0d00c9c:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0d00c9e:	2900      	cmp	r1, #0
c0d00ca0:	d1d6      	bne.n	c0d00c50 <io_event+0x460>
c0d00ca2:	202c      	movs	r0, #44	; 0x2c
c0d00ca4:	5c20      	ldrb	r0, [r4, r0]
c0d00ca6:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d00ca8:	4281      	cmp	r1, r0
c0d00caa:	d301      	bcc.n	c0d00cb0 <io_event+0x4c0>
c0d00cac:	f002 ff5c 	bl	c0d03b68 <io_seph_is_status_sent>
        });
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00cb0:	f002 ff5a 	bl	c0d03b68 <io_seph_is_status_sent>
c0d00cb4:	2800      	cmp	r0, #0
c0d00cb6:	d101      	bne.n	c0d00cbc <io_event+0x4cc>
        io_seproxyhal_general_status();
c0d00cb8:	f002 f8ba 	bl	c0d02e30 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00cbc:	2001      	movs	r0, #1
c0d00cbe:	b001      	add	sp, #4
c0d00cc0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00cc2:	46c0      	nop			; (mov r8, r8)
c0d00cc4:	20001e70 	.word	0x20001e70

c0d00cc8 <find_data_processor>:
        id += (value[z] - 48);
    }
    return id;
}

int find_data_processor(char *value, char *flag, char *input, int length, short key_length, operation_data *operation, bool copy_to_cache){
c0d00cc8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00cca:	b087      	sub	sp, #28
c0d00ccc:	461e      	mov	r6, r3
c0d00cce:	4615      	mov	r5, r2
c0d00cd0:	9105      	str	r1, [sp, #20]
c0d00cd2:	9002      	str	r0, [sp, #8]
    // log[log_p++] = '-';
    // log[log_p++] = flag[0];
    // log[log_p++] = flag[1];
    // log[log_p++] = '-';

    find_value_length = 0;
c0d00cd4:	4833      	ldr	r0, [pc, #204]	; (c0d00da4 <find_data_processor+0xdc>)
c0d00cd6:	2100      	movs	r1, #0
c0d00cd8:	9103      	str	r1, [sp, #12]
c0d00cda:	6001      	str	r1, [r0, #0]

    while(find_i < length){
c0d00cdc:	4832      	ldr	r0, [pc, #200]	; (c0d00da8 <find_data_processor+0xe0>)
c0d00cde:	6804      	ldr	r4, [r0, #0]
c0d00ce0:	42b4      	cmp	r4, r6
c0d00ce2:	da44      	bge.n	c0d00d6e <find_data_processor+0xa6>
c0d00ce4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00ce6:	9001      	str	r0, [sp, #4]
c0d00ce8:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00cea:	9004      	str	r0, [sp, #16]
c0d00cec:	482f      	ldr	r0, [pc, #188]	; (c0d00dac <find_data_processor+0xe4>)
c0d00cee:	7800      	ldrb	r0, [r0, #0]
c0d00cf0:	9006      	str	r0, [sp, #24]
c0d00cf2:	4f32      	ldr	r7, [pc, #200]	; (c0d00dbc <find_data_processor+0xf4>)
c0d00cf4:	1928      	adds	r0, r5, r4

        if(internal_structure == false){
c0d00cf6:	9906      	ldr	r1, [sp, #24]
c0d00cf8:	2900      	cmp	r1, #0
c0d00cfa:	d117      	bne.n	c0d00d2c <find_data_processor+0x64>
            if(input[find_i] == '['){
c0d00cfc:	7801      	ldrb	r1, [r0, #0]
c0d00cfe:	295b      	cmp	r1, #91	; 0x5b
c0d00d00:	d103      	bne.n	c0d00d0a <find_data_processor+0x42>
                internal_structure_type_1 = true;
c0d00d02:	2101      	movs	r1, #1
c0d00d04:	4a2a      	ldr	r2, [pc, #168]	; (c0d00db0 <find_data_processor+0xe8>)
c0d00d06:	7011      	strb	r1, [r2, #0]
c0d00d08:	7801      	ldrb	r1, [r0, #0]
            }

            if(input[find_i] == '{'){
c0d00d0a:	297b      	cmp	r1, #123	; 0x7b
c0d00d0c:	d103      	bne.n	c0d00d16 <find_data_processor+0x4e>
                internal_structure_type_2 = true;
c0d00d0e:	2101      	movs	r1, #1
c0d00d10:	4a28      	ldr	r2, [pc, #160]	; (c0d00db4 <find_data_processor+0xec>)
c0d00d12:	7011      	strb	r1, [r2, #0]
c0d00d14:	7801      	ldrb	r1, [r0, #0]
            }

            if(input[find_i] == ']'){
c0d00d16:	295d      	cmp	r1, #93	; 0x5d
c0d00d18:	d103      	bne.n	c0d00d22 <find_data_processor+0x5a>
                internal_structure_type_1 = false;
c0d00d1a:	9903      	ldr	r1, [sp, #12]
c0d00d1c:	4a24      	ldr	r2, [pc, #144]	; (c0d00db0 <find_data_processor+0xe8>)
c0d00d1e:	7011      	strb	r1, [r2, #0]
c0d00d20:	7801      	ldrb	r1, [r0, #0]
            }

            if(input[find_i] == '}'){
c0d00d22:	297d      	cmp	r1, #125	; 0x7d
c0d00d24:	d102      	bne.n	c0d00d2c <find_data_processor+0x64>
                internal_structure_type_2 = false;
c0d00d26:	9903      	ldr	r1, [sp, #12]
c0d00d28:	4a22      	ldr	r2, [pc, #136]	; (c0d00db4 <find_data_processor+0xec>)
c0d00d2a:	7011      	strb	r1, [r2, #0]
            }
        }
        
        if(input[find_i] == '=' && internal_structure_type_1 == false && internal_structure_type_2 == false){
c0d00d2c:	4920      	ldr	r1, [pc, #128]	; (c0d00db0 <find_data_processor+0xe8>)
c0d00d2e:	780a      	ldrb	r2, [r1, #0]
c0d00d30:	4920      	ldr	r1, [pc, #128]	; (c0d00db4 <find_data_processor+0xec>)
c0d00d32:	7809      	ldrb	r1, [r1, #0]
c0d00d34:	4311      	orrs	r1, r2
c0d00d36:	7802      	ldrb	r2, [r0, #0]
c0d00d38:	2a3d      	cmp	r2, #61	; 0x3d
c0d00d3a:	d104      	bne.n	c0d00d46 <find_data_processor+0x7e>
c0d00d3c:	060b      	lsls	r3, r1, #24
c0d00d3e:	d102      	bne.n	c0d00d46 <find_data_processor+0x7e>
            find_info_delimiter = find_i;
c0d00d40:	4a1d      	ldr	r2, [pc, #116]	; (c0d00db8 <find_data_processor+0xf0>)
c0d00d42:	6014      	str	r4, [r2, #0]
c0d00d44:	7802      	ldrb	r2, [r0, #0]
            // log[log_p++] = '=';
            // log[log_p++] = (char)(i + 48);
            // log[log_p++] = '-';
        }

        if(input[find_i] == ',' && internal_structure_type_1 == false && internal_structure_type_2 == false){
c0d00d46:	2a2c      	cmp	r2, #44	; 0x2c
c0d00d48:	d10c      	bne.n	c0d00d64 <find_data_processor+0x9c>
c0d00d4a:	0608      	lsls	r0, r1, #24
c0d00d4c:	d10a      	bne.n	c0d00d64 <find_data_processor+0x9c>

            // log[log_p++] = ',';
            // log[log_p++] = (char)(i+48);
            // log[log_p++] = '-';

            if(strncmp(&(input[find_info_start]), flag, key_length) == 0){
c0d00d4e:	6838      	ldr	r0, [r7, #0]
c0d00d50:	1828      	adds	r0, r5, r0
c0d00d52:	9905      	ldr	r1, [sp, #20]
c0d00d54:	9a04      	ldr	r2, [sp, #16]
c0d00d56:	f006 f957 	bl	c0d07008 <strncmp>
c0d00d5a:	2800      	cmp	r0, #0
c0d00d5c:	d011      	beq.n	c0d00d82 <find_data_processor+0xba>
                // log_p += value_length;
                // log[log_p++] = '-';

                return find_value_length;
            }
            find_info_start = find_i + 1;
c0d00d5e:	1c64      	adds	r4, r4, #1
c0d00d60:	603c      	str	r4, [r7, #0]
c0d00d62:	e000      	b.n	c0d00d66 <find_data_processor+0x9e>
        }

        find_i++;
c0d00d64:	1c64      	adds	r4, r4, #1
c0d00d66:	4810      	ldr	r0, [pc, #64]	; (c0d00da8 <find_data_processor+0xe0>)
c0d00d68:	6004      	str	r4, [r0, #0]
    // log[log_p++] = flag[1];
    // log[log_p++] = '-';

    find_value_length = 0;

    while(find_i < length){
c0d00d6a:	42b4      	cmp	r4, r6
c0d00d6c:	dbc2      	blt.n	c0d00cf4 <find_data_processor+0x2c>
c0d00d6e:	2200      	movs	r2, #0
    }

    // os_memcpy(&(operation->data[0]), (unsigned char *)log, logp);

    
    find_i = 0;
c0d00d70:	480d      	ldr	r0, [pc, #52]	; (c0d00da8 <find_data_processor+0xe0>)
c0d00d72:	6002      	str	r2, [r0, #0]
    find_info_start = 0;
c0d00d74:	4811      	ldr	r0, [pc, #68]	; (c0d00dbc <find_data_processor+0xf4>)
c0d00d76:	6002      	str	r2, [r0, #0]
    find_info_delimiter = 0;
c0d00d78:	480f      	ldr	r0, [pc, #60]	; (c0d00db8 <find_data_processor+0xf0>)
c0d00d7a:	6002      	str	r2, [r0, #0]

    return find_value_length;
}
c0d00d7c:	4610      	mov	r0, r2
c0d00d7e:	b007      	add	sp, #28
c0d00d80:	bdf0      	pop	{r4, r5, r6, r7, pc}
            // log[log_p++] = (char)(i+48);
            // log[log_p++] = '-';

            if(strncmp(&(input[find_info_start]), flag, key_length) == 0){

                find_value_length = find_i - find_info_delimiter - 1;
c0d00d82:	480d      	ldr	r0, [pc, #52]	; (c0d00db8 <find_data_processor+0xf0>)
c0d00d84:	6800      	ldr	r0, [r0, #0]
c0d00d86:	1a21      	subs	r1, r4, r0
c0d00d88:	1e4a      	subs	r2, r1, #1
c0d00d8a:	4c06      	ldr	r4, [pc, #24]	; (c0d00da4 <find_data_processor+0xdc>)
c0d00d8c:	6022      	str	r2, [r4, #0]
                // log[log_p++] = (char)(info_delimiter + 1 + 48);
                // log[log_p++] = '-';
                // log[log_p++] = (char)(value_length + 48);
                // log[log_p++] = '-';

                if(copy_to_cache){
c0d00d8e:	9901      	ldr	r1, [sp, #4]
c0d00d90:	2901      	cmp	r1, #1
c0d00d92:	d1f3      	bne.n	c0d00d7c <find_data_processor+0xb4>
                    os_memcpy(value, &(input[find_info_delimiter + 1]), find_value_length);
c0d00d94:	1828      	adds	r0, r5, r0
c0d00d96:	1c41      	adds	r1, r0, #1
c0d00d98:	9802      	ldr	r0, [sp, #8]
c0d00d9a:	f002 f807 	bl	c0d02dac <os_memmove>
c0d00d9e:	6822      	ldr	r2, [r4, #0]
c0d00da0:	e7ec      	b.n	c0d00d7c <find_data_processor+0xb4>
c0d00da2:	46c0      	nop			; (mov r8, r8)
c0d00da4:	20001fa0 	.word	0x20001fa0
c0d00da8:	20001fa4 	.word	0x20001fa4
c0d00dac:	20001fa8 	.word	0x20001fa8
c0d00db0:	20001fa9 	.word	0x20001fa9
c0d00db4:	20001faa 	.word	0x20001faa
c0d00db8:	20001fac 	.word	0x20001fac
c0d00dbc:	20001fb0 	.word	0x20001fb0

c0d00dc0 <read_message>:

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
}

void read_message(cache_holder ch){
c0d00dc0:	b570      	push	{r4, r5, r6, lr}
c0d00dc2:	460c      	mov	r4, r1
c0d00dc4:	9e05      	ldr	r6, [sp, #20]

    os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d00dc6:	6830      	ldr	r0, [r6, #0]
c0d00dc8:	9d04      	ldr	r5, [sp, #16]
c0d00dca:	6829      	ldr	r1, [r5, #0]
c0d00dcc:	1840      	adds	r0, r0, r1
c0d00dce:	6823      	ldr	r3, [r4, #0]
c0d00dd0:	4611      	mov	r1, r2
c0d00dd2:	461a      	mov	r2, r3
c0d00dd4:	f001 ffea 	bl	c0d02dac <os_memmove>
    *(ch.data_p) += *(ch.value_length);
c0d00dd8:	6820      	ldr	r0, [r4, #0]
c0d00dda:	6829      	ldr	r1, [r5, #0]
c0d00ddc:	1808      	adds	r0, r1, r0
c0d00dde:	6028      	str	r0, [r5, #0]
    ch.operation->data[(*(ch.data_p))++] = ',';
c0d00de0:	6830      	ldr	r0, [r6, #0]
c0d00de2:	6829      	ldr	r1, [r5, #0]
c0d00de4:	1c4a      	adds	r2, r1, #1
c0d00de6:	602a      	str	r2, [r5, #0]
c0d00de8:	222c      	movs	r2, #44	; 0x2c
c0d00dea:	5442      	strb	r2, [r0, r1]
    // clean_cache(ch.cache, ch.cache_length);
}
c0d00dec:	bd70      	pop	{r4, r5, r6, pc}
	...

c0d00df0 <get_uint_128>:

get_uint_128(uint128_t *value, cache_holder ch){
c0d00df0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00df2:	b083      	sub	sp, #12
c0d00df4:	9301      	str	r3, [sp, #4]
c0d00df6:	4615      	mov	r5, r2
c0d00df8:	4606      	mov	r6, r0

    // log[log_p++] = 't';
    // log[log_p++] = *(ch.value_length);

    uint128_t *ten = &uint128_t_cache2;
    clear128(ten);
c0d00dfa:	4f16      	ldr	r7, [pc, #88]	; (c0d00e54 <get_uint_128+0x64>)
c0d00dfc:	4638      	mov	r0, r7
c0d00dfe:	f004 fd1d 	bl	c0d0583c <clear128>
c0d00e02:	2100      	movs	r1, #0
    UPPER_P(ten) = 0;
    LOWER_P(ten) = 10;
c0d00e04:	200a      	movs	r0, #10
    // log[log_p++] = 't';
    // log[log_p++] = *(ch.value_length);

    uint128_t *ten = &uint128_t_cache2;
    clear128(ten);
    UPPER_P(ten) = 0;
c0d00e06:	6039      	str	r1, [r7, #0]
c0d00e08:	6079      	str	r1, [r7, #4]
    LOWER_P(ten) = 10;
c0d00e0a:	60b8      	str	r0, [r7, #8]
c0d00e0c:	9102      	str	r1, [sp, #8]
c0d00e0e:	60f9      	str	r1, [r7, #12]

    uint128_t *read = &uint128_t_cache3;

    for(int i = 0; i < *(ch.value_length); i++){
c0d00e10:	6828      	ldr	r0, [r5, #0]
c0d00e12:	2801      	cmp	r0, #1
c0d00e14:	db1b      	blt.n	c0d00e4e <get_uint_128+0x5e>
c0d00e16:	4f10      	ldr	r7, [pc, #64]	; (c0d00e58 <get_uint_128+0x68>)
c0d00e18:	9c02      	ldr	r4, [sp, #8]
        mul128(value, ten, value);
c0d00e1a:	4630      	mov	r0, r6
c0d00e1c:	490d      	ldr	r1, [pc, #52]	; (c0d00e54 <get_uint_128+0x64>)
c0d00e1e:	4632      	mov	r2, r6
c0d00e20:	f004 fd48 	bl	c0d058b4 <mul128>

        clear128(read);
c0d00e24:	4638      	mov	r0, r7
c0d00e26:	f004 fd09 	bl	c0d0583c <clear128>
c0d00e2a:	9802      	ldr	r0, [sp, #8]
        UPPER_P(read) = 0;
c0d00e2c:	6078      	str	r0, [r7, #4]
c0d00e2e:	6038      	str	r0, [r7, #0]
        LOWER_P(read) = (ch.cache[i] - 48);
c0d00e30:	9801      	ldr	r0, [sp, #4]
c0d00e32:	5d00      	ldrb	r0, [r0, r4]
c0d00e34:	3830      	subs	r0, #48	; 0x30
c0d00e36:	60b8      	str	r0, [r7, #8]
c0d00e38:	17c0      	asrs	r0, r0, #31
c0d00e3a:	60f8      	str	r0, [r7, #12]
        add128(value, read, value);
c0d00e3c:	4630      	mov	r0, r6
c0d00e3e:	4639      	mov	r1, r7
c0d00e40:	4632      	mov	r2, r6
c0d00e42:	f004 fd06 	bl	c0d05852 <add128>
    UPPER_P(ten) = 0;
    LOWER_P(ten) = 10;

    uint128_t *read = &uint128_t_cache3;

    for(int i = 0; i < *(ch.value_length); i++){
c0d00e46:	1c64      	adds	r4, r4, #1
c0d00e48:	6828      	ldr	r0, [r5, #0]
c0d00e4a:	4284      	cmp	r4, r0
c0d00e4c:	dbe5      	blt.n	c0d00e1a <get_uint_128+0x2a>
        LOWER_P(read) = (ch.cache[i] - 48);
        add128(value, read, value);

        // log[log_p++] = ch.cache[i];
    }
}
c0d00e4e:	b003      	add	sp, #12
c0d00e50:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e52:	46c0      	nop			; (mov r8, r8)
c0d00e54:	20001f80 	.word	0x20001f80
c0d00e58:	20001f90 	.word	0x20001f90

c0d00e5c <find_fee>:

void find_fee(cache_holder ch, bool *go_next){
c0d00e5c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e5e:	b08d      	sub	sp, #52	; 0x34
c0d00e60:	930b      	str	r3, [sp, #44]	; 0x2c
c0d00e62:	920a      	str	r2, [sp, #40]	; 0x28
c0d00e64:	460d      	mov	r5, r1
c0d00e66:	9508      	str	r5, [sp, #32]
c0d00e68:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d00e6a:	900c      	str	r0, [sp, #48]	; 0x30
    ch.flag = "fee";
    int pre_str_size = 3;
    (*(ch.value_length)) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d00e6c:	9b0c      	ldr	r3, [sp, #48]	; 0x30

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d00e6e:	2101      	movs	r1, #1
c0d00e70:	4668      	mov	r0, sp
c0d00e72:	9107      	str	r1, [sp, #28]
c0d00e74:	6081      	str	r1, [r0, #8]
c0d00e76:	2103      	movs	r1, #3
c0d00e78:	6001      	str	r1, [r0, #0]
c0d00e7a:	491c      	ldr	r1, [pc, #112]	; (c0d00eec <find_fee+0x90>)
c0d00e7c:	4479      	add	r1, pc
c0d00e7e:	9109      	str	r1, [sp, #36]	; 0x24
c0d00e80:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d00e82:	4610      	mov	r0, r2
c0d00e84:	4622      	mov	r2, r4
c0d00e86:	f7ff ff1f 	bl	c0d00cc8 <find_data_processor>
}

void find_fee(cache_holder ch, bool *go_next){
    ch.flag = "fee";
    int pre_str_size = 3;
    (*(ch.value_length)) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d00e8a:	6028      	str	r0, [r5, #0]
    
    uint128_t *fee = &uint128_t_cache1;
    clear128(fee);
c0d00e8c:	4e16      	ldr	r6, [pc, #88]	; (c0d00ee8 <find_fee+0x8c>)
c0d00e8e:	4630      	mov	r0, r6
c0d00e90:	f004 fcd4 	bl	c0d0583c <clear128>
c0d00e94:	2000      	movs	r0, #0
    UPPER_P(fee) = 0;
    LOWER_P(fee) = 0;
c0d00e96:	6030      	str	r0, [r6, #0]
c0d00e98:	6070      	str	r0, [r6, #4]
c0d00e9a:	60b0      	str	r0, [r6, #8]
c0d00e9c:	60f0      	str	r0, [r6, #12]
    get_uint_128(fee, ch);
c0d00e9e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00ea0:	9f17      	ldr	r7, [sp, #92]	; 0x5c
c0d00ea2:	4669      	mov	r1, sp
c0d00ea4:	618f      	str	r7, [r1, #24]
c0d00ea6:	9d16      	ldr	r5, [sp, #88]	; 0x58
c0d00ea8:	614d      	str	r5, [r1, #20]
c0d00eaa:	6108      	str	r0, [r1, #16]
c0d00eac:	60cc      	str	r4, [r1, #12]
c0d00eae:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d00eb0:	6088      	str	r0, [r1, #8]
c0d00eb2:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d00eb4:	6048      	str	r0, [r1, #4]
c0d00eb6:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00eb8:	6008      	str	r0, [r1, #0]
c0d00eba:	4630      	mov	r0, r6
c0d00ebc:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d00ebe:	9a08      	ldr	r2, [sp, #32]
c0d00ec0:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d00ec2:	f7ff ff95 	bl	c0d00df0 <get_uint_128>

    int p = get_uint_128_bytes(fee, &(ch.encode[(*(ch.encode_p))]));
c0d00ec6:	6828      	ldr	r0, [r5, #0]
c0d00ec8:	1839      	adds	r1, r7, r0
c0d00eca:	4630      	mov	r0, r6
c0d00ecc:	f001 ff18 	bl	c0d02d00 <get_uint_128_bytes>
    (*(ch.encode_p)) += p;
c0d00ed0:	6829      	ldr	r1, [r5, #0]
c0d00ed2:	1809      	adds	r1, r1, r0
c0d00ed4:	6029      	str	r1, [r5, #0]
c0d00ed6:	9918      	ldr	r1, [sp, #96]	; 0x60
        // operation->data[data_p++] = (char)(value_length + 48);
        read_message(ch);
    }
#endif 
    
    while(p < 16){};
c0d00ed8:	280f      	cmp	r0, #15
c0d00eda:	dc00      	bgt.n	c0d00ede <find_fee+0x82>
c0d00edc:	e7fe      	b.n	c0d00edc <find_fee+0x80>

    (*go_next) = true;
c0d00ede:	9807      	ldr	r0, [sp, #28]
c0d00ee0:	7008      	strb	r0, [r1, #0]
}
c0d00ee2:	b00d      	add	sp, #52	; 0x34
c0d00ee4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ee6:	46c0      	nop			; (mov r8, r8)
c0d00ee8:	20001f70 	.word	0x20001f70
c0d00eec:	000062df 	.word	0x000062df

c0d00ef0 <find_creator>:

short find_creator(cache_holder ch, bool *go_next){
c0d00ef0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ef2:	b08d      	sub	sp, #52	; 0x34
c0d00ef4:	930a      	str	r3, [sp, #40]	; 0x28
c0d00ef6:	4615      	mov	r5, r2
c0d00ef8:	460e      	mov	r6, r1
c0d00efa:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d00efc:	900c      	str	r0, [sp, #48]	; 0x30
    ch.flag = "creator";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d00efe:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00f00:	2101      	movs	r1, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d00f02:	4668      	mov	r0, sp
c0d00f04:	910b      	str	r1, [sp, #44]	; 0x2c
c0d00f06:	6081      	str	r1, [r0, #8]
c0d00f08:	2107      	movs	r1, #7
c0d00f0a:	6001      	str	r1, [r0, #0]
c0d00f0c:	4927      	ldr	r1, [pc, #156]	; (c0d00fac <find_creator+0xbc>)
c0d00f0e:	4479      	add	r1, pc
c0d00f10:	9a14      	ldr	r2, [sp, #80]	; 0x50
c0d00f12:	4628      	mov	r0, r5
c0d00f14:	9208      	str	r2, [sp, #32]
c0d00f16:	f7ff fed7 	bl	c0d00cc8 <find_data_processor>
}

short find_creator(cache_holder ch, bool *go_next){
    ch.flag = "creator";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d00f1a:	6030      	str	r0, [r6, #0]
    
    // log[log_p++] = 'd';
    // log[log_p++] = *(ch.encode_p);
    // log[log_p++] = 'd';

    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d00f1c:	6830      	ldr	r0, [r6, #0]
c0d00f1e:	9f16      	ldr	r7, [sp, #88]	; 0x58
c0d00f20:	6839      	ldr	r1, [r7, #0]
c0d00f22:	1c4a      	adds	r2, r1, #1
c0d00f24:	603a      	str	r2, [r7, #0]
c0d00f26:	9c17      	ldr	r4, [sp, #92]	; 0x5c
c0d00f28:	5460      	strb	r0, [r4, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d00f2a:	6838      	ldr	r0, [r7, #0]
c0d00f2c:	1820      	adds	r0, r4, r0
c0d00f2e:	6832      	ldr	r2, [r6, #0]
c0d00f30:	9509      	str	r5, [sp, #36]	; 0x24
c0d00f32:	4629      	mov	r1, r5
c0d00f34:	f001 ff3a 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d00f38:	6830      	ldr	r0, [r6, #0]
c0d00f3a:	6839      	ldr	r1, [r7, #0]
c0d00f3c:	1808      	adds	r0, r1, r0
c0d00f3e:	6038      	str	r0, [r7, #0]

    // log[log_p++] = (*(ch.value_length) + 48);

#ifdef UI_SHOW_CREATOR
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d00f40:	6830      	ldr	r0, [r6, #0]
c0d00f42:	9a18      	ldr	r2, [sp, #96]	; 0x60
c0d00f44:	2801      	cmp	r0, #1
c0d00f46:	db25      	blt.n	c0d00f94 <find_creator+0xa4>
c0d00f48:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d00f4a:	6828      	ldr	r0, [r5, #0]
c0d00f4c:	6831      	ldr	r1, [r6, #0]
c0d00f4e:	1840      	adds	r0, r0, r1
c0d00f50:	3008      	adds	r0, #8
c0d00f52:	287e      	cmp	r0, #126	; 0x7e
c0d00f54:	dc1e      	bgt.n	c0d00f94 <find_creator+0xa4>
c0d00f56:	9813      	ldr	r0, [sp, #76]	; 0x4c
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"creator=", pre_str_size + 1);
c0d00f58:	9006      	str	r0, [sp, #24]
c0d00f5a:	6800      	ldr	r0, [r0, #0]
c0d00f5c:	6829      	ldr	r1, [r5, #0]
c0d00f5e:	1840      	adds	r0, r0, r1
c0d00f60:	a10f      	add	r1, pc, #60	; (adr r1, c0d00fa0 <find_creator+0xb0>)
c0d00f62:	9207      	str	r2, [sp, #28]
c0d00f64:	2208      	movs	r2, #8
c0d00f66:	f001 ff21 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d00f6a:	6828      	ldr	r0, [r5, #0]
c0d00f6c:	3008      	adds	r0, #8
c0d00f6e:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d00f70:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00f72:	4669      	mov	r1, sp
c0d00f74:	600d      	str	r5, [r1, #0]
c0d00f76:	9a06      	ldr	r2, [sp, #24]
c0d00f78:	604a      	str	r2, [r1, #4]
c0d00f7a:	9a08      	ldr	r2, [sp, #32]
c0d00f7c:	608a      	str	r2, [r1, #8]
c0d00f7e:	60c8      	str	r0, [r1, #12]
c0d00f80:	610f      	str	r7, [r1, #16]
c0d00f82:	614c      	str	r4, [r1, #20]
c0d00f84:	480a      	ldr	r0, [pc, #40]	; (c0d00fb0 <find_creator+0xc0>)
c0d00f86:	4478      	add	r0, pc
c0d00f88:	4631      	mov	r1, r6
c0d00f8a:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d00f8c:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d00f8e:	f7ff ff17 	bl	c0d00dc0 <read_message>
c0d00f92:	9a07      	ldr	r2, [sp, #28]
    }
#endif 

    *go_next = true;
c0d00f94:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d00f96:	7010      	strb	r0, [r2, #0]
c0d00f98:	2000      	movs	r0, #0
}
c0d00f9a:	b00d      	add	sp, #52	; 0x34
c0d00f9c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f9e:	46c0      	nop			; (mov r8, r8)
c0d00fa0:	61657263 	.word	0x61657263
c0d00fa4:	3d726f74 	.word	0x3d726f74
c0d00fa8:	00000000 	.word	0x00000000
c0d00fac:	000061da 	.word	0x000061da
c0d00fb0:	00006162 	.word	0x00006162

c0d00fb4 <find_proposaler>:

short find_proposaler(cache_holder ch, bool *go_next){
c0d00fb4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00fb6:	b08d      	sub	sp, #52	; 0x34
c0d00fb8:	930a      	str	r3, [sp, #40]	; 0x28
c0d00fba:	4615      	mov	r5, r2
c0d00fbc:	460e      	mov	r6, r1
c0d00fbe:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d00fc0:	900c      	str	r0, [sp, #48]	; 0x30
    ch.flag = "proposaler";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d00fc2:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d00fc4:	2101      	movs	r1, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d00fc6:	4668      	mov	r0, sp
c0d00fc8:	910b      	str	r1, [sp, #44]	; 0x2c
c0d00fca:	6081      	str	r1, [r0, #8]
c0d00fcc:	210a      	movs	r1, #10
c0d00fce:	6001      	str	r1, [r0, #0]
c0d00fd0:	4927      	ldr	r1, [pc, #156]	; (c0d01070 <find_proposaler+0xbc>)
c0d00fd2:	4479      	add	r1, pc
c0d00fd4:	9a14      	ldr	r2, [sp, #80]	; 0x50
c0d00fd6:	4628      	mov	r0, r5
c0d00fd8:	9208      	str	r2, [sp, #32]
c0d00fda:	f7ff fe75 	bl	c0d00cc8 <find_data_processor>
}

short find_proposaler(cache_holder ch, bool *go_next){
    ch.flag = "proposaler";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d00fde:	6030      	str	r0, [r6, #0]
    
    // log[log_p++] = 'd';
    // log[log_p++] = *(ch.encode_p);
    // log[log_p++] = 'd';

    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d00fe0:	6830      	ldr	r0, [r6, #0]
c0d00fe2:	9f16      	ldr	r7, [sp, #88]	; 0x58
c0d00fe4:	6839      	ldr	r1, [r7, #0]
c0d00fe6:	1c4a      	adds	r2, r1, #1
c0d00fe8:	603a      	str	r2, [r7, #0]
c0d00fea:	9c17      	ldr	r4, [sp, #92]	; 0x5c
c0d00fec:	5460      	strb	r0, [r4, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d00fee:	6838      	ldr	r0, [r7, #0]
c0d00ff0:	1820      	adds	r0, r4, r0
c0d00ff2:	6832      	ldr	r2, [r6, #0]
c0d00ff4:	9509      	str	r5, [sp, #36]	; 0x24
c0d00ff6:	4629      	mov	r1, r5
c0d00ff8:	f001 fed8 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d00ffc:	6830      	ldr	r0, [r6, #0]
c0d00ffe:	6839      	ldr	r1, [r7, #0]
c0d01000:	1808      	adds	r0, r1, r0
c0d01002:	6038      	str	r0, [r7, #0]

    // log[log_p++] = (*(ch.value_length) + 48);

#ifdef UI_PROPOSALER
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d01004:	6830      	ldr	r0, [r6, #0]
c0d01006:	9a18      	ldr	r2, [sp, #96]	; 0x60
c0d01008:	2801      	cmp	r0, #1
c0d0100a:	db25      	blt.n	c0d01058 <find_proposaler+0xa4>
c0d0100c:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d0100e:	6828      	ldr	r0, [r5, #0]
c0d01010:	6831      	ldr	r1, [r6, #0]
c0d01012:	1840      	adds	r0, r0, r1
c0d01014:	300b      	adds	r0, #11
c0d01016:	287e      	cmp	r0, #126	; 0x7e
c0d01018:	dc1e      	bgt.n	c0d01058 <find_proposaler+0xa4>
c0d0101a:	9813      	ldr	r0, [sp, #76]	; 0x4c
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"proposaler=", pre_str_size + 1);
c0d0101c:	9006      	str	r0, [sp, #24]
c0d0101e:	6800      	ldr	r0, [r0, #0]
c0d01020:	6829      	ldr	r1, [r5, #0]
c0d01022:	1840      	adds	r0, r0, r1
c0d01024:	a10f      	add	r1, pc, #60	; (adr r1, c0d01064 <find_proposaler+0xb0>)
c0d01026:	9207      	str	r2, [sp, #28]
c0d01028:	220b      	movs	r2, #11
c0d0102a:	f001 febf 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d0102e:	6828      	ldr	r0, [r5, #0]
c0d01030:	300b      	adds	r0, #11
c0d01032:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d01034:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01036:	4669      	mov	r1, sp
c0d01038:	600d      	str	r5, [r1, #0]
c0d0103a:	9a06      	ldr	r2, [sp, #24]
c0d0103c:	604a      	str	r2, [r1, #4]
c0d0103e:	9a08      	ldr	r2, [sp, #32]
c0d01040:	608a      	str	r2, [r1, #8]
c0d01042:	60c8      	str	r0, [r1, #12]
c0d01044:	610f      	str	r7, [r1, #16]
c0d01046:	614c      	str	r4, [r1, #20]
c0d01048:	480a      	ldr	r0, [pc, #40]	; (c0d01074 <find_proposaler+0xc0>)
c0d0104a:	4478      	add	r0, pc
c0d0104c:	4631      	mov	r1, r6
c0d0104e:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d01050:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01052:	f7ff feb5 	bl	c0d00dc0 <read_message>
c0d01056:	9a07      	ldr	r2, [sp, #28]
    }
#endif 

    *go_next = true;
c0d01058:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0105a:	7010      	strb	r0, [r2, #0]
c0d0105c:	2000      	movs	r0, #0
}
c0d0105e:	b00d      	add	sp, #52	; 0x34
c0d01060:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01062:	46c0      	nop			; (mov r8, r8)
c0d01064:	706f7270 	.word	0x706f7270
c0d01068:	6c61736f 	.word	0x6c61736f
c0d0106c:	003d7265 	.word	0x003d7265
c0d01070:	0000611e 	.word	0x0000611e
c0d01074:	000060a6 	.word	0x000060a6

c0d01078 <find_pledger>:

short find_pledger(cache_holder ch, bool *go_next){
c0d01078:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0107a:	b08d      	sub	sp, #52	; 0x34
c0d0107c:	930a      	str	r3, [sp, #40]	; 0x28
c0d0107e:	4615      	mov	r5, r2
c0d01080:	460e      	mov	r6, r1
c0d01082:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d01084:	900c      	str	r0, [sp, #48]	; 0x30
    ch.flag = "pledger";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01086:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d01088:	2101      	movs	r1, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d0108a:	4668      	mov	r0, sp
c0d0108c:	910b      	str	r1, [sp, #44]	; 0x2c
c0d0108e:	6081      	str	r1, [r0, #8]
c0d01090:	2107      	movs	r1, #7
c0d01092:	6001      	str	r1, [r0, #0]
c0d01094:	4927      	ldr	r1, [pc, #156]	; (c0d01134 <find_pledger+0xbc>)
c0d01096:	4479      	add	r1, pc
c0d01098:	9a14      	ldr	r2, [sp, #80]	; 0x50
c0d0109a:	4628      	mov	r0, r5
c0d0109c:	9208      	str	r2, [sp, #32]
c0d0109e:	f7ff fe13 	bl	c0d00cc8 <find_data_processor>
}

short find_pledger(cache_holder ch, bool *go_next){
    ch.flag = "pledger";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d010a2:	6030      	str	r0, [r6, #0]

    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d010a4:	6830      	ldr	r0, [r6, #0]
c0d010a6:	9f16      	ldr	r7, [sp, #88]	; 0x58
c0d010a8:	6839      	ldr	r1, [r7, #0]
c0d010aa:	1c4a      	adds	r2, r1, #1
c0d010ac:	603a      	str	r2, [r7, #0]
c0d010ae:	9c17      	ldr	r4, [sp, #92]	; 0x5c
c0d010b0:	5460      	strb	r0, [r4, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d010b2:	6838      	ldr	r0, [r7, #0]
c0d010b4:	1820      	adds	r0, r4, r0
c0d010b6:	6832      	ldr	r2, [r6, #0]
c0d010b8:	9509      	str	r5, [sp, #36]	; 0x24
c0d010ba:	4629      	mov	r1, r5
c0d010bc:	f001 fe76 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d010c0:	6830      	ldr	r0, [r6, #0]
c0d010c2:	6839      	ldr	r1, [r7, #0]
c0d010c4:	1808      	adds	r0, r1, r0
c0d010c6:	6038      	str	r0, [r7, #0]

#ifdef UI_SHOW_PLEDGER
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d010c8:	6830      	ldr	r0, [r6, #0]
c0d010ca:	9a18      	ldr	r2, [sp, #96]	; 0x60
c0d010cc:	2801      	cmp	r0, #1
c0d010ce:	db25      	blt.n	c0d0111c <find_pledger+0xa4>
c0d010d0:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d010d2:	6828      	ldr	r0, [r5, #0]
c0d010d4:	6831      	ldr	r1, [r6, #0]
c0d010d6:	1840      	adds	r0, r0, r1
c0d010d8:	3008      	adds	r0, #8
c0d010da:	287e      	cmp	r0, #126	; 0x7e
c0d010dc:	dc1e      	bgt.n	c0d0111c <find_pledger+0xa4>
c0d010de:	9813      	ldr	r0, [sp, #76]	; 0x4c
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"pledger=", pre_str_size + 1);
c0d010e0:	9006      	str	r0, [sp, #24]
c0d010e2:	6800      	ldr	r0, [r0, #0]
c0d010e4:	6829      	ldr	r1, [r5, #0]
c0d010e6:	1840      	adds	r0, r0, r1
c0d010e8:	a10f      	add	r1, pc, #60	; (adr r1, c0d01128 <find_pledger+0xb0>)
c0d010ea:	9207      	str	r2, [sp, #28]
c0d010ec:	2208      	movs	r2, #8
c0d010ee:	f001 fe5d 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d010f2:	6828      	ldr	r0, [r5, #0]
c0d010f4:	3008      	adds	r0, #8
c0d010f6:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d010f8:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d010fa:	4669      	mov	r1, sp
c0d010fc:	600d      	str	r5, [r1, #0]
c0d010fe:	9a06      	ldr	r2, [sp, #24]
c0d01100:	604a      	str	r2, [r1, #4]
c0d01102:	9a08      	ldr	r2, [sp, #32]
c0d01104:	608a      	str	r2, [r1, #8]
c0d01106:	60c8      	str	r0, [r1, #12]
c0d01108:	610f      	str	r7, [r1, #16]
c0d0110a:	614c      	str	r4, [r1, #20]
c0d0110c:	480a      	ldr	r0, [pc, #40]	; (c0d01138 <find_pledger+0xc0>)
c0d0110e:	4478      	add	r0, pc
c0d01110:	4631      	mov	r1, r6
c0d01112:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d01114:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01116:	f7ff fe53 	bl	c0d00dc0 <read_message>
c0d0111a:	9a07      	ldr	r2, [sp, #28]
    }
#endif 

    *go_next = true;
c0d0111c:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d0111e:	7010      	strb	r0, [r2, #0]
c0d01120:	2000      	movs	r0, #0
}
c0d01122:	b00d      	add	sp, #52	; 0x34
c0d01124:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01126:	46c0      	nop			; (mov r8, r8)
c0d01128:	64656c70 	.word	0x64656c70
c0d0112c:	3d726567 	.word	0x3d726567
c0d01130:	00000000 	.word	0x00000000
c0d01134:	00006065 	.word	0x00006065
c0d01138:	00005fed 	.word	0x00005fed

c0d0113c <find_side>:

void find_side(cache_holder ch){
c0d0113c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0113e:	b08b      	sub	sp, #44	; 0x2c
c0d01140:	9309      	str	r3, [sp, #36]	; 0x24
c0d01142:	4614      	mov	r4, r2
c0d01144:	460e      	mov	r6, r1
c0d01146:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d01148:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "side";
    int pre_str_size = 4;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d0114a:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0114c:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d0114e:	4669      	mov	r1, sp
c0d01150:	6088      	str	r0, [r1, #8]
c0d01152:	2004      	movs	r0, #4
c0d01154:	6008      	str	r0, [r1, #0]
c0d01156:	491e      	ldr	r1, [pc, #120]	; (c0d011d0 <find_side+0x94>)
c0d01158:	4479      	add	r1, pc
c0d0115a:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d0115c:	4620      	mov	r0, r4
c0d0115e:	9207      	str	r2, [sp, #28]
c0d01160:	f7ff fdb2 	bl	c0d00cc8 <find_data_processor>
}

void find_side(cache_holder ch){
    ch.flag = "side";
    int pre_str_size = 4;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01164:	6030      	str	r0, [r6, #0]
c0d01166:	9408      	str	r4, [sp, #32]
    
    ch.encode[(*(ch.encode_p))++] = (char) (ch.cache[0] - 48);
c0d01168:	7820      	ldrb	r0, [r4, #0]
c0d0116a:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d0116c:	6821      	ldr	r1, [r4, #0]
c0d0116e:	1c4a      	adds	r2, r1, #1
c0d01170:	6022      	str	r2, [r4, #0]
c0d01172:	30d0      	adds	r0, #208	; 0xd0
c0d01174:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d01176:	5478      	strb	r0, [r7, r1]

#ifdef UI_SHOW_SIDE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d01178:	6830      	ldr	r0, [r6, #0]
c0d0117a:	2801      	cmp	r0, #1
c0d0117c:	db22      	blt.n	c0d011c4 <find_side+0x88>
c0d0117e:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d01180:	6828      	ldr	r0, [r5, #0]
c0d01182:	6831      	ldr	r1, [r6, #0]
c0d01184:	1840      	adds	r0, r0, r1
c0d01186:	1d40      	adds	r0, r0, #5
c0d01188:	287e      	cmp	r0, #126	; 0x7e
c0d0118a:	dc1b      	bgt.n	c0d011c4 <find_side+0x88>
c0d0118c:	9811      	ldr	r0, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"side=", pre_str_size + 1);
c0d0118e:	9006      	str	r0, [sp, #24]
c0d01190:	6800      	ldr	r0, [r0, #0]
c0d01192:	6829      	ldr	r1, [r5, #0]
c0d01194:	1840      	adds	r0, r0, r1
c0d01196:	a10c      	add	r1, pc, #48	; (adr r1, c0d011c8 <find_side+0x8c>)
c0d01198:	2205      	movs	r2, #5
c0d0119a:	f001 fe07 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d0119e:	6828      	ldr	r0, [r5, #0]
c0d011a0:	1d40      	adds	r0, r0, #5
c0d011a2:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d011a4:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d011a6:	4669      	mov	r1, sp
c0d011a8:	600d      	str	r5, [r1, #0]
c0d011aa:	9a06      	ldr	r2, [sp, #24]
c0d011ac:	604a      	str	r2, [r1, #4]
c0d011ae:	9a07      	ldr	r2, [sp, #28]
c0d011b0:	608a      	str	r2, [r1, #8]
c0d011b2:	310c      	adds	r1, #12
c0d011b4:	c191      	stmia	r1!, {r0, r4, r7}
c0d011b6:	4807      	ldr	r0, [pc, #28]	; (c0d011d4 <find_side+0x98>)
c0d011b8:	4478      	add	r0, pc
c0d011ba:	4631      	mov	r1, r6
c0d011bc:	9a08      	ldr	r2, [sp, #32]
c0d011be:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d011c0:	f7ff fdfe 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d011c4:	b00b      	add	sp, #44	; 0x2c
c0d011c6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d011c8:	65646973 	.word	0x65646973
c0d011cc:	0000003d 	.word	0x0000003d
c0d011d0:	00005fab 	.word	0x00005fab
c0d011d4:	00005f4b 	.word	0x00005f4b

c0d011d8 <find_order_type>:

void find_order_type(cache_holder ch){
c0d011d8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d011da:	b08b      	sub	sp, #44	; 0x2c
c0d011dc:	9309      	str	r3, [sp, #36]	; 0x24
c0d011de:	4614      	mov	r4, r2
c0d011e0:	460e      	mov	r6, r1
c0d011e2:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d011e4:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "order_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d011e6:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d011e8:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d011ea:	4669      	mov	r1, sp
c0d011ec:	6088      	str	r0, [r1, #8]
c0d011ee:	200a      	movs	r0, #10
c0d011f0:	6008      	str	r0, [r1, #0]
c0d011f2:	491f      	ldr	r1, [pc, #124]	; (c0d01270 <find_order_type+0x98>)
c0d011f4:	4479      	add	r1, pc
c0d011f6:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d011f8:	4620      	mov	r0, r4
c0d011fa:	9207      	str	r2, [sp, #28]
c0d011fc:	f7ff fd64 	bl	c0d00cc8 <find_data_processor>
}

void find_order_type(cache_holder ch){
    ch.flag = "order_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01200:	6030      	str	r0, [r6, #0]
c0d01202:	9408      	str	r4, [sp, #32]

    ch.encode[(*(ch.encode_p))++] = (char) (ch.cache[0] - 48);
c0d01204:	7820      	ldrb	r0, [r4, #0]
c0d01206:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d01208:	6821      	ldr	r1, [r4, #0]
c0d0120a:	1c4a      	adds	r2, r1, #1
c0d0120c:	6022      	str	r2, [r4, #0]
c0d0120e:	30d0      	adds	r0, #208	; 0xd0
c0d01210:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d01212:	5478      	strb	r0, [r7, r1]

#ifdef UI_SHOW_ORDER_TYPE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d01214:	6830      	ldr	r0, [r6, #0]
c0d01216:	2801      	cmp	r0, #1
c0d01218:	db22      	blt.n	c0d01260 <find_order_type+0x88>
c0d0121a:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d0121c:	6828      	ldr	r0, [r5, #0]
c0d0121e:	6831      	ldr	r1, [r6, #0]
c0d01220:	1840      	adds	r0, r0, r1
c0d01222:	300b      	adds	r0, #11
c0d01224:	287e      	cmp	r0, #126	; 0x7e
c0d01226:	dc1b      	bgt.n	c0d01260 <find_order_type+0x88>
c0d01228:	9811      	ldr	r0, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"order_type=", pre_str_size + 1);
c0d0122a:	9006      	str	r0, [sp, #24]
c0d0122c:	6800      	ldr	r0, [r0, #0]
c0d0122e:	6829      	ldr	r1, [r5, #0]
c0d01230:	1840      	adds	r0, r0, r1
c0d01232:	a10c      	add	r1, pc, #48	; (adr r1, c0d01264 <find_order_type+0x8c>)
c0d01234:	220b      	movs	r2, #11
c0d01236:	f001 fdb9 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d0123a:	6828      	ldr	r0, [r5, #0]
c0d0123c:	300b      	adds	r0, #11
c0d0123e:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d01240:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01242:	4669      	mov	r1, sp
c0d01244:	600d      	str	r5, [r1, #0]
c0d01246:	9a06      	ldr	r2, [sp, #24]
c0d01248:	604a      	str	r2, [r1, #4]
c0d0124a:	9a07      	ldr	r2, [sp, #28]
c0d0124c:	608a      	str	r2, [r1, #8]
c0d0124e:	310c      	adds	r1, #12
c0d01250:	c191      	stmia	r1!, {r0, r4, r7}
c0d01252:	4808      	ldr	r0, [pc, #32]	; (c0d01274 <find_order_type+0x9c>)
c0d01254:	4478      	add	r0, pc
c0d01256:	4631      	mov	r1, r6
c0d01258:	9a08      	ldr	r2, [sp, #32]
c0d0125a:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d0125c:	f7ff fdb0 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d01260:	b00b      	add	sp, #44	; 0x2c
c0d01262:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01264:	6564726f 	.word	0x6564726f
c0d01268:	79745f72 	.word	0x79745f72
c0d0126c:	003d6570 	.word	0x003d6570
c0d01270:	00005f14 	.word	0x00005f14
c0d01274:	00005eb4 	.word	0x00005eb4

c0d01278 <find_market_name>:

void find_market_name(cache_holder ch){
c0d01278:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0127a:	b08b      	sub	sp, #44	; 0x2c
c0d0127c:	9309      	str	r3, [sp, #36]	; 0x24
c0d0127e:	4615      	mov	r5, r2
c0d01280:	460e      	mov	r6, r1
c0d01282:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d01284:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "market_name";
    int pre_str_size = 11;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01286:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01288:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d0128a:	4669      	mov	r1, sp
c0d0128c:	6088      	str	r0, [r1, #8]
c0d0128e:	200b      	movs	r0, #11
c0d01290:	6008      	str	r0, [r1, #0]
c0d01292:	4925      	ldr	r1, [pc, #148]	; (c0d01328 <find_market_name+0xb0>)
c0d01294:	4479      	add	r1, pc
c0d01296:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d01298:	4628      	mov	r0, r5
c0d0129a:	9207      	str	r2, [sp, #28]
c0d0129c:	f7ff fd14 	bl	c0d00cc8 <find_data_processor>
}

void find_market_name(cache_holder ch){
    ch.flag = "market_name";
    int pre_str_size = 11;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d012a0:	6030      	str	r0, [r6, #0]
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d012a2:	6830      	ldr	r0, [r6, #0]
c0d012a4:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d012a6:	6821      	ldr	r1, [r4, #0]
c0d012a8:	1c4a      	adds	r2, r1, #1
c0d012aa:	6022      	str	r2, [r4, #0]
c0d012ac:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d012ae:	5478      	strb	r0, [r7, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d012b0:	6820      	ldr	r0, [r4, #0]
c0d012b2:	1838      	adds	r0, r7, r0
c0d012b4:	6832      	ldr	r2, [r6, #0]
c0d012b6:	9508      	str	r5, [sp, #32]
c0d012b8:	4629      	mov	r1, r5
c0d012ba:	f001 fd77 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d012be:	6830      	ldr	r0, [r6, #0]
c0d012c0:	6821      	ldr	r1, [r4, #0]
c0d012c2:	1808      	adds	r0, r1, r0
c0d012c4:	6020      	str	r0, [r4, #0]

#ifdef UI_SHOW_MARKET_NAME
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d012c6:	6830      	ldr	r0, [r6, #0]
c0d012c8:	2801      	cmp	r0, #1
c0d012ca:	db22      	blt.n	c0d01312 <find_market_name+0x9a>
c0d012cc:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d012ce:	6828      	ldr	r0, [r5, #0]
c0d012d0:	6831      	ldr	r1, [r6, #0]
c0d012d2:	1840      	adds	r0, r0, r1
c0d012d4:	300c      	adds	r0, #12
c0d012d6:	287e      	cmp	r0, #126	; 0x7e
c0d012d8:	dc1b      	bgt.n	c0d01312 <find_market_name+0x9a>
c0d012da:	9811      	ldr	r0, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"market_name=", pre_str_size + 1);
c0d012dc:	9006      	str	r0, [sp, #24]
c0d012de:	6800      	ldr	r0, [r0, #0]
c0d012e0:	6829      	ldr	r1, [r5, #0]
c0d012e2:	1840      	adds	r0, r0, r1
c0d012e4:	a10c      	add	r1, pc, #48	; (adr r1, c0d01318 <find_market_name+0xa0>)
c0d012e6:	220c      	movs	r2, #12
c0d012e8:	f001 fd60 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d012ec:	6828      	ldr	r0, [r5, #0]
c0d012ee:	300c      	adds	r0, #12
c0d012f0:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d012f2:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d012f4:	4669      	mov	r1, sp
c0d012f6:	600d      	str	r5, [r1, #0]
c0d012f8:	9a06      	ldr	r2, [sp, #24]
c0d012fa:	604a      	str	r2, [r1, #4]
c0d012fc:	9a07      	ldr	r2, [sp, #28]
c0d012fe:	608a      	str	r2, [r1, #8]
c0d01300:	310c      	adds	r1, #12
c0d01302:	c191      	stmia	r1!, {r0, r4, r7}
c0d01304:	4809      	ldr	r0, [pc, #36]	; (c0d0132c <find_market_name+0xb4>)
c0d01306:	4478      	add	r0, pc
c0d01308:	4631      	mov	r1, r6
c0d0130a:	9a08      	ldr	r2, [sp, #32]
c0d0130c:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d0130e:	f7ff fd57 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d01312:	b00b      	add	sp, #44	; 0x2c
c0d01314:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01316:	46c0      	nop			; (mov r8, r8)
c0d01318:	6b72616d 	.word	0x6b72616d
c0d0131c:	6e5f7465 	.word	0x6e5f7465
c0d01320:	3d656d61 	.word	0x3d656d61
c0d01324:	00000000 	.word	0x00000000
c0d01328:	00005e7f 	.word	0x00005e7f
c0d0132c:	00005e0d 	.word	0x00005e0d

c0d01330 <find_from>:

void find_from(cache_holder ch){
c0d01330:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01332:	b08b      	sub	sp, #44	; 0x2c
c0d01334:	9309      	str	r3, [sp, #36]	; 0x24
c0d01336:	4615      	mov	r5, r2
c0d01338:	460e      	mov	r6, r1
c0d0133a:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d0133c:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "from";
    int pre_str_size = 4;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d0133e:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d01340:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01342:	4669      	mov	r1, sp
c0d01344:	6088      	str	r0, [r1, #8]
c0d01346:	2004      	movs	r0, #4
c0d01348:	6008      	str	r0, [r1, #0]
c0d0134a:	4923      	ldr	r1, [pc, #140]	; (c0d013d8 <find_from+0xa8>)
c0d0134c:	4479      	add	r1, pc
c0d0134e:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d01350:	4628      	mov	r0, r5
c0d01352:	9207      	str	r2, [sp, #28]
c0d01354:	f7ff fcb8 	bl	c0d00cc8 <find_data_processor>
}

void find_from(cache_holder ch){
    ch.flag = "from";
    int pre_str_size = 4;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01358:	6030      	str	r0, [r6, #0]
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d0135a:	6830      	ldr	r0, [r6, #0]
c0d0135c:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d0135e:	6821      	ldr	r1, [r4, #0]
c0d01360:	1c4a      	adds	r2, r1, #1
c0d01362:	6022      	str	r2, [r4, #0]
c0d01364:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d01366:	5478      	strb	r0, [r7, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d01368:	6820      	ldr	r0, [r4, #0]
c0d0136a:	1838      	adds	r0, r7, r0
c0d0136c:	6832      	ldr	r2, [r6, #0]
c0d0136e:	9508      	str	r5, [sp, #32]
c0d01370:	4629      	mov	r1, r5
c0d01372:	f001 fd1b 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d01376:	6830      	ldr	r0, [r6, #0]
c0d01378:	6821      	ldr	r1, [r4, #0]
c0d0137a:	1808      	adds	r0, r1, r0
c0d0137c:	6020      	str	r0, [r4, #0]

#ifdef UI_SHOW_FROM
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d0137e:	6830      	ldr	r0, [r6, #0]
c0d01380:	2801      	cmp	r0, #1
c0d01382:	db22      	blt.n	c0d013ca <find_from+0x9a>
c0d01384:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d01386:	6828      	ldr	r0, [r5, #0]
c0d01388:	6831      	ldr	r1, [r6, #0]
c0d0138a:	1840      	adds	r0, r0, r1
c0d0138c:	1d40      	adds	r0, r0, #5
c0d0138e:	287e      	cmp	r0, #126	; 0x7e
c0d01390:	dc1b      	bgt.n	c0d013ca <find_from+0x9a>
c0d01392:	9811      	ldr	r0, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"from=", pre_str_size + 1);
c0d01394:	9006      	str	r0, [sp, #24]
c0d01396:	6800      	ldr	r0, [r0, #0]
c0d01398:	6829      	ldr	r1, [r5, #0]
c0d0139a:	1840      	adds	r0, r0, r1
c0d0139c:	a10c      	add	r1, pc, #48	; (adr r1, c0d013d0 <find_from+0xa0>)
c0d0139e:	2205      	movs	r2, #5
c0d013a0:	f001 fd04 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d013a4:	6828      	ldr	r0, [r5, #0]
c0d013a6:	1d40      	adds	r0, r0, #5
c0d013a8:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d013aa:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d013ac:	4669      	mov	r1, sp
c0d013ae:	600d      	str	r5, [r1, #0]
c0d013b0:	9a06      	ldr	r2, [sp, #24]
c0d013b2:	604a      	str	r2, [r1, #4]
c0d013b4:	9a07      	ldr	r2, [sp, #28]
c0d013b6:	608a      	str	r2, [r1, #8]
c0d013b8:	310c      	adds	r1, #12
c0d013ba:	c191      	stmia	r1!, {r0, r4, r7}
c0d013bc:	4807      	ldr	r0, [pc, #28]	; (c0d013dc <find_from+0xac>)
c0d013be:	4478      	add	r0, pc
c0d013c0:	4631      	mov	r1, r6
c0d013c2:	9a08      	ldr	r2, [sp, #32]
c0d013c4:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d013c6:	f7ff fcfb 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d013ca:	b00b      	add	sp, #44	; 0x2c
c0d013cc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d013ce:	46c0      	nop			; (mov r8, r8)
c0d013d0:	6d6f7266 	.word	0x6d6f7266
c0d013d4:	0000003d 	.word	0x0000003d
c0d013d8:	00005dd3 	.word	0x00005dd3
c0d013dc:	00005d61 	.word	0x00005d61

c0d013e0 <find_to>:

void find_to(cache_holder ch){
c0d013e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013e2:	b08b      	sub	sp, #44	; 0x2c
c0d013e4:	9309      	str	r3, [sp, #36]	; 0x24
c0d013e6:	4615      	mov	r5, r2
c0d013e8:	460e      	mov	r6, r1
c0d013ea:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d013ec:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "to";
    int pre_str_size = 2;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d013ee:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d013f0:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d013f2:	4669      	mov	r1, sp
c0d013f4:	6088      	str	r0, [r1, #8]
c0d013f6:	2002      	movs	r0, #2
c0d013f8:	6008      	str	r0, [r1, #0]
c0d013fa:	4922      	ldr	r1, [pc, #136]	; (c0d01484 <find_to+0xa4>)
c0d013fc:	4479      	add	r1, pc
c0d013fe:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d01400:	4628      	mov	r0, r5
c0d01402:	9207      	str	r2, [sp, #28]
c0d01404:	f7ff fc60 	bl	c0d00cc8 <find_data_processor>
}

void find_to(cache_holder ch){
    ch.flag = "to";
    int pre_str_size = 2;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01408:	6030      	str	r0, [r6, #0]
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d0140a:	6830      	ldr	r0, [r6, #0]
c0d0140c:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d0140e:	6821      	ldr	r1, [r4, #0]
c0d01410:	1c4a      	adds	r2, r1, #1
c0d01412:	6022      	str	r2, [r4, #0]
c0d01414:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d01416:	5478      	strb	r0, [r7, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d01418:	6820      	ldr	r0, [r4, #0]
c0d0141a:	1838      	adds	r0, r7, r0
c0d0141c:	6832      	ldr	r2, [r6, #0]
c0d0141e:	9508      	str	r5, [sp, #32]
c0d01420:	4629      	mov	r1, r5
c0d01422:	f001 fcc3 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d01426:	6830      	ldr	r0, [r6, #0]
c0d01428:	6821      	ldr	r1, [r4, #0]
c0d0142a:	1808      	adds	r0, r1, r0
c0d0142c:	6020      	str	r0, [r4, #0]

#ifdef UI_SHOW_TO
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d0142e:	6830      	ldr	r0, [r6, #0]
c0d01430:	2801      	cmp	r0, #1
c0d01432:	db22      	blt.n	c0d0147a <find_to+0x9a>
c0d01434:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d01436:	6828      	ldr	r0, [r5, #0]
c0d01438:	6831      	ldr	r1, [r6, #0]
c0d0143a:	1840      	adds	r0, r0, r1
c0d0143c:	1cc0      	adds	r0, r0, #3
c0d0143e:	287e      	cmp	r0, #126	; 0x7e
c0d01440:	dc1b      	bgt.n	c0d0147a <find_to+0x9a>
c0d01442:	9811      	ldr	r0, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"to=", pre_str_size + 1);
c0d01444:	9006      	str	r0, [sp, #24]
c0d01446:	6800      	ldr	r0, [r0, #0]
c0d01448:	6829      	ldr	r1, [r5, #0]
c0d0144a:	1840      	adds	r0, r0, r1
c0d0144c:	a10c      	add	r1, pc, #48	; (adr r1, c0d01480 <find_to+0xa0>)
c0d0144e:	2203      	movs	r2, #3
c0d01450:	f001 fcac 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d01454:	6828      	ldr	r0, [r5, #0]
c0d01456:	1cc0      	adds	r0, r0, #3
c0d01458:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d0145a:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0145c:	4669      	mov	r1, sp
c0d0145e:	600d      	str	r5, [r1, #0]
c0d01460:	9a06      	ldr	r2, [sp, #24]
c0d01462:	604a      	str	r2, [r1, #4]
c0d01464:	9a07      	ldr	r2, [sp, #28]
c0d01466:	608a      	str	r2, [r1, #8]
c0d01468:	310c      	adds	r1, #12
c0d0146a:	c191      	stmia	r1!, {r0, r4, r7}
c0d0146c:	4806      	ldr	r0, [pc, #24]	; (c0d01488 <find_to+0xa8>)
c0d0146e:	4478      	add	r0, pc
c0d01470:	4631      	mov	r1, r6
c0d01472:	9a08      	ldr	r2, [sp, #32]
c0d01474:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01476:	f7ff fca3 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d0147a:	b00b      	add	sp, #44	; 0x2c
c0d0147c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0147e:	46c0      	nop			; (mov r8, r8)
c0d01480:	003d6f74 	.word	0x003d6f74
c0d01484:	00005d28 	.word	0x00005d28
c0d01488:	00005cb6 	.word	0x00005cb6

c0d0148c <find_to_external_address>:

void find_to_external_address(cache_holder ch){
c0d0148c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0148e:	b08b      	sub	sp, #44	; 0x2c
c0d01490:	9309      	str	r3, [sp, #36]	; 0x24
c0d01492:	4615      	mov	r5, r2
c0d01494:	460e      	mov	r6, r1
c0d01496:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d01498:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "to_external_address";
    int pre_str_size = 19;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d0149a:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0149c:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d0149e:	4669      	mov	r1, sp
c0d014a0:	6088      	str	r0, [r1, #8]
c0d014a2:	2013      	movs	r0, #19
c0d014a4:	6008      	str	r0, [r1, #0]
c0d014a6:	4927      	ldr	r1, [pc, #156]	; (c0d01544 <find_to_external_address+0xb8>)
c0d014a8:	4479      	add	r1, pc
c0d014aa:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d014ac:	4628      	mov	r0, r5
c0d014ae:	9207      	str	r2, [sp, #28]
c0d014b0:	f7ff fc0a 	bl	c0d00cc8 <find_data_processor>
}

void find_to_external_address(cache_holder ch){
    ch.flag = "to_external_address";
    int pre_str_size = 19;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d014b4:	6030      	str	r0, [r6, #0]
    
    ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d014b6:	6830      	ldr	r0, [r6, #0]
c0d014b8:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d014ba:	6821      	ldr	r1, [r4, #0]
c0d014bc:	1c4a      	adds	r2, r1, #1
c0d014be:	6022      	str	r2, [r4, #0]
c0d014c0:	9f15      	ldr	r7, [sp, #84]	; 0x54
c0d014c2:	5478      	strb	r0, [r7, r1]
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d014c4:	6820      	ldr	r0, [r4, #0]
c0d014c6:	1838      	adds	r0, r7, r0
c0d014c8:	6832      	ldr	r2, [r6, #0]
c0d014ca:	9508      	str	r5, [sp, #32]
c0d014cc:	4629      	mov	r1, r5
c0d014ce:	f001 fc6d 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d014d2:	6830      	ldr	r0, [r6, #0]
c0d014d4:	6821      	ldr	r1, [r4, #0]
c0d014d6:	1808      	adds	r0, r1, r0
c0d014d8:	6020      	str	r0, [r4, #0]

#ifdef UI_SHOW_TO_EXTERNAL_ADDRESS
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d014da:	6830      	ldr	r0, [r6, #0]
c0d014dc:	2801      	cmp	r0, #1
c0d014de:	db22      	blt.n	c0d01526 <find_to_external_address+0x9a>
c0d014e0:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d014e2:	6828      	ldr	r0, [r5, #0]
c0d014e4:	6831      	ldr	r1, [r6, #0]
c0d014e6:	1840      	adds	r0, r0, r1
c0d014e8:	3014      	adds	r0, #20
c0d014ea:	287e      	cmp	r0, #126	; 0x7e
c0d014ec:	dc1b      	bgt.n	c0d01526 <find_to_external_address+0x9a>
c0d014ee:	9811      	ldr	r0, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"to_external_address=", pre_str_size + 1);
c0d014f0:	9006      	str	r0, [sp, #24]
c0d014f2:	6800      	ldr	r0, [r0, #0]
c0d014f4:	6829      	ldr	r1, [r5, #0]
c0d014f6:	1840      	adds	r0, r0, r1
c0d014f8:	a10c      	add	r1, pc, #48	; (adr r1, c0d0152c <find_to_external_address+0xa0>)
c0d014fa:	2214      	movs	r2, #20
c0d014fc:	f001 fc56 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d01500:	6828      	ldr	r0, [r5, #0]
c0d01502:	3014      	adds	r0, #20
c0d01504:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d01506:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01508:	4669      	mov	r1, sp
c0d0150a:	600d      	str	r5, [r1, #0]
c0d0150c:	9a06      	ldr	r2, [sp, #24]
c0d0150e:	604a      	str	r2, [r1, #4]
c0d01510:	9a07      	ldr	r2, [sp, #28]
c0d01512:	608a      	str	r2, [r1, #8]
c0d01514:	310c      	adds	r1, #12
c0d01516:	c191      	stmia	r1!, {r0, r4, r7}
c0d01518:	480b      	ldr	r0, [pc, #44]	; (c0d01548 <find_to_external_address+0xbc>)
c0d0151a:	4478      	add	r0, pc
c0d0151c:	4631      	mov	r1, r6
c0d0151e:	9a08      	ldr	r2, [sp, #32]
c0d01520:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d01522:	f7ff fc4d 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d01526:	b00b      	add	sp, #44	; 0x2c
c0d01528:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0152a:	46c0      	nop			; (mov r8, r8)
c0d0152c:	655f6f74 	.word	0x655f6f74
c0d01530:	72657478 	.word	0x72657478
c0d01534:	5f6c616e 	.word	0x5f6c616e
c0d01538:	72646461 	.word	0x72646461
c0d0153c:	3d737365 	.word	0x3d737365
c0d01540:	00000000 	.word	0x00000000
c0d01544:	00005c7f 	.word	0x00005c7f
c0d01548:	00005c0d 	.word	0x00005c0d

c0d0154c <find_message>:

void find_message(cache_holder ch){
c0d0154c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0154e:	b08b      	sub	sp, #44	; 0x2c
c0d01550:	9309      	str	r3, [sp, #36]	; 0x24
c0d01552:	4617      	mov	r7, r2
c0d01554:	460e      	mov	r6, r1
c0d01556:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d01558:	900a      	str	r0, [sp, #40]	; 0x28
    ch.flag = "message";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d0155a:	9b0a      	ldr	r3, [sp, #40]	; 0x28
c0d0155c:	2501      	movs	r5, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d0155e:	4668      	mov	r0, sp
c0d01560:	6085      	str	r5, [r0, #8]
c0d01562:	2107      	movs	r1, #7
c0d01564:	6001      	str	r1, [r0, #0]
c0d01566:	4929      	ldr	r1, [pc, #164]	; (c0d0160c <find_message+0xc0>)
c0d01568:	4479      	add	r1, pc
c0d0156a:	9a12      	ldr	r2, [sp, #72]	; 0x48
c0d0156c:	4638      	mov	r0, r7
c0d0156e:	9207      	str	r2, [sp, #28]
c0d01570:	f7ff fbaa 	bl	c0d00cc8 <find_data_processor>
}

void find_message(cache_holder ch){
    ch.flag = "message";
    int pre_str_size = 7;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01574:	6030      	str	r0, [r6, #0]
    
    if(*(ch.value_length) > 0){
c0d01576:	6831      	ldr	r1, [r6, #0]
c0d01578:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d0157a:	6820      	ldr	r0, [r4, #0]
c0d0157c:	1c42      	adds	r2, r0, #1
c0d0157e:	6022      	str	r2, [r4, #0]
c0d01580:	9b15      	ldr	r3, [sp, #84]	; 0x54
c0d01582:	1818      	adds	r0, r3, r0
c0d01584:	2901      	cmp	r1, #1
c0d01586:	9708      	str	r7, [sp, #32]
c0d01588:	9306      	str	r3, [sp, #24]
c0d0158a:	db10      	blt.n	c0d015ae <find_message+0x62>
        ch.encode[(*(ch.encode_p))++] = 1;
c0d0158c:	7005      	strb	r5, [r0, #0]

        ch.encode[(*(ch.encode_p))++] = (char) *(ch.value_length);
c0d0158e:	6830      	ldr	r0, [r6, #0]
c0d01590:	6821      	ldr	r1, [r4, #0]
c0d01592:	1c4a      	adds	r2, r1, #1
c0d01594:	6022      	str	r2, [r4, #0]
c0d01596:	5458      	strb	r0, [r3, r1]
        os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d01598:	6820      	ldr	r0, [r4, #0]
c0d0159a:	1818      	adds	r0, r3, r0
c0d0159c:	6832      	ldr	r2, [r6, #0]
c0d0159e:	4639      	mov	r1, r7
c0d015a0:	f001 fc04 	bl	c0d02dac <os_memmove>
        *(ch.encode_p) += *(ch.value_length);
c0d015a4:	6830      	ldr	r0, [r6, #0]
c0d015a6:	6821      	ldr	r1, [r4, #0]
c0d015a8:	1808      	adds	r0, r1, r0
c0d015aa:	6020      	str	r0, [r4, #0]
c0d015ac:	e001      	b.n	c0d015b2 <find_message+0x66>
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
c0d015ae:	2100      	movs	r1, #0
c0d015b0:	7001      	strb	r1, [r0, #0]
    }

#ifdef UI_SHOW_MESSAGE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d015b2:	6830      	ldr	r0, [r6, #0]
c0d015b4:	2801      	cmp	r0, #1
c0d015b6:	db21      	blt.n	c0d015fc <find_message+0xb0>
c0d015b8:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d015ba:	6828      	ldr	r0, [r5, #0]
c0d015bc:	6831      	ldr	r1, [r6, #0]
c0d015be:	1840      	adds	r0, r0, r1
c0d015c0:	3008      	adds	r0, #8
c0d015c2:	287e      	cmp	r0, #126	; 0x7e
c0d015c4:	dc1a      	bgt.n	c0d015fc <find_message+0xb0>
c0d015c6:	9f11      	ldr	r7, [sp, #68]	; 0x44
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"message=", pre_str_size + 1);
c0d015c8:	6838      	ldr	r0, [r7, #0]
c0d015ca:	6829      	ldr	r1, [r5, #0]
c0d015cc:	1840      	adds	r0, r0, r1
c0d015ce:	a10c      	add	r1, pc, #48	; (adr r1, c0d01600 <find_message+0xb4>)
c0d015d0:	2208      	movs	r2, #8
c0d015d2:	f001 fbeb 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d015d6:	6828      	ldr	r0, [r5, #0]
c0d015d8:	3008      	adds	r0, #8
c0d015da:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d015dc:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d015de:	4669      	mov	r1, sp
c0d015e0:	c1a0      	stmia	r1!, {r5, r7}
c0d015e2:	9a07      	ldr	r2, [sp, #28]
c0d015e4:	600a      	str	r2, [r1, #0]
c0d015e6:	6048      	str	r0, [r1, #4]
c0d015e8:	608c      	str	r4, [r1, #8]
c0d015ea:	9806      	ldr	r0, [sp, #24]
c0d015ec:	60c8      	str	r0, [r1, #12]
c0d015ee:	4808      	ldr	r0, [pc, #32]	; (c0d01610 <find_message+0xc4>)
c0d015f0:	4478      	add	r0, pc
c0d015f2:	4631      	mov	r1, r6
c0d015f4:	9a08      	ldr	r2, [sp, #32]
c0d015f6:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d015f8:	f7ff fbe2 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d015fc:	b00b      	add	sp, #44	; 0x2c
c0d015fe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01600:	7373656d 	.word	0x7373656d
c0d01604:	3d656761 	.word	0x3d656761
c0d01608:	00000000 	.word	0x00000000
c0d0160c:	00005bd3 	.word	0x00005bd3
c0d01610:	00005b4b 	.word	0x00005b4b

c0d01614 <find_amount>:

void find_amount(cache_holder ch, bool *go_next){
c0d01614:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01616:	b091      	sub	sp, #68	; 0x44
c0d01618:	930f      	str	r3, [sp, #60]	; 0x3c
c0d0161a:	920e      	str	r2, [sp, #56]	; 0x38
c0d0161c:	460c      	mov	r4, r1
c0d0161e:	940c      	str	r4, [sp, #48]	; 0x30
c0d01620:	9819      	ldr	r0, [sp, #100]	; 0x64
c0d01622:	9010      	str	r0, [sp, #64]	; 0x40
    ch.flag = "amount";
    int pre_str_size = 6;
    (*(ch.value_length)) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01624:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d01626:	2101      	movs	r1, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01628:	4668      	mov	r0, sp
c0d0162a:	910d      	str	r1, [sp, #52]	; 0x34
c0d0162c:	6081      	str	r1, [r0, #8]
c0d0162e:	2106      	movs	r1, #6
c0d01630:	6001      	str	r1, [r0, #0]
c0d01632:	4f33      	ldr	r7, [pc, #204]	; (c0d01700 <find_amount+0xec>)
c0d01634:	447f      	add	r7, pc
c0d01636:	9e18      	ldr	r6, [sp, #96]	; 0x60
c0d01638:	4610      	mov	r0, r2
c0d0163a:	4639      	mov	r1, r7
c0d0163c:	4632      	mov	r2, r6
c0d0163e:	f7ff fb43 	bl	c0d00cc8 <find_data_processor>
}

void find_amount(cache_holder ch, bool *go_next){
    ch.flag = "amount";
    int pre_str_size = 6;
    (*(ch.value_length)) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01642:	6020      	str	r0, [r4, #0]
    
    uint128_t *amount = &uint128_t_cache1;
    clear128(amount);
c0d01644:	4d2b      	ldr	r5, [pc, #172]	; (c0d016f4 <find_amount+0xe0>)
c0d01646:	4628      	mov	r0, r5
c0d01648:	f004 f8f8 	bl	c0d0583c <clear128>
c0d0164c:	2000      	movs	r0, #0
    UPPER_P(amount) = 0;
    LOWER_P(amount) = 0;
c0d0164e:	6028      	str	r0, [r5, #0]
c0d01650:	6068      	str	r0, [r5, #4]
c0d01652:	60a8      	str	r0, [r5, #8]
c0d01654:	60e8      	str	r0, [r5, #12]
    get_uint_128(amount, ch);
c0d01656:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d01658:	9a1b      	ldr	r2, [sp, #108]	; 0x6c
c0d0165a:	4669      	mov	r1, sp
c0d0165c:	618a      	str	r2, [r1, #24]
c0d0165e:	9c1a      	ldr	r4, [sp, #104]	; 0x68
c0d01660:	614c      	str	r4, [r1, #20]
c0d01662:	6108      	str	r0, [r1, #16]
c0d01664:	9608      	str	r6, [sp, #32]
c0d01666:	60ce      	str	r6, [r1, #12]
c0d01668:	9817      	ldr	r0, [sp, #92]	; 0x5c
c0d0166a:	900a      	str	r0, [sp, #40]	; 0x28
c0d0166c:	6088      	str	r0, [r1, #8]
c0d0166e:	9816      	ldr	r0, [sp, #88]	; 0x58
c0d01670:	900b      	str	r0, [sp, #44]	; 0x2c
c0d01672:	6048      	str	r0, [r1, #4]
c0d01674:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01676:	6008      	str	r0, [r1, #0]
c0d01678:	4628      	mov	r0, r5
c0d0167a:	9709      	str	r7, [sp, #36]	; 0x24
c0d0167c:	4639      	mov	r1, r7
c0d0167e:	4617      	mov	r7, r2
c0d01680:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d01682:	4632      	mov	r2, r6
c0d01684:	9b0e      	ldr	r3, [sp, #56]	; 0x38
c0d01686:	f7ff fbb3 	bl	c0d00df0 <get_uint_128>

    int p = get_uint_128_bytes(amount, &(ch.encode[(*(ch.encode_p))]));
c0d0168a:	6820      	ldr	r0, [r4, #0]
c0d0168c:	1839      	adds	r1, r7, r0
c0d0168e:	4628      	mov	r0, r5
c0d01690:	f001 fb36 	bl	c0d02d00 <get_uint_128_bytes>
    (*(ch.encode_p)) += p;
c0d01694:	6821      	ldr	r1, [r4, #0]
c0d01696:	1808      	adds	r0, r1, r0
c0d01698:	6020      	str	r0, [r4, #0]


#ifdef UI_SHOW_AMOUNT
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d0169a:	6830      	ldr	r0, [r6, #0]
c0d0169c:	9a1c      	ldr	r2, [sp, #112]	; 0x70
c0d0169e:	2801      	cmp	r0, #1
c0d016a0:	db23      	blt.n	c0d016ea <find_amount+0xd6>
c0d016a2:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d016a4:	6800      	ldr	r0, [r0, #0]
c0d016a6:	6831      	ldr	r1, [r6, #0]
c0d016a8:	1840      	adds	r0, r0, r1
c0d016aa:	1dc0      	adds	r0, r0, #7
c0d016ac:	287e      	cmp	r0, #126	; 0x7e
c0d016ae:	dc1c      	bgt.n	c0d016ea <find_amount+0xd6>
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"amount=", pre_str_size + 1);
c0d016b0:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d016b2:	6800      	ldr	r0, [r0, #0]
c0d016b4:	9d0b      	ldr	r5, [sp, #44]	; 0x2c
c0d016b6:	6829      	ldr	r1, [r5, #0]
c0d016b8:	1840      	adds	r0, r0, r1
c0d016ba:	a10f      	add	r1, pc, #60	; (adr r1, c0d016f8 <find_amount+0xe4>)
c0d016bc:	9207      	str	r2, [sp, #28]
c0d016be:	2207      	movs	r2, #7
c0d016c0:	f001 fb74 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d016c4:	6828      	ldr	r0, [r5, #0]
c0d016c6:	1dc0      	adds	r0, r0, #7
c0d016c8:	6028      	str	r0, [r5, #0]
        read_message(ch);
c0d016ca:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d016cc:	4669      	mov	r1, sp
c0d016ce:	600d      	str	r5, [r1, #0]
c0d016d0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d016d2:	604a      	str	r2, [r1, #4]
c0d016d4:	9a08      	ldr	r2, [sp, #32]
c0d016d6:	608a      	str	r2, [r1, #8]
c0d016d8:	310c      	adds	r1, #12
c0d016da:	c191      	stmia	r1!, {r0, r4, r7}
c0d016dc:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d016de:	4631      	mov	r1, r6
c0d016e0:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d016e2:	9b0f      	ldr	r3, [sp, #60]	; 0x3c
c0d016e4:	f7ff fb6c 	bl	c0d00dc0 <read_message>
c0d016e8:	9a07      	ldr	r2, [sp, #28]
    }
#endif 

    // while(p < 16){};

    (*go_next) = true;
c0d016ea:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d016ec:	7010      	strb	r0, [r2, #0]
}
c0d016ee:	b011      	add	sp, #68	; 0x44
c0d016f0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d016f2:	46c0      	nop			; (mov r8, r8)
c0d016f4:	20001f70 	.word	0x20001f70
c0d016f8:	756f6d61 	.word	0x756f6d61
c0d016fc:	003d746e 	.word	0x003d746e
c0d01700:	00005b0f 	.word	0x00005b0f

c0d01704 <find_price>:

void find_price(cache_holder ch){
c0d01704:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01706:	b091      	sub	sp, #68	; 0x44
c0d01708:	930f      	str	r3, [sp, #60]	; 0x3c
c0d0170a:	920e      	str	r2, [sp, #56]	; 0x38
c0d0170c:	460c      	mov	r4, r1
c0d0170e:	940d      	str	r4, [sp, #52]	; 0x34
c0d01710:	9819      	ldr	r0, [sp, #100]	; 0x64
c0d01712:	9010      	str	r0, [sp, #64]	; 0x40
    ch.flag = "price";
    int pre_str_size = 5;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01714:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d01716:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01718:	4669      	mov	r1, sp
c0d0171a:	6088      	str	r0, [r1, #8]
c0d0171c:	2005      	movs	r0, #5
c0d0171e:	6008      	str	r0, [r1, #0]
c0d01720:	4f31      	ldr	r7, [pc, #196]	; (c0d017e8 <find_price+0xe4>)
c0d01722:	447f      	add	r7, pc
c0d01724:	9e18      	ldr	r6, [sp, #96]	; 0x60
c0d01726:	4610      	mov	r0, r2
c0d01728:	4639      	mov	r1, r7
c0d0172a:	4632      	mov	r2, r6
c0d0172c:	f7ff facc 	bl	c0d00cc8 <find_data_processor>
}

void find_price(cache_holder ch){
    ch.flag = "price";
    int pre_str_size = 5;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01730:	6020      	str	r0, [r4, #0]
    
    uint128_t *price = &uint128_t_cache1;
    clear128(price);
c0d01732:	4d2a      	ldr	r5, [pc, #168]	; (c0d017dc <find_price+0xd8>)
c0d01734:	4628      	mov	r0, r5
c0d01736:	f004 f881 	bl	c0d0583c <clear128>
c0d0173a:	2000      	movs	r0, #0
    UPPER_P(price) = 0;
    LOWER_P(price) = 0;
c0d0173c:	6028      	str	r0, [r5, #0]
c0d0173e:	6068      	str	r0, [r5, #4]
c0d01740:	60a8      	str	r0, [r5, #8]
c0d01742:	60e8      	str	r0, [r5, #12]
    get_uint_128(price, ch);
c0d01744:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d01746:	9a1b      	ldr	r2, [sp, #108]	; 0x6c
c0d01748:	4669      	mov	r1, sp
c0d0174a:	618a      	str	r2, [r1, #24]
c0d0174c:	9c1a      	ldr	r4, [sp, #104]	; 0x68
c0d0174e:	614c      	str	r4, [r1, #20]
c0d01750:	6108      	str	r0, [r1, #16]
c0d01752:	960a      	str	r6, [sp, #40]	; 0x28
c0d01754:	60ce      	str	r6, [r1, #12]
c0d01756:	4616      	mov	r6, r2
c0d01758:	9817      	ldr	r0, [sp, #92]	; 0x5c
c0d0175a:	9009      	str	r0, [sp, #36]	; 0x24
c0d0175c:	6088      	str	r0, [r1, #8]
c0d0175e:	9816      	ldr	r0, [sp, #88]	; 0x58
c0d01760:	900c      	str	r0, [sp, #48]	; 0x30
c0d01762:	6048      	str	r0, [r1, #4]
c0d01764:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d01766:	6008      	str	r0, [r1, #0]
c0d01768:	4628      	mov	r0, r5
c0d0176a:	970b      	str	r7, [sp, #44]	; 0x2c
c0d0176c:	4639      	mov	r1, r7
c0d0176e:	9f0d      	ldr	r7, [sp, #52]	; 0x34
c0d01770:	463a      	mov	r2, r7
c0d01772:	9b0e      	ldr	r3, [sp, #56]	; 0x38
c0d01774:	f7ff fb3c 	bl	c0d00df0 <get_uint_128>

    int p = get_uint_128_bytes(price, &(ch.encode[(*(ch.encode_p))]));
c0d01778:	6820      	ldr	r0, [r4, #0]
c0d0177a:	9608      	str	r6, [sp, #32]
c0d0177c:	1831      	adds	r1, r6, r0
c0d0177e:	4628      	mov	r0, r5
c0d01780:	463d      	mov	r5, r7
c0d01782:	f001 fabd 	bl	c0d02d00 <get_uint_128_bytes>
    (*(ch.encode_p)) += p;
c0d01786:	6821      	ldr	r1, [r4, #0]
c0d01788:	1808      	adds	r0, r1, r0
c0d0178a:	6020      	str	r0, [r4, #0]

#ifdef UI_SHOW_PRICE
    if(*(ch.value_length) > 0 && ((*(ch.data_p) + pre_str_size + 1 + (*(ch.value_length))) < MAX_CHARS_SHOW_LINE - 1)){
c0d0178c:	6828      	ldr	r0, [r5, #0]
c0d0178e:	2801      	cmp	r0, #1
c0d01790:	db21      	blt.n	c0d017d6 <find_price+0xd2>
c0d01792:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01794:	6800      	ldr	r0, [r0, #0]
c0d01796:	6829      	ldr	r1, [r5, #0]
c0d01798:	1840      	adds	r0, r0, r1
c0d0179a:	1d80      	adds	r0, r0, #6
c0d0179c:	287e      	cmp	r0, #126	; 0x7e
c0d0179e:	dc1a      	bgt.n	c0d017d6 <find_price+0xd2>
c0d017a0:	9f09      	ldr	r7, [sp, #36]	; 0x24
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"price=", pre_str_size + 1);
c0d017a2:	6838      	ldr	r0, [r7, #0]
c0d017a4:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d017a6:	6831      	ldr	r1, [r6, #0]
c0d017a8:	1840      	adds	r0, r0, r1
c0d017aa:	a10d      	add	r1, pc, #52	; (adr r1, c0d017e0 <find_price+0xdc>)
c0d017ac:	2206      	movs	r2, #6
c0d017ae:	f001 fafd 	bl	c0d02dac <os_memmove>
        *(ch.data_p) += (pre_str_size + 1);
c0d017b2:	6830      	ldr	r0, [r6, #0]
c0d017b4:	1d80      	adds	r0, r0, #6
c0d017b6:	6030      	str	r0, [r6, #0]
        read_message(ch);
c0d017b8:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d017ba:	4669      	mov	r1, sp
c0d017bc:	c1c0      	stmia	r1!, {r6, r7}
c0d017be:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d017c0:	600a      	str	r2, [r1, #0]
c0d017c2:	6048      	str	r0, [r1, #4]
c0d017c4:	608c      	str	r4, [r1, #8]
c0d017c6:	9808      	ldr	r0, [sp, #32]
c0d017c8:	60c8      	str	r0, [r1, #12]
c0d017ca:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d017cc:	4629      	mov	r1, r5
c0d017ce:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d017d0:	9b0f      	ldr	r3, [sp, #60]	; 0x3c
c0d017d2:	f7ff faf5 	bl	c0d00dc0 <read_message>
    }
#endif 
}
c0d017d6:	b011      	add	sp, #68	; 0x44
c0d017d8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d017da:	46c0      	nop			; (mov r8, r8)
c0d017dc:	20001f70 	.word	0x20001f70
c0d017e0:	63697270 	.word	0x63697270
c0d017e4:	00003d65 	.word	0x00003d65
c0d017e8:	00005a28 	.word	0x00005a28

c0d017ec <find_use_btt_as_fee>:

void find_use_btt_as_fee(cache_holder ch){
c0d017ec:	b570      	push	{r4, r5, r6, lr}
c0d017ee:	b084      	sub	sp, #16
c0d017f0:	4614      	mov	r4, r2
c0d017f2:	460d      	mov	r5, r1
c0d017f4:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d017f6:	9003      	str	r0, [sp, #12]
    ch.flag = "use_btt_as_fee";
    int pre_str_size = 14;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d017f8:	9b03      	ldr	r3, [sp, #12]
c0d017fa:	2601      	movs	r6, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d017fc:	4668      	mov	r0, sp
c0d017fe:	6086      	str	r6, [r0, #8]
c0d01800:	210e      	movs	r1, #14
c0d01802:	6001      	str	r1, [r0, #0]
c0d01804:	a10b      	add	r1, pc, #44	; (adr r1, c0d01834 <find_use_btt_as_fee+0x48>)
c0d01806:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01808:	4620      	mov	r0, r4
c0d0180a:	f7ff fa5d 	bl	c0d00cc8 <find_data_processor>
}

void find_use_btt_as_fee(cache_holder ch){
    ch.flag = "use_btt_as_fee";
    int pre_str_size = 14;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d0180e:	6028      	str	r0, [r5, #0]
    
    if(strncmp((unsigned char *)(ch.cache), (unsigned char *)"true", *(ch.value_length)) == 0){
c0d01810:	682a      	ldr	r2, [r5, #0]
c0d01812:	a10c      	add	r1, pc, #48	; (adr r1, c0d01844 <find_use_btt_as_fee+0x58>)
c0d01814:	4620      	mov	r0, r4
c0d01816:	f005 fbf7 	bl	c0d07008 <strncmp>
c0d0181a:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d0181c:	6811      	ldr	r1, [r2, #0]
c0d0181e:	1c4b      	adds	r3, r1, #1
c0d01820:	6013      	str	r3, [r2, #0]
c0d01822:	2200      	movs	r2, #0
c0d01824:	2800      	cmp	r0, #0
c0d01826:	d000      	beq.n	c0d0182a <find_use_btt_as_fee+0x3e>
c0d01828:	4616      	mov	r6, r2
c0d0182a:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0182c:	5446      	strb	r6, [r0, r1]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"use_btt_as_fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d0182e:	b004      	add	sp, #16
c0d01830:	bd70      	pop	{r4, r5, r6, pc}
c0d01832:	46c0      	nop			; (mov r8, r8)
c0d01834:	5f657375 	.word	0x5f657375
c0d01838:	5f747462 	.word	0x5f747462
c0d0183c:	665f7361 	.word	0x665f7361
c0d01840:	00006565 	.word	0x00006565
c0d01844:	65757274 	.word	0x65757274
c0d01848:	00000000 	.word	0x00000000

c0d0184c <find_freeze_btt_fee>:

void find_freeze_btt_fee(cache_holder ch){
c0d0184c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0184e:	b08d      	sub	sp, #52	; 0x34
c0d01850:	930a      	str	r3, [sp, #40]	; 0x28
c0d01852:	460d      	mov	r5, r1
c0d01854:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d01856:	900c      	str	r0, [sp, #48]	; 0x30
    ch.flag = "freeze_btt_fee";
    int pre_str_size = 14;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01858:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0185a:	2601      	movs	r6, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d0185c:	4668      	mov	r0, sp
c0d0185e:	6086      	str	r6, [r0, #8]
c0d01860:	210e      	movs	r1, #14
c0d01862:	6001      	str	r1, [r0, #0]
c0d01864:	4921      	ldr	r1, [pc, #132]	; (c0d018ec <find_freeze_btt_fee+0xa0>)
c0d01866:	4479      	add	r1, pc
c0d01868:	9c14      	ldr	r4, [sp, #80]	; 0x50
c0d0186a:	920b      	str	r2, [sp, #44]	; 0x2c
c0d0186c:	4610      	mov	r0, r2
c0d0186e:	9409      	str	r4, [sp, #36]	; 0x24
c0d01870:	4622      	mov	r2, r4
c0d01872:	f7ff fa29 	bl	c0d00cc8 <find_data_processor>
}

void find_freeze_btt_fee(cache_holder ch){
    ch.flag = "freeze_btt_fee";
    int pre_str_size = 14;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01876:	6028      	str	r0, [r5, #0]
    
    if(*(ch.value_length) > 0){
c0d01878:	6829      	ldr	r1, [r5, #0]
c0d0187a:	9c16      	ldr	r4, [sp, #88]	; 0x58
c0d0187c:	6820      	ldr	r0, [r4, #0]
c0d0187e:	1c42      	adds	r2, r0, #1
c0d01880:	6022      	str	r2, [r4, #0]
c0d01882:	9f17      	ldr	r7, [sp, #92]	; 0x5c
c0d01884:	1838      	adds	r0, r7, r0
c0d01886:	2901      	cmp	r1, #1
c0d01888:	db29      	blt.n	c0d018de <find_freeze_btt_fee+0x92>
c0d0188a:	9913      	ldr	r1, [sp, #76]	; 0x4c
c0d0188c:	9108      	str	r1, [sp, #32]
c0d0188e:	9912      	ldr	r1, [sp, #72]	; 0x48

        ch.encode[(*(ch.encode_p))++] = 1;
c0d01890:	9107      	str	r1, [sp, #28]
c0d01892:	7006      	strb	r6, [r0, #0]

        uint128_t *freeze_btt_fee = &uint128_t_cache1;
        clear128(freeze_btt_fee);
c0d01894:	4e14      	ldr	r6, [pc, #80]	; (c0d018e8 <find_freeze_btt_fee+0x9c>)
c0d01896:	4630      	mov	r0, r6
c0d01898:	f003 ffd0 	bl	c0d0583c <clear128>
c0d0189c:	2000      	movs	r0, #0
        UPPER_P(freeze_btt_fee) = 0;
        LOWER_P(freeze_btt_fee) = 0;
c0d0189e:	6030      	str	r0, [r6, #0]
c0d018a0:	6070      	str	r0, [r6, #4]
c0d018a2:	60b0      	str	r0, [r6, #8]
c0d018a4:	60f0      	str	r0, [r6, #12]
        get_uint_128(freeze_btt_fee, ch);
c0d018a6:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d018a8:	4669      	mov	r1, sp
c0d018aa:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d018ac:	600a      	str	r2, [r1, #0]
c0d018ae:	9a07      	ldr	r2, [sp, #28]
c0d018b0:	604a      	str	r2, [r1, #4]
c0d018b2:	9a08      	ldr	r2, [sp, #32]
c0d018b4:	608a      	str	r2, [r1, #8]
c0d018b6:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d018b8:	60ca      	str	r2, [r1, #12]
c0d018ba:	3110      	adds	r1, #16
c0d018bc:	c191      	stmia	r1!, {r0, r4, r7}
c0d018be:	490c      	ldr	r1, [pc, #48]	; (c0d018f0 <find_freeze_btt_fee+0xa4>)
c0d018c0:	4479      	add	r1, pc
c0d018c2:	4630      	mov	r0, r6
c0d018c4:	462a      	mov	r2, r5
c0d018c6:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d018c8:	f7ff fa92 	bl	c0d00df0 <get_uint_128>

        int p = get_uint_128_bytes(freeze_btt_fee, &(ch.encode[(*(ch.encode_p))]));
c0d018cc:	6820      	ldr	r0, [r4, #0]
c0d018ce:	1839      	adds	r1, r7, r0
c0d018d0:	4630      	mov	r0, r6
c0d018d2:	f001 fa15 	bl	c0d02d00 <get_uint_128_bytes>
        (*(ch.encode_p)) += p;
c0d018d6:	6821      	ldr	r1, [r4, #0]
c0d018d8:	1808      	adds	r0, r1, r0
c0d018da:	6020      	str	r0, [r4, #0]
c0d018dc:	e001      	b.n	c0d018e2 <find_freeze_btt_fee+0x96>
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
c0d018de:	2100      	movs	r1, #0
c0d018e0:	7001      	strb	r1, [r0, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"freeze_btt_fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d018e2:	b00d      	add	sp, #52	; 0x34
c0d018e4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d018e6:	46c0      	nop			; (mov r8, r8)
c0d018e8:	20001f70 	.word	0x20001f70
c0d018ec:	000058ea 	.word	0x000058ea
c0d018f0:	00005890 	.word	0x00005890

c0d018f4 <find_now>:

void find_now(cache_holder ch){
c0d018f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d018f6:	b085      	sub	sp, #20
c0d018f8:	4614      	mov	r4, r2
c0d018fa:	460d      	mov	r5, r1
c0d018fc:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d018fe:	9004      	str	r0, [sp, #16]
    ch.flag = "now";
    int pre_str_size = 3;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01900:	9b04      	ldr	r3, [sp, #16]
c0d01902:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01904:	4669      	mov	r1, sp
c0d01906:	6088      	str	r0, [r1, #8]
c0d01908:	2003      	movs	r0, #3
c0d0190a:	6008      	str	r0, [r1, #0]
c0d0190c:	a10f      	add	r1, pc, #60	; (adr r1, c0d0194c <find_now+0x58>)
c0d0190e:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01910:	4620      	mov	r0, r4
c0d01912:	f7ff f9d9 	bl	c0d00cc8 <find_data_processor>
}

void find_now(cache_holder ch){
    ch.flag = "now";
    int pre_str_size = 3;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01916:	6028      	str	r0, [r5, #0]
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01918:	682a      	ldr	r2, [r5, #0]
c0d0191a:	2000      	movs	r0, #0
c0d0191c:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d0191e:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d01920:	2a01      	cmp	r2, #1
c0d01922:	db0a      	blt.n	c0d0193a <find_now+0x46>
c0d01924:	2200      	movs	r2, #0
c0d01926:	4610      	mov	r0, r2
        timestamp = (timestamp * 10);
        timestamp += (ch.cache[i] - 48);
c0d01928:	5ca3      	ldrb	r3, [r4, r2]
    int pre_str_size = 3;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        timestamp = (timestamp * 10);
c0d0192a:	270a      	movs	r7, #10
c0d0192c:	4347      	muls	r7, r0
        timestamp += (ch.cache[i] - 48);
c0d0192e:	18f8      	adds	r0, r7, r3
c0d01930:	3830      	subs	r0, #48	; 0x30
    ch.flag = "now";
    int pre_str_size = 3;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01932:	1c52      	adds	r2, r2, #1
c0d01934:	682b      	ldr	r3, [r5, #0]
c0d01936:	429a      	cmp	r2, r3
c0d01938:	dbf6      	blt.n	c0d01928 <find_now+0x34>
        timestamp = (timestamp * 10);
        timestamp += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(timestamp, &(ch.encode[(*(ch.encode_p))]));
c0d0193a:	6832      	ldr	r2, [r6, #0]
c0d0193c:	1889      	adds	r1, r1, r2
c0d0193e:	f001 f9d6 	bl	c0d02cee <uint32_to_bytes_net>
c0d01942:	6831      	ldr	r1, [r6, #0]
c0d01944:	1808      	adds	r0, r1, r0
c0d01946:	6030      	str	r0, [r6, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"now=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01948:	b005      	add	sp, #20
c0d0194a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0194c:	00776f6e 	.word	0x00776f6e

c0d01950 <find_expiration>:

void find_expiration(cache_holder ch){
c0d01950:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01952:	b085      	sub	sp, #20
c0d01954:	4614      	mov	r4, r2
c0d01956:	460d      	mov	r5, r1
c0d01958:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0195a:	9004      	str	r0, [sp, #16]
    ch.flag = "expiration";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d0195c:	9b04      	ldr	r3, [sp, #16]
c0d0195e:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01960:	4669      	mov	r1, sp
c0d01962:	6088      	str	r0, [r1, #8]
c0d01964:	260a      	movs	r6, #10
c0d01966:	600e      	str	r6, [r1, #0]
c0d01968:	a10f      	add	r1, pc, #60	; (adr r1, c0d019a8 <find_expiration+0x58>)
c0d0196a:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d0196c:	4620      	mov	r0, r4
c0d0196e:	f7ff f9ab 	bl	c0d00cc8 <find_data_processor>
}

void find_expiration(cache_holder ch){
    ch.flag = "expiration";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01972:	6028      	str	r0, [r5, #0]
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01974:	682a      	ldr	r2, [r5, #0]
c0d01976:	2000      	movs	r0, #0
c0d01978:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d0197a:	9f0e      	ldr	r7, [sp, #56]	; 0x38
c0d0197c:	2a01      	cmp	r2, #1
c0d0197e:	db09      	blt.n	c0d01994 <find_expiration+0x44>
c0d01980:	2200      	movs	r2, #0
c0d01982:	4610      	mov	r0, r2
        timestamp = (timestamp * 10);
        timestamp += (ch.cache[i] - 48);
c0d01984:	5ca3      	ldrb	r3, [r4, r2]
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        timestamp = (timestamp * 10);
c0d01986:	4370      	muls	r0, r6
        timestamp += (ch.cache[i] - 48);
c0d01988:	18c0      	adds	r0, r0, r3
c0d0198a:	3830      	subs	r0, #48	; 0x30
    ch.flag = "expiration";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t timestamp = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d0198c:	1c52      	adds	r2, r2, #1
c0d0198e:	682b      	ldr	r3, [r5, #0]
c0d01990:	429a      	cmp	r2, r3
c0d01992:	dbf7      	blt.n	c0d01984 <find_expiration+0x34>
        timestamp = (timestamp * 10);
        timestamp += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(timestamp, &(ch.encode[(*(ch.encode_p))]));
c0d01994:	683a      	ldr	r2, [r7, #0]
c0d01996:	1889      	adds	r1, r1, r2
c0d01998:	f001 f9a9 	bl	c0d02cee <uint32_to_bytes_net>
c0d0199c:	6839      	ldr	r1, [r7, #0]
c0d0199e:	1808      	adds	r0, r1, r0
c0d019a0:	6038      	str	r0, [r7, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"expiration=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d019a2:	b005      	add	sp, #20
c0d019a4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d019a6:	46c0      	nop			; (mov r8, r8)
c0d019a8:	69707865 	.word	0x69707865
c0d019ac:	69746172 	.word	0x69746172
c0d019b0:	00006e6f 	.word	0x00006e6f

c0d019b4 <find_custom_btt_fee_rate>:

void find_custom_btt_fee_rate(cache_holder ch){
c0d019b4:	b570      	push	{r4, r5, r6, lr}
c0d019b6:	b084      	sub	sp, #16
c0d019b8:	4614      	mov	r4, r2
c0d019ba:	460d      	mov	r5, r1
c0d019bc:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d019be:	9003      	str	r0, [sp, #12]
    ch.flag = "custom_btt_fee_rate";
    int pre_str_size = 19;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d019c0:	9b03      	ldr	r3, [sp, #12]
c0d019c2:	2601      	movs	r6, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d019c4:	4668      	mov	r0, sp
c0d019c6:	6086      	str	r6, [r0, #8]
c0d019c8:	2113      	movs	r1, #19
c0d019ca:	6001      	str	r1, [r0, #0]
c0d019cc:	a115      	add	r1, pc, #84	; (adr r1, c0d01a24 <find_custom_btt_fee_rate+0x70>)
c0d019ce:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d019d0:	4620      	mov	r0, r4
c0d019d2:	f7ff f979 	bl	c0d00cc8 <find_data_processor>
}

void find_custom_btt_fee_rate(cache_holder ch){
    ch.flag = "custom_btt_fee_rate";
    int pre_str_size = 19;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d019d6:	6028      	str	r0, [r5, #0]
    
    if(*(ch.value_length) > 0){
c0d019d8:	682b      	ldr	r3, [r5, #0]
c0d019da:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d019dc:	6802      	ldr	r2, [r0, #0]
c0d019de:	1c51      	adds	r1, r2, #1
c0d019e0:	6001      	str	r1, [r0, #0]
c0d019e2:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d019e4:	188a      	adds	r2, r1, r2
c0d019e6:	2b01      	cmp	r3, #1
c0d019e8:	db0c      	blt.n	c0d01a04 <find_custom_btt_fee_rate+0x50>
        ch.encode[(*(ch.encode_p))++] = 1;
c0d019ea:	7016      	strb	r6, [r2, #0]

        if(*(ch.value_length) > 1){
c0d019ec:	682a      	ldr	r2, [r5, #0]
c0d019ee:	2a02      	cmp	r2, #2
c0d019f0:	db0b      	blt.n	c0d01a0a <find_custom_btt_fee_rate+0x56>
            ch.encode[(*(ch.encode_p))++] = (ch.cache[1] - 48);
c0d019f2:	7862      	ldrb	r2, [r4, #1]
c0d019f4:	6803      	ldr	r3, [r0, #0]
c0d019f6:	1c5d      	adds	r5, r3, #1
c0d019f8:	6005      	str	r5, [r0, #0]
c0d019fa:	32d0      	adds	r2, #208	; 0xd0
c0d019fc:	54ca      	strb	r2, [r1, r3]
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
c0d019fe:	7822      	ldrb	r2, [r4, #0]
c0d01a00:	32d0      	adds	r2, #208	; 0xd0
c0d01a02:	e009      	b.n	c0d01a18 <find_custom_btt_fee_rate+0x64>
        } else {
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
            ch.encode[(*(ch.encode_p))++] = 0;
        }
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
c0d01a04:	2000      	movs	r0, #0
c0d01a06:	7010      	strb	r0, [r2, #0]
c0d01a08:	e00a      	b.n	c0d01a20 <find_custom_btt_fee_rate+0x6c>

        if(*(ch.value_length) > 1){
            ch.encode[(*(ch.encode_p))++] = (ch.cache[1] - 48);
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
        } else {
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
c0d01a0a:	7822      	ldrb	r2, [r4, #0]
c0d01a0c:	6803      	ldr	r3, [r0, #0]
c0d01a0e:	1c5c      	adds	r4, r3, #1
c0d01a10:	6004      	str	r4, [r0, #0]
c0d01a12:	32d0      	adds	r2, #208	; 0xd0
c0d01a14:	54ca      	strb	r2, [r1, r3]
c0d01a16:	2200      	movs	r2, #0
c0d01a18:	6803      	ldr	r3, [r0, #0]
c0d01a1a:	1c5c      	adds	r4, r3, #1
c0d01a1c:	6004      	str	r4, [r0, #0]
c0d01a1e:	54ca      	strb	r2, [r1, r3]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"custom_btt_fee_rate=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01a20:	b004      	add	sp, #16
c0d01a22:	bd70      	pop	{r4, r5, r6, pc}
c0d01a24:	74737563 	.word	0x74737563
c0d01a28:	625f6d6f 	.word	0x625f6d6f
c0d01a2c:	665f7474 	.word	0x665f7474
c0d01a30:	725f6565 	.word	0x725f6565
c0d01a34:	00657461 	.word	0x00657461

c0d01a38 <find_custom_no_btt_fee_rate>:

void find_custom_no_btt_fee_rate(cache_holder ch){
c0d01a38:	b570      	push	{r4, r5, r6, lr}
c0d01a3a:	b084      	sub	sp, #16
c0d01a3c:	4614      	mov	r4, r2
c0d01a3e:	460d      	mov	r5, r1
c0d01a40:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01a42:	9003      	str	r0, [sp, #12]
    ch.flag = "custom_no_btt_fee_rate";
    int pre_str_size = 22;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01a44:	9b03      	ldr	r3, [sp, #12]
c0d01a46:	2601      	movs	r6, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01a48:	4668      	mov	r0, sp
c0d01a4a:	6086      	str	r6, [r0, #8]
c0d01a4c:	2116      	movs	r1, #22
c0d01a4e:	6001      	str	r1, [r0, #0]
c0d01a50:	a115      	add	r1, pc, #84	; (adr r1, c0d01aa8 <find_custom_no_btt_fee_rate+0x70>)
c0d01a52:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01a54:	4620      	mov	r0, r4
c0d01a56:	f7ff f937 	bl	c0d00cc8 <find_data_processor>
}

void find_custom_no_btt_fee_rate(cache_holder ch){
    ch.flag = "custom_no_btt_fee_rate";
    int pre_str_size = 22;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01a5a:	6028      	str	r0, [r5, #0]
    
    if(*(ch.value_length) > 0){
c0d01a5c:	682b      	ldr	r3, [r5, #0]
c0d01a5e:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d01a60:	6802      	ldr	r2, [r0, #0]
c0d01a62:	1c51      	adds	r1, r2, #1
c0d01a64:	6001      	str	r1, [r0, #0]
c0d01a66:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01a68:	188a      	adds	r2, r1, r2
c0d01a6a:	2b01      	cmp	r3, #1
c0d01a6c:	db0c      	blt.n	c0d01a88 <find_custom_no_btt_fee_rate+0x50>
        ch.encode[(*(ch.encode_p))++] = 1;
c0d01a6e:	7016      	strb	r6, [r2, #0]

        if(*(ch.value_length) > 1){
c0d01a70:	682a      	ldr	r2, [r5, #0]
c0d01a72:	2a02      	cmp	r2, #2
c0d01a74:	db0b      	blt.n	c0d01a8e <find_custom_no_btt_fee_rate+0x56>
            ch.encode[(*(ch.encode_p))++] = (ch.cache[1] - 48);
c0d01a76:	7862      	ldrb	r2, [r4, #1]
c0d01a78:	6803      	ldr	r3, [r0, #0]
c0d01a7a:	1c5d      	adds	r5, r3, #1
c0d01a7c:	6005      	str	r5, [r0, #0]
c0d01a7e:	32d0      	adds	r2, #208	; 0xd0
c0d01a80:	54ca      	strb	r2, [r1, r3]
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
c0d01a82:	7822      	ldrb	r2, [r4, #0]
c0d01a84:	32d0      	adds	r2, #208	; 0xd0
c0d01a86:	e009      	b.n	c0d01a9c <find_custom_no_btt_fee_rate+0x64>
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
            ch.encode[(*(ch.encode_p))++] = 0;
        }
        
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
c0d01a88:	2000      	movs	r0, #0
c0d01a8a:	7010      	strb	r0, [r2, #0]
c0d01a8c:	e00a      	b.n	c0d01aa4 <find_custom_no_btt_fee_rate+0x6c>

        if(*(ch.value_length) > 1){
            ch.encode[(*(ch.encode_p))++] = (ch.cache[1] - 48);
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
        } else {
            ch.encode[(*(ch.encode_p))++] = (ch.cache[0] - 48);
c0d01a8e:	7822      	ldrb	r2, [r4, #0]
c0d01a90:	6803      	ldr	r3, [r0, #0]
c0d01a92:	1c5c      	adds	r4, r3, #1
c0d01a94:	6004      	str	r4, [r0, #0]
c0d01a96:	32d0      	adds	r2, #208	; 0xd0
c0d01a98:	54ca      	strb	r2, [r1, r3]
c0d01a9a:	2200      	movs	r2, #0
c0d01a9c:	6803      	ldr	r3, [r0, #0]
c0d01a9e:	1c5c      	adds	r4, r3, #1
c0d01aa0:	6004      	str	r4, [r0, #0]
c0d01aa2:	54ca      	strb	r2, [r1, r3]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"custom_no_btt_fee_rate=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01aa4:	b004      	add	sp, #16
c0d01aa6:	bd70      	pop	{r4, r5, r6, pc}
c0d01aa8:	74737563 	.word	0x74737563
c0d01aac:	6e5f6d6f 	.word	0x6e5f6d6f
c0d01ab0:	74625f6f 	.word	0x74625f6f
c0d01ab4:	65665f74 	.word	0x65665f74
c0d01ab8:	61725f65 	.word	0x61725f65
c0d01abc:	00006574 	.word	0x00006574

c0d01ac0 <find_money_id>:

void find_money_id(cache_holder ch){
c0d01ac0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ac2:	b085      	sub	sp, #20
c0d01ac4:	4614      	mov	r4, r2
c0d01ac6:	460d      	mov	r5, r1
c0d01ac8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01aca:	9004      	str	r0, [sp, #16]
    ch.flag = "money_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01acc:	9b04      	ldr	r3, [sp, #16]
c0d01ace:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01ad0:	4669      	mov	r1, sp
c0d01ad2:	6088      	str	r0, [r1, #8]
c0d01ad4:	2008      	movs	r0, #8
c0d01ad6:	6008      	str	r0, [r1, #0]
c0d01ad8:	a10f      	add	r1, pc, #60	; (adr r1, c0d01b18 <find_money_id+0x58>)
c0d01ada:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01adc:	4620      	mov	r0, r4
c0d01ade:	f7ff f8f3 	bl	c0d00cc8 <find_data_processor>
}

void find_money_id(cache_holder ch){
    ch.flag = "money_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01ae2:	6028      	str	r0, [r5, #0]
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01ae4:	682a      	ldr	r2, [r5, #0]
c0d01ae6:	2000      	movs	r0, #0
c0d01ae8:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01aea:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d01aec:	2a01      	cmp	r2, #1
c0d01aee:	db0a      	blt.n	c0d01b06 <find_money_id+0x46>
c0d01af0:	2200      	movs	r2, #0
c0d01af2:	4610      	mov	r0, r2
        num = (num * 10);
        num += (ch.cache[i] - 48);
c0d01af4:	5ca3      	ldrb	r3, [r4, r2]
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        num = (num * 10);
c0d01af6:	270a      	movs	r7, #10
c0d01af8:	4347      	muls	r7, r0
        num += (ch.cache[i] - 48);
c0d01afa:	18f8      	adds	r0, r7, r3
c0d01afc:	3830      	subs	r0, #48	; 0x30
    ch.flag = "money_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01afe:	1c52      	adds	r2, r2, #1
c0d01b00:	682b      	ldr	r3, [r5, #0]
c0d01b02:	429a      	cmp	r2, r3
c0d01b04:	dbf6      	blt.n	c0d01af4 <find_money_id+0x34>
        num = (num * 10);
        num += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));
c0d01b06:	6832      	ldr	r2, [r6, #0]
c0d01b08:	1889      	adds	r1, r1, r2
c0d01b0a:	f001 f8f0 	bl	c0d02cee <uint32_to_bytes_net>
c0d01b0e:	6831      	ldr	r1, [r6, #0]
c0d01b10:	1808      	adds	r0, r1, r0
c0d01b12:	6030      	str	r0, [r6, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"money_id=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01b14:	b005      	add	sp, #20
c0d01b16:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01b18:	656e6f6d 	.word	0x656e6f6d
c0d01b1c:	64695f79 	.word	0x64695f79
c0d01b20:	00000000 	.word	0x00000000

c0d01b24 <find_stock_id>:

void find_stock_id(cache_holder ch){
c0d01b24:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b26:	b085      	sub	sp, #20
c0d01b28:	4614      	mov	r4, r2
c0d01b2a:	460d      	mov	r5, r1
c0d01b2c:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01b2e:	9004      	str	r0, [sp, #16]
    ch.flag = "stock_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01b30:	9b04      	ldr	r3, [sp, #16]
c0d01b32:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01b34:	4669      	mov	r1, sp
c0d01b36:	6088      	str	r0, [r1, #8]
c0d01b38:	2008      	movs	r0, #8
c0d01b3a:	6008      	str	r0, [r1, #0]
c0d01b3c:	a10f      	add	r1, pc, #60	; (adr r1, c0d01b7c <find_stock_id+0x58>)
c0d01b3e:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01b40:	4620      	mov	r0, r4
c0d01b42:	f7ff f8c1 	bl	c0d00cc8 <find_data_processor>
}

void find_stock_id(cache_holder ch){
    ch.flag = "stock_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01b46:	6028      	str	r0, [r5, #0]
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01b48:	682a      	ldr	r2, [r5, #0]
c0d01b4a:	2000      	movs	r0, #0
c0d01b4c:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01b4e:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d01b50:	2a01      	cmp	r2, #1
c0d01b52:	db0a      	blt.n	c0d01b6a <find_stock_id+0x46>
c0d01b54:	2200      	movs	r2, #0
c0d01b56:	4610      	mov	r0, r2
        num = (num * 10);
        num += (ch.cache[i] - 48);
c0d01b58:	5ca3      	ldrb	r3, [r4, r2]
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        num = (num * 10);
c0d01b5a:	270a      	movs	r7, #10
c0d01b5c:	4347      	muls	r7, r0
        num += (ch.cache[i] - 48);
c0d01b5e:	18f8      	adds	r0, r7, r3
c0d01b60:	3830      	subs	r0, #48	; 0x30
    ch.flag = "stock_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01b62:	1c52      	adds	r2, r2, #1
c0d01b64:	682b      	ldr	r3, [r5, #0]
c0d01b66:	429a      	cmp	r2, r3
c0d01b68:	dbf6      	blt.n	c0d01b58 <find_stock_id+0x34>
        num = (num * 10);
        num += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));
c0d01b6a:	6832      	ldr	r2, [r6, #0]
c0d01b6c:	1889      	adds	r1, r1, r2
c0d01b6e:	f001 f8be 	bl	c0d02cee <uint32_to_bytes_net>
c0d01b72:	6831      	ldr	r1, [r6, #0]
c0d01b74:	1808      	adds	r0, r1, r0
c0d01b76:	6030      	str	r0, [r6, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"stock_id=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01b78:	b005      	add	sp, #20
c0d01b7a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01b7c:	636f7473 	.word	0x636f7473
c0d01b80:	64695f6b 	.word	0x64695f6b
c0d01b84:	00000000 	.word	0x00000000

c0d01b88 <find_asset_type>:

void find_asset_type(cache_holder ch){
c0d01b88:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b8a:	b085      	sub	sp, #20
c0d01b8c:	4614      	mov	r4, r2
c0d01b8e:	460d      	mov	r5, r1
c0d01b90:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01b92:	9004      	str	r0, [sp, #16]
    ch.flag = "asset_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01b94:	9b04      	ldr	r3, [sp, #16]
c0d01b96:	2001      	movs	r0, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01b98:	4669      	mov	r1, sp
c0d01b9a:	6088      	str	r0, [r1, #8]
c0d01b9c:	260a      	movs	r6, #10
c0d01b9e:	600e      	str	r6, [r1, #0]
c0d01ba0:	a10f      	add	r1, pc, #60	; (adr r1, c0d01be0 <find_asset_type+0x58>)
c0d01ba2:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01ba4:	4620      	mov	r0, r4
c0d01ba6:	f7ff f88f 	bl	c0d00cc8 <find_data_processor>
}

void find_asset_type(cache_holder ch){
    ch.flag = "asset_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01baa:	6028      	str	r0, [r5, #0]
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01bac:	682a      	ldr	r2, [r5, #0]
c0d01bae:	2000      	movs	r0, #0
c0d01bb0:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01bb2:	9f0e      	ldr	r7, [sp, #56]	; 0x38
c0d01bb4:	2a01      	cmp	r2, #1
c0d01bb6:	db09      	blt.n	c0d01bcc <find_asset_type+0x44>
c0d01bb8:	2200      	movs	r2, #0
c0d01bba:	4610      	mov	r0, r2
        num = (num * 10);
        num += (ch.cache[i] - 48);
c0d01bbc:	5ca3      	ldrb	r3, [r4, r2]
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
        num = (num * 10);
c0d01bbe:	4370      	muls	r0, r6
        num += (ch.cache[i] - 48);
c0d01bc0:	18c0      	adds	r0, r0, r3
c0d01bc2:	3830      	subs	r0, #48	; 0x30
    ch.flag = "asset_type";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
    
    uint32_t num = 0;
    for(int i = 0; i < *(ch.value_length); i++){
c0d01bc4:	1c52      	adds	r2, r2, #1
c0d01bc6:	682b      	ldr	r3, [r5, #0]
c0d01bc8:	429a      	cmp	r2, r3
c0d01bca:	dbf7      	blt.n	c0d01bbc <find_asset_type+0x34>
        num = (num * 10);
        num += (ch.cache[i] - 48);
    }
    *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));
c0d01bcc:	683a      	ldr	r2, [r7, #0]
c0d01bce:	1889      	adds	r1, r1, r2
c0d01bd0:	f001 f88d 	bl	c0d02cee <uint32_to_bytes_net>
c0d01bd4:	6839      	ldr	r1, [r7, #0]
c0d01bd6:	1808      	adds	r0, r1, r0
c0d01bd8:	6038      	str	r0, [r7, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"asset_type=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01bda:	b005      	add	sp, #20
c0d01bdc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01bde:	46c0      	nop			; (mov r8, r8)
c0d01be0:	65737361 	.word	0x65737361
c0d01be4:	79745f74 	.word	0x79745f74
c0d01be8:	00006570 	.word	0x00006570

c0d01bec <find_asset_fee>:

void find_asset_fee(cache_holder ch){
c0d01bec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01bee:	b085      	sub	sp, #20
c0d01bf0:	4614      	mov	r4, r2
c0d01bf2:	460d      	mov	r5, r1
c0d01bf4:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d01bf6:	9004      	str	r0, [sp, #16]
    ch.flag = "asset_fee";
    int pre_str_size = 9;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01bf8:	9b04      	ldr	r3, [sp, #16]
c0d01bfa:	2701      	movs	r7, #1

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01bfc:	4668      	mov	r0, sp
c0d01bfe:	6087      	str	r7, [r0, #8]
c0d01c00:	2109      	movs	r1, #9
c0d01c02:	6001      	str	r1, [r0, #0]
c0d01c04:	a115      	add	r1, pc, #84	; (adr r1, c0d01c5c <find_asset_fee+0x70>)
c0d01c06:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01c08:	4620      	mov	r0, r4
c0d01c0a:	f7ff f85d 	bl	c0d00cc8 <find_data_processor>
}

void find_asset_fee(cache_holder ch){
    ch.flag = "asset_fee";
    int pre_str_size = 9;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01c0e:	6028      	str	r0, [r5, #0]
    
    if(*(ch.value_length) > 0){
c0d01c10:	682a      	ldr	r2, [r5, #0]
c0d01c12:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d01c14:	6830      	ldr	r0, [r6, #0]
c0d01c16:	1c41      	adds	r1, r0, #1
c0d01c18:	6031      	str	r1, [r6, #0]
c0d01c1a:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01c1c:	1808      	adds	r0, r1, r0
c0d01c1e:	2a01      	cmp	r2, #1
c0d01c20:	db17      	blt.n	c0d01c52 <find_asset_fee+0x66>

        ch.encode[(*(ch.encode_p))++] = 1;
c0d01c22:	7007      	strb	r7, [r0, #0]

        uint32_t num = 0;
        for(int i = 0; i < *(ch.value_length); i++){
c0d01c24:	682a      	ldr	r2, [r5, #0]
c0d01c26:	2000      	movs	r0, #0
c0d01c28:	2a01      	cmp	r2, #1
c0d01c2a:	db0a      	blt.n	c0d01c42 <find_asset_fee+0x56>
c0d01c2c:	2200      	movs	r2, #0
c0d01c2e:	4610      	mov	r0, r2
            num = (num * 10);
            num += (ch.cache[i] - 48);
c0d01c30:	5ca3      	ldrb	r3, [r4, r2]

        ch.encode[(*(ch.encode_p))++] = 1;

        uint32_t num = 0;
        for(int i = 0; i < *(ch.value_length); i++){
            num = (num * 10);
c0d01c32:	270a      	movs	r7, #10
c0d01c34:	4347      	muls	r7, r0
            num += (ch.cache[i] - 48);
c0d01c36:	18f8      	adds	r0, r7, r3
c0d01c38:	3830      	subs	r0, #48	; 0x30
    if(*(ch.value_length) > 0){

        ch.encode[(*(ch.encode_p))++] = 1;

        uint32_t num = 0;
        for(int i = 0; i < *(ch.value_length); i++){
c0d01c3a:	1c52      	adds	r2, r2, #1
c0d01c3c:	682b      	ldr	r3, [r5, #0]
c0d01c3e:	429a      	cmp	r2, r3
c0d01c40:	dbf6      	blt.n	c0d01c30 <find_asset_fee+0x44>
            num = (num * 10);
            num += (ch.cache[i] - 48);
        }
        *(ch.encode_p) += uint32_to_bytes_net(num, &(ch.encode[(*(ch.encode_p))]));
c0d01c42:	6832      	ldr	r2, [r6, #0]
c0d01c44:	1889      	adds	r1, r1, r2
c0d01c46:	f001 f852 	bl	c0d02cee <uint32_to_bytes_net>
c0d01c4a:	6831      	ldr	r1, [r6, #0]
c0d01c4c:	1808      	adds	r0, r1, r0
c0d01c4e:	6030      	str	r0, [r6, #0]
c0d01c50:	e001      	b.n	c0d01c56 <find_asset_fee+0x6a>
    } else {
        ch.encode[(*(ch.encode_p))++] = 0;
c0d01c52:	2100      	movs	r1, #0
c0d01c54:	7001      	strb	r1, [r0, #0]
        os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"asset_fee=", pre_str_size + 1);
        *(ch.data_p) += (pre_str_size + 1);
        read_message(ch);
    }
#endif 
}
c0d01c56:	b005      	add	sp, #20
c0d01c58:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01c5a:	46c0      	nop			; (mov r8, r8)
c0d01c5c:	65737361 	.word	0x65737361
c0d01c60:	65665f74 	.word	0x65665f74
c0d01c64:	00000065 	.word	0x00000065

c0d01c68 <find_order_id>:

void find_order_id(cache_holder ch){
c0d01c68:	b570      	push	{r4, r5, r6, lr}
c0d01c6a:	b084      	sub	sp, #16
c0d01c6c:	4615      	mov	r5, r2
c0d01c6e:	460c      	mov	r4, r1
c0d01c70:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01c72:	9003      	str	r0, [sp, #12]
    ch.flag = "order_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01c74:	9b03      	ldr	r3, [sp, #12]

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01c76:	2001      	movs	r0, #1
c0d01c78:	4669      	mov	r1, sp
c0d01c7a:	6088      	str	r0, [r1, #8]
c0d01c7c:	2008      	movs	r0, #8
c0d01c7e:	6008      	str	r0, [r1, #0]
c0d01c80:	a109      	add	r1, pc, #36	; (adr r1, c0d01ca8 <find_order_id+0x40>)
c0d01c82:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01c84:	4628      	mov	r0, r5
c0d01c86:	f7ff f81f 	bl	c0d00cc8 <find_data_processor>
}

void find_order_id(cache_holder ch){
    ch.flag = "order_id";
    int pre_str_size = 8;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01c8a:	6020      	str	r0, [r4, #0]
c0d01c8c:	9e0c      	ldr	r6, [sp, #48]	; 0x30
    
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d01c8e:	6830      	ldr	r0, [r6, #0]
c0d01c90:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01c92:	1808      	adds	r0, r1, r0
c0d01c94:	6822      	ldr	r2, [r4, #0]
c0d01c96:	4629      	mov	r1, r5
c0d01c98:	f001 f888 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d01c9c:	6820      	ldr	r0, [r4, #0]
c0d01c9e:	6831      	ldr	r1, [r6, #0]
c0d01ca0:	1808      	adds	r0, r1, r0
c0d01ca2:	6030      	str	r0, [r6, #0]
    //     os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"order_id=", pre_str_size + 1);
    //     *(ch.data_p) += (pre_str_size + 1);
    //     read_message(ch);
    // }
#endif 
}
c0d01ca4:	b004      	add	sp, #16
c0d01ca6:	bd70      	pop	{r4, r5, r6, pc}
c0d01ca8:	6564726f 	.word	0x6564726f
c0d01cac:	64695f72 	.word	0x64695f72
c0d01cb0:	00000000 	.word	0x00000000

c0d01cb4 <find_payment_id>:

void find_payment_id(cache_holder ch){
c0d01cb4:	b570      	push	{r4, r5, r6, lr}
c0d01cb6:	b084      	sub	sp, #16
c0d01cb8:	4615      	mov	r5, r2
c0d01cba:	460c      	mov	r4, r1
c0d01cbc:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01cbe:	9003      	str	r0, [sp, #12]
    ch.flag = "payment_id";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01cc0:	9b03      	ldr	r3, [sp, #12]

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01cc2:	2001      	movs	r0, #1
c0d01cc4:	4669      	mov	r1, sp
c0d01cc6:	6088      	str	r0, [r1, #8]
c0d01cc8:	200a      	movs	r0, #10
c0d01cca:	6008      	str	r0, [r1, #0]
c0d01ccc:	a109      	add	r1, pc, #36	; (adr r1, c0d01cf4 <find_payment_id+0x40>)
c0d01cce:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01cd0:	4628      	mov	r0, r5
c0d01cd2:	f7fe fff9 	bl	c0d00cc8 <find_data_processor>
}

void find_payment_id(cache_holder ch){
    ch.flag = "payment_id";
    int pre_str_size = 10;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01cd6:	6020      	str	r0, [r4, #0]
c0d01cd8:	9e0c      	ldr	r6, [sp, #48]	; 0x30
    
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d01cda:	6830      	ldr	r0, [r6, #0]
c0d01cdc:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01cde:	1808      	adds	r0, r1, r0
c0d01ce0:	6822      	ldr	r2, [r4, #0]
c0d01ce2:	4629      	mov	r1, r5
c0d01ce4:	f001 f862 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d01ce8:	6820      	ldr	r0, [r4, #0]
c0d01cea:	6831      	ldr	r1, [r6, #0]
c0d01cec:	1808      	adds	r0, r1, r0
c0d01cee:	6030      	str	r0, [r6, #0]
    //     os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"payment_id=", pre_str_size + 1);
    //     *(ch.data_p) += (pre_str_size + 1);
    //     read_message(ch);
    // }
#endif 
}
c0d01cf0:	b004      	add	sp, #16
c0d01cf2:	bd70      	pop	{r4, r5, r6, pc}
c0d01cf4:	6d796170 	.word	0x6d796170
c0d01cf8:	5f746e65 	.word	0x5f746e65
c0d01cfc:	00006469 	.word	0x00006469

c0d01d00 <find_contract_id>:

void find_contract_id(cache_holder ch){
c0d01d00:	b570      	push	{r4, r5, r6, lr}
c0d01d02:	b084      	sub	sp, #16
c0d01d04:	4615      	mov	r5, r2
c0d01d06:	460c      	mov	r4, r1
c0d01d08:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01d0a:	9003      	str	r0, [sp, #12]
    ch.flag = "contract_id";
    int pre_str_size = 11;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01d0c:	9b03      	ldr	r3, [sp, #12]

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d01d0e:	2001      	movs	r0, #1
c0d01d10:	4669      	mov	r1, sp
c0d01d12:	6088      	str	r0, [r1, #8]
c0d01d14:	200b      	movs	r0, #11
c0d01d16:	6008      	str	r0, [r1, #0]
c0d01d18:	a109      	add	r1, pc, #36	; (adr r1, c0d01d40 <find_contract_id+0x40>)
c0d01d1a:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d01d1c:	4628      	mov	r0, r5
c0d01d1e:	f7fe ffd3 	bl	c0d00cc8 <find_data_processor>
}

void find_contract_id(cache_holder ch){
    ch.flag = "contract_id";
    int pre_str_size = 11;
    *(ch.value_length) = find_data(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation);
c0d01d22:	6020      	str	r0, [r4, #0]
c0d01d24:	9e0c      	ldr	r6, [sp, #48]	; 0x30
    
    os_memcpy(&(ch.encode[*(ch.encode_p)]), (unsigned char *)(ch.cache), *(ch.value_length));
c0d01d26:	6830      	ldr	r0, [r6, #0]
c0d01d28:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01d2a:	1808      	adds	r0, r1, r0
c0d01d2c:	6822      	ldr	r2, [r4, #0]
c0d01d2e:	4629      	mov	r1, r5
c0d01d30:	f001 f83c 	bl	c0d02dac <os_memmove>
    *(ch.encode_p) += *(ch.value_length);
c0d01d34:	6820      	ldr	r0, [r4, #0]
c0d01d36:	6831      	ldr	r1, [r6, #0]
c0d01d38:	1808      	adds	r0, r1, r0
c0d01d3a:	6030      	str	r0, [r6, #0]
    //     os_memcpy(&(ch.operation->data[*(ch.data_p)]), (unsigned char *)"contract_id=", pre_str_size + 1);
    //     *(ch.data_p) += (pre_str_size + 1);
    //     read_message(ch);
    // }
#endif 
}
c0d01d3c:	b004      	add	sp, #16
c0d01d3e:	bd70      	pop	{r4, r5, r6, pc}
c0d01d40:	746e6f63 	.word	0x746e6f63
c0d01d44:	74636172 	.word	0x74636172
c0d01d48:	0064695f 	.word	0x0064695f

c0d01d4c <find_proposed_ops>:

void find_proposed_ops(cache_holder ch, bool *go_next_p){
c0d01d4c:	b5b0      	push	{r4, r5, r7, lr}
c0d01d4e:	b084      	sub	sp, #16
c0d01d50:	460c      	mov	r4, r1
c0d01d52:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d01d54:	9003      	str	r0, [sp, #12]
    ch.flag = "proposed_ops";
    int pre_str_size = 12;
    (*(ch.value_length)) = find_data_processor(ch.cache, ch.flag, ch.input, ch.length, pre_str_size, ch.operation, false);
c0d01d56:	9b03      	ldr	r3, [sp, #12]
c0d01d58:	2000      	movs	r0, #0
c0d01d5a:	4669      	mov	r1, sp
c0d01d5c:	6088      	str	r0, [r1, #8]
c0d01d5e:	200c      	movs	r0, #12
c0d01d60:	6008      	str	r0, [r1, #0]
c0d01d62:	a10d      	add	r1, pc, #52	; (adr r1, c0d01d98 <find_proposed_ops+0x4c>)
c0d01d64:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d01d66:	4610      	mov	r0, r2
c0d01d68:	462a      	mov	r2, r5
c0d01d6a:	f7fe ffad 	bl	c0d00cc8 <find_data_processor>
c0d01d6e:	6020      	str	r0, [r4, #0]

    // os_memcpy(&(ch.encode[*(ch.encode_p)]), &(ch.input[find_info_delimiter + 1]), *(ch.value_length));
    // *(ch.encode_p) += *(ch.value_length);

    internal_structure = true;
c0d01d70:	480d      	ldr	r0, [pc, #52]	; (c0d01da8 <find_proposed_ops+0x5c>)
c0d01d72:	2101      	movs	r1, #1
c0d01d74:	7001      	strb	r1, [r0, #0]
    find_i = find_info_delimiter;
c0d01d76:	480d      	ldr	r0, [pc, #52]	; (c0d01dac <find_proposed_ops+0x60>)
c0d01d78:	6800      	ldr	r0, [r0, #0]
c0d01d7a:	490d      	ldr	r1, [pc, #52]	; (c0d01db0 <find_proposed_ops+0x64>)
c0d01d7c:	6008      	str	r0, [r1, #0]
c0d01d7e:	1828      	adds	r0, r5, r0

    int ops_size = ch.input[find_info_delimiter + 1] - 48;
c0d01d80:	7840      	ldrb	r0, [r0, #1]
c0d01d82:	990c      	ldr	r1, [sp, #48]	; 0x30
    ch.encode[(*(ch.encode_p))++] = (char) ops_size;
c0d01d84:	680a      	ldr	r2, [r1, #0]
c0d01d86:	1c53      	adds	r3, r2, #1
c0d01d88:	600b      	str	r3, [r1, #0]
    // *(ch.encode_p) += *(ch.value_length);

    internal_structure = true;
    find_i = find_info_delimiter;

    int ops_size = ch.input[find_info_delimiter + 1] - 48;
c0d01d8a:	3830      	subs	r0, #48	; 0x30
c0d01d8c:	990d      	ldr	r1, [sp, #52]	; 0x34
    ch.encode[(*(ch.encode_p))++] = (char) ops_size;
c0d01d8e:	5488      	strb	r0, [r1, r2]

    proposed_ops_array_size = ops_size;
c0d01d90:	4908      	ldr	r1, [pc, #32]	; (c0d01db4 <find_proposed_ops+0x68>)
c0d01d92:	6008      	str	r0, [r1, #0]

    
}
c0d01d94:	b004      	add	sp, #16
c0d01d96:	bdb0      	pop	{r4, r5, r7, pc}
c0d01d98:	706f7270 	.word	0x706f7270
c0d01d9c:	6465736f 	.word	0x6465736f
c0d01da0:	73706f5f 	.word	0x73706f5f
c0d01da4:	00000000 	.word	0x00000000
c0d01da8:	20001fa8 	.word	0x20001fa8
c0d01dac:	20001fac 	.word	0x20001fac
c0d01db0:	20001fa4 	.word	0x20001fa4
c0d01db4:	20001fb4 	.word	0x20001fb4

c0d01db8 <build_withdraw_operation_data>:

void build_withdraw_operation_data(cache_holder ch, bool *go_next_p){
c0d01db8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01dba:	b093      	sub	sp, #76	; 0x4c
c0d01dbc:	920c      	str	r2, [sp, #48]	; 0x30
c0d01dbe:	9109      	str	r1, [sp, #36]	; 0x24
c0d01dc0:	9c1c      	ldr	r4, [sp, #112]	; 0x70

    ch.encode[(*(ch.encode_p))++] = 4;
c0d01dc2:	6825      	ldr	r5, [r4, #0]
c0d01dc4:	1c6e      	adds	r6, r5, #1
c0d01dc6:	6026      	str	r6, [r4, #0]
c0d01dc8:	9410      	str	r4, [sp, #64]	; 0x40
c0d01dca:	9e1d      	ldr	r6, [sp, #116]	; 0x74
c0d01dcc:	960f      	str	r6, [sp, #60]	; 0x3c
c0d01dce:	2704      	movs	r7, #4
c0d01dd0:	5577      	strb	r7, [r6, r5]
c0d01dd2:	9d1e      	ldr	r5, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d01dd4:	9508      	str	r5, [sp, #32]
c0d01dd6:	466f      	mov	r7, sp
c0d01dd8:	61bd      	str	r5, [r7, #24]
c0d01dda:	617e      	str	r6, [r7, #20]
c0d01ddc:	613c      	str	r4, [r7, #16]
c0d01dde:	9c1b      	ldr	r4, [sp, #108]	; 0x6c
c0d01de0:	940d      	str	r4, [sp, #52]	; 0x34
c0d01de2:	60fc      	str	r4, [r7, #12]
c0d01de4:	9d1a      	ldr	r5, [sp, #104]	; 0x68
c0d01de6:	60bd      	str	r5, [r7, #8]
c0d01de8:	9511      	str	r5, [sp, #68]	; 0x44
c0d01dea:	9c19      	ldr	r4, [sp, #100]	; 0x64
c0d01dec:	940e      	str	r4, [sp, #56]	; 0x38
c0d01dee:	607c      	str	r4, [r7, #4]
c0d01df0:	9e18      	ldr	r6, [sp, #96]	; 0x60
c0d01df2:	9612      	str	r6, [sp, #72]	; 0x48
c0d01df4:	603e      	str	r6, [r7, #0]
c0d01df6:	4604      	mov	r4, r0
c0d01df8:	940a      	str	r4, [sp, #40]	; 0x28
c0d01dfa:	461f      	mov	r7, r3
c0d01dfc:	970b      	str	r7, [sp, #44]	; 0x2c
c0d01dfe:	f7ff f82d 	bl	c0d00e5c <find_fee>
    find_from(ch);
c0d01e02:	4668      	mov	r0, sp
c0d01e04:	6006      	str	r6, [r0, #0]
c0d01e06:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d01e08:	6046      	str	r6, [r0, #4]
c0d01e0a:	6085      	str	r5, [r0, #8]
c0d01e0c:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01e0e:	60c1      	str	r1, [r0, #12]
c0d01e10:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d01e12:	6101      	str	r1, [r0, #16]
c0d01e14:	9d0f      	ldr	r5, [sp, #60]	; 0x3c
c0d01e16:	6145      	str	r5, [r0, #20]
c0d01e18:	4620      	mov	r0, r4
c0d01e1a:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d01e1c:	4621      	mov	r1, r4
c0d01e1e:	9a0c      	ldr	r2, [sp, #48]	; 0x30
c0d01e20:	463b      	mov	r3, r7
c0d01e22:	f7ff fa85 	bl	c0d01330 <find_from>
    find_to_external_address(ch);
c0d01e26:	4668      	mov	r0, sp
c0d01e28:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d01e2a:	c042      	stmia	r0!, {r1, r6}
c0d01e2c:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d01e2e:	6001      	str	r1, [r0, #0]
c0d01e30:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d01e32:	6046      	str	r6, [r0, #4]
c0d01e34:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d01e36:	6081      	str	r1, [r0, #8]
c0d01e38:	60c5      	str	r5, [r0, #12]
c0d01e3a:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d01e3c:	4628      	mov	r0, r5
c0d01e3e:	4621      	mov	r1, r4
c0d01e40:	9f0c      	ldr	r7, [sp, #48]	; 0x30
c0d01e42:	463a      	mov	r2, r7
c0d01e44:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d01e46:	f7ff fb21 	bl	c0d0148c <find_to_external_address>
    find_asset_type(ch);
c0d01e4a:	4668      	mov	r0, sp
c0d01e4c:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d01e4e:	6001      	str	r1, [r0, #0]
c0d01e50:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01e52:	6041      	str	r1, [r0, #4]
c0d01e54:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d01e56:	6081      	str	r1, [r0, #8]
c0d01e58:	60c6      	str	r6, [r0, #12]
c0d01e5a:	9c10      	ldr	r4, [sp, #64]	; 0x40
c0d01e5c:	6104      	str	r4, [r0, #16]
c0d01e5e:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01e60:	6141      	str	r1, [r0, #20]
c0d01e62:	4628      	mov	r0, r5
c0d01e64:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d01e66:	4629      	mov	r1, r5
c0d01e68:	463a      	mov	r2, r7
c0d01e6a:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d01e6c:	4633      	mov	r3, r6
c0d01e6e:	f7ff fe8b 	bl	c0d01b88 <find_asset_type>
    find_amount(ch, go_next_p);
c0d01e72:	4668      	mov	r0, sp
c0d01e74:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d01e76:	6001      	str	r1, [r0, #0]
c0d01e78:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01e7a:	6041      	str	r1, [r0, #4]
c0d01e7c:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d01e7e:	6081      	str	r1, [r0, #8]
c0d01e80:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01e82:	60c1      	str	r1, [r0, #12]
c0d01e84:	6104      	str	r4, [r0, #16]
c0d01e86:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01e88:	6141      	str	r1, [r0, #20]
c0d01e8a:	9908      	ldr	r1, [sp, #32]
c0d01e8c:	6181      	str	r1, [r0, #24]
c0d01e8e:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d01e90:	4629      	mov	r1, r5
c0d01e92:	463a      	mov	r2, r7
c0d01e94:	4633      	mov	r3, r6
c0d01e96:	f7ff fbbd 	bl	c0d01614 <find_amount>
}
c0d01e9a:	b013      	add	sp, #76	; 0x4c
c0d01e9c:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d01ea0 <build_withdraw_operation>:

short build_withdraw_operation(char *input, int length, transaction *tx){
c0d01ea0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ea2:	b08d      	sub	sp, #52	; 0x34
c0d01ea4:	4615      	mov	r5, r2
c0d01ea6:	2400      	movs	r4, #0

    volatile int value_length = 0;
c0d01ea8:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d01eaa:	2264      	movs	r2, #100	; 0x64
c0d01eac:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d01eae:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d01eb0:	9109      	str	r1, [sp, #36]	; 0x24
c0d01eb2:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d01eb4:	6a2a      	ldr	r2, [r5, #32]
c0d01eb6:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d01eb8:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_withdraw_operation_data(ch, go_next_p);
c0d01eba:	466f      	mov	r7, sp
c0d01ebc:	61bb      	str	r3, [r7, #24]
c0d01ebe:	617a      	str	r2, [r7, #20]
c0d01ec0:	463a      	mov	r2, r7
c0d01ec2:	3208      	adds	r2, #8
c0d01ec4:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d01ec6:	4628      	mov	r0, r5
c0d01ec8:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_withdraw_operation_data(ch, go_next_p);
c0d01eca:	6078      	str	r0, [r7, #4]
c0d01ecc:	a80a      	add	r0, sp, #40	; 0x28
c0d01ece:	6038      	str	r0, [r7, #0]
c0d01ed0:	a90c      	add	r1, sp, #48	; 0x30
c0d01ed2:	4a07      	ldr	r2, [pc, #28]	; (c0d01ef0 <build_withdraw_operation+0x50>)
c0d01ed4:	ab0b      	add	r3, sp, #44	; 0x2c
c0d01ed6:	4620      	mov	r0, r4
c0d01ed8:	f7ff ff6e 	bl	c0d01db8 <build_withdraw_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d01edc:	68e8      	ldr	r0, [r5, #12]
c0d01ede:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01ee0:	1c4a      	adds	r2, r1, #1
c0d01ee2:	920a      	str	r2, [sp, #40]	; 0x28
c0d01ee4:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d01ee6:	6830      	ldr	r0, [r6, #0]
c0d01ee8:	b200      	sxth	r0, r0
c0d01eea:	b00d      	add	sp, #52	; 0x34
c0d01eec:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01eee:	46c0      	nop			; (mov r8, r8)
c0d01ef0:	20001fb8 	.word	0x20001fb8

c0d01ef4 <build_withdraw2_operation_data>:
}

void build_withdraw2_operation_data(cache_holder ch, bool *go_next_p){
c0d01ef4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ef6:	b093      	sub	sp, #76	; 0x4c
c0d01ef8:	930b      	str	r3, [sp, #44]	; 0x2c
c0d01efa:	9209      	str	r2, [sp, #36]	; 0x24
c0d01efc:	910e      	str	r1, [sp, #56]	; 0x38
c0d01efe:	9012      	str	r0, [sp, #72]	; 0x48
c0d01f00:	9c1c      	ldr	r4, [sp, #112]	; 0x70

    ch.encode[(*(ch.encode_p))++] = 26;
c0d01f02:	6825      	ldr	r5, [r4, #0]
c0d01f04:	1c6b      	adds	r3, r5, #1
c0d01f06:	6023      	str	r3, [r4, #0]
c0d01f08:	4627      	mov	r7, r4
c0d01f0a:	9711      	str	r7, [sp, #68]	; 0x44
c0d01f0c:	9e1d      	ldr	r6, [sp, #116]	; 0x74
c0d01f0e:	960a      	str	r6, [sp, #40]	; 0x28
c0d01f10:	231a      	movs	r3, #26
c0d01f12:	5573      	strb	r3, [r6, r5]
c0d01f14:	9c1e      	ldr	r4, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d01f16:	9408      	str	r4, [sp, #32]
c0d01f18:	466b      	mov	r3, sp
c0d01f1a:	619c      	str	r4, [r3, #24]
c0d01f1c:	615e      	str	r6, [r3, #20]
c0d01f1e:	611f      	str	r7, [r3, #16]
c0d01f20:	9c1b      	ldr	r4, [sp, #108]	; 0x6c
c0d01f22:	60dc      	str	r4, [r3, #12]
c0d01f24:	940f      	str	r4, [sp, #60]	; 0x3c
c0d01f26:	9d1a      	ldr	r5, [sp, #104]	; 0x68
c0d01f28:	9510      	str	r5, [sp, #64]	; 0x40
c0d01f2a:	609d      	str	r5, [r3, #8]
c0d01f2c:	9d19      	ldr	r5, [sp, #100]	; 0x64
c0d01f2e:	605d      	str	r5, [r3, #4]
c0d01f30:	950c      	str	r5, [sp, #48]	; 0x30
c0d01f32:	9e18      	ldr	r6, [sp, #96]	; 0x60
c0d01f34:	601e      	str	r6, [r3, #0]
c0d01f36:	9f0b      	ldr	r7, [sp, #44]	; 0x2c
c0d01f38:	463b      	mov	r3, r7
c0d01f3a:	f7fe ff8f 	bl	c0d00e5c <find_fee>
    find_from(ch);
c0d01f3e:	4668      	mov	r0, sp
c0d01f40:	6006      	str	r6, [r0, #0]
c0d01f42:	960d      	str	r6, [sp, #52]	; 0x34
c0d01f44:	6045      	str	r5, [r0, #4]
c0d01f46:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d01f48:	6085      	str	r5, [r0, #8]
c0d01f4a:	60c4      	str	r4, [r0, #12]
c0d01f4c:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d01f4e:	6101      	str	r1, [r0, #16]
c0d01f50:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d01f52:	6144      	str	r4, [r0, #20]
c0d01f54:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d01f56:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01f58:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d01f5a:	463b      	mov	r3, r7
c0d01f5c:	f7ff f9e8 	bl	c0d01330 <find_from>
    find_to_external_address(ch);
c0d01f60:	4668      	mov	r0, sp
c0d01f62:	6006      	str	r6, [r0, #0]
c0d01f64:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d01f66:	6046      	str	r6, [r0, #4]
c0d01f68:	6085      	str	r5, [r0, #8]
c0d01f6a:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01f6c:	60c1      	str	r1, [r0, #12]
c0d01f6e:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d01f70:	6101      	str	r1, [r0, #16]
c0d01f72:	6144      	str	r4, [r0, #20]
c0d01f74:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d01f76:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d01f78:	4629      	mov	r1, r5
c0d01f7a:	9f09      	ldr	r7, [sp, #36]	; 0x24
c0d01f7c:	463a      	mov	r2, r7
c0d01f7e:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d01f80:	f7ff fa84 	bl	c0d0148c <find_to_external_address>
    find_asset_type(ch);
c0d01f84:	4668      	mov	r0, sp
c0d01f86:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01f88:	c042      	stmia	r0!, {r1, r6}
c0d01f8a:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d01f8c:	6001      	str	r1, [r0, #0]
c0d01f8e:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01f90:	6041      	str	r1, [r0, #4]
c0d01f92:	9c11      	ldr	r4, [sp, #68]	; 0x44
c0d01f94:	6084      	str	r4, [r0, #8]
c0d01f96:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d01f98:	60c1      	str	r1, [r0, #12]
c0d01f9a:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d01f9c:	4629      	mov	r1, r5
c0d01f9e:	463a      	mov	r2, r7
c0d01fa0:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d01fa2:	4633      	mov	r3, r6
c0d01fa4:	f7ff fdf0 	bl	c0d01b88 <find_asset_type>
    find_amount(ch, go_next_p);
c0d01fa8:	4668      	mov	r0, sp
c0d01faa:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01fac:	6001      	str	r1, [r0, #0]
c0d01fae:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d01fb0:	6041      	str	r1, [r0, #4]
c0d01fb2:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d01fb4:	6081      	str	r1, [r0, #8]
c0d01fb6:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01fb8:	60c1      	str	r1, [r0, #12]
c0d01fba:	6104      	str	r4, [r0, #16]
c0d01fbc:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d01fbe:	6144      	str	r4, [r0, #20]
c0d01fc0:	9908      	ldr	r1, [sp, #32]
c0d01fc2:	6181      	str	r1, [r0, #24]
c0d01fc4:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d01fc6:	4628      	mov	r0, r5
c0d01fc8:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01fca:	463a      	mov	r2, r7
c0d01fcc:	4633      	mov	r3, r6
c0d01fce:	f7ff fb21 	bl	c0d01614 <find_amount>
    find_asset_fee(ch);
c0d01fd2:	4668      	mov	r0, sp
c0d01fd4:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d01fd6:	6001      	str	r1, [r0, #0]
c0d01fd8:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d01fda:	6041      	str	r1, [r0, #4]
c0d01fdc:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d01fde:	6081      	str	r1, [r0, #8]
c0d01fe0:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d01fe2:	60c1      	str	r1, [r0, #12]
c0d01fe4:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d01fe6:	6101      	str	r1, [r0, #16]
c0d01fe8:	6144      	str	r4, [r0, #20]
c0d01fea:	4628      	mov	r0, r5
c0d01fec:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d01fee:	463a      	mov	r2, r7
c0d01ff0:	4633      	mov	r3, r6
c0d01ff2:	f7ff fdfb 	bl	c0d01bec <find_asset_fee>
}
c0d01ff6:	b013      	add	sp, #76	; 0x4c
c0d01ff8:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d01ffc <build_withdraw2_operation>:

short build_withdraw2_operation(char *input, int length, transaction *tx){
c0d01ffc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01ffe:	b08d      	sub	sp, #52	; 0x34
c0d02000:	4615      	mov	r5, r2
c0d02002:	2400      	movs	r4, #0

    volatile int value_length = 0;
c0d02004:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d02006:	2264      	movs	r2, #100	; 0x64
c0d02008:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d0200a:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d0200c:	9109      	str	r1, [sp, #36]	; 0x24
c0d0200e:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d02010:	6a2a      	ldr	r2, [r5, #32]
c0d02012:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d02014:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_withdraw2_operation_data(ch, go_next_p);
c0d02016:	466f      	mov	r7, sp
c0d02018:	61bb      	str	r3, [r7, #24]
c0d0201a:	617a      	str	r2, [r7, #20]
c0d0201c:	463a      	mov	r2, r7
c0d0201e:	3208      	adds	r2, #8
c0d02020:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02022:	4628      	mov	r0, r5
c0d02024:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_withdraw2_operation_data(ch, go_next_p);
c0d02026:	6078      	str	r0, [r7, #4]
c0d02028:	a80a      	add	r0, sp, #40	; 0x28
c0d0202a:	6038      	str	r0, [r7, #0]
c0d0202c:	a90c      	add	r1, sp, #48	; 0x30
c0d0202e:	4a07      	ldr	r2, [pc, #28]	; (c0d0204c <build_withdraw2_operation+0x50>)
c0d02030:	ab0b      	add	r3, sp, #44	; 0x2c
c0d02032:	4620      	mov	r0, r4
c0d02034:	f7ff ff5e 	bl	c0d01ef4 <build_withdraw2_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02038:	68e8      	ldr	r0, [r5, #12]
c0d0203a:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0203c:	1c4a      	adds	r2, r1, #1
c0d0203e:	920a      	str	r2, [sp, #40]	; 0x28
c0d02040:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d02042:	6830      	ldr	r0, [r6, #0]
c0d02044:	b200      	sxth	r0, r0
c0d02046:	b00d      	add	sp, #52	; 0x34
c0d02048:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0204a:	46c0      	nop			; (mov r8, r8)
c0d0204c:	20001fb8 	.word	0x20001fb8

c0d02050 <build_transfer2_operation_data>:
}

void build_transfer2_operation_data(cache_holder ch, bool *go_next_p){
c0d02050:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02052:	b093      	sub	sp, #76	; 0x4c
c0d02054:	930b      	str	r3, [sp, #44]	; 0x2c
c0d02056:	9209      	str	r2, [sp, #36]	; 0x24
c0d02058:	910e      	str	r1, [sp, #56]	; 0x38
c0d0205a:	9012      	str	r0, [sp, #72]	; 0x48
c0d0205c:	9c1c      	ldr	r4, [sp, #112]	; 0x70
    ch.encode[(*(ch.encode_p))++] = 28;
c0d0205e:	6825      	ldr	r5, [r4, #0]
c0d02060:	1c6b      	adds	r3, r5, #1
c0d02062:	6023      	str	r3, [r4, #0]
c0d02064:	4627      	mov	r7, r4
c0d02066:	9711      	str	r7, [sp, #68]	; 0x44
c0d02068:	9e1d      	ldr	r6, [sp, #116]	; 0x74
c0d0206a:	960a      	str	r6, [sp, #40]	; 0x28
c0d0206c:	231c      	movs	r3, #28
c0d0206e:	5573      	strb	r3, [r6, r5]
c0d02070:	9c1e      	ldr	r4, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d02072:	9408      	str	r4, [sp, #32]
c0d02074:	466b      	mov	r3, sp
c0d02076:	619c      	str	r4, [r3, #24]
c0d02078:	615e      	str	r6, [r3, #20]
c0d0207a:	611f      	str	r7, [r3, #16]
c0d0207c:	9c1b      	ldr	r4, [sp, #108]	; 0x6c
c0d0207e:	60dc      	str	r4, [r3, #12]
c0d02080:	940f      	str	r4, [sp, #60]	; 0x3c
c0d02082:	9d1a      	ldr	r5, [sp, #104]	; 0x68
c0d02084:	9510      	str	r5, [sp, #64]	; 0x40
c0d02086:	609d      	str	r5, [r3, #8]
c0d02088:	9d19      	ldr	r5, [sp, #100]	; 0x64
c0d0208a:	605d      	str	r5, [r3, #4]
c0d0208c:	950c      	str	r5, [sp, #48]	; 0x30
c0d0208e:	9e18      	ldr	r6, [sp, #96]	; 0x60
c0d02090:	601e      	str	r6, [r3, #0]
c0d02092:	9f0b      	ldr	r7, [sp, #44]	; 0x2c
c0d02094:	463b      	mov	r3, r7
c0d02096:	f7fe fee1 	bl	c0d00e5c <find_fee>
    find_from(ch);
c0d0209a:	4668      	mov	r0, sp
c0d0209c:	6006      	str	r6, [r0, #0]
c0d0209e:	960d      	str	r6, [sp, #52]	; 0x34
c0d020a0:	6045      	str	r5, [r0, #4]
c0d020a2:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d020a4:	6085      	str	r5, [r0, #8]
c0d020a6:	60c4      	str	r4, [r0, #12]
c0d020a8:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d020aa:	6101      	str	r1, [r0, #16]
c0d020ac:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d020ae:	6144      	str	r4, [r0, #20]
c0d020b0:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d020b2:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d020b4:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d020b6:	463b      	mov	r3, r7
c0d020b8:	f7ff f93a 	bl	c0d01330 <find_from>
    find_to(ch);
c0d020bc:	4668      	mov	r0, sp
c0d020be:	6006      	str	r6, [r0, #0]
c0d020c0:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d020c2:	6046      	str	r6, [r0, #4]
c0d020c4:	6085      	str	r5, [r0, #8]
c0d020c6:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d020c8:	60c1      	str	r1, [r0, #12]
c0d020ca:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d020cc:	6101      	str	r1, [r0, #16]
c0d020ce:	6144      	str	r4, [r0, #20]
c0d020d0:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d020d2:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d020d4:	4629      	mov	r1, r5
c0d020d6:	9f09      	ldr	r7, [sp, #36]	; 0x24
c0d020d8:	463a      	mov	r2, r7
c0d020da:	9b0b      	ldr	r3, [sp, #44]	; 0x2c
c0d020dc:	f7ff f980 	bl	c0d013e0 <find_to>
    find_asset_type(ch);
c0d020e0:	4668      	mov	r0, sp
c0d020e2:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d020e4:	c042      	stmia	r0!, {r1, r6}
c0d020e6:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d020e8:	6001      	str	r1, [r0, #0]
c0d020ea:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d020ec:	6041      	str	r1, [r0, #4]
c0d020ee:	9c11      	ldr	r4, [sp, #68]	; 0x44
c0d020f0:	6084      	str	r4, [r0, #8]
c0d020f2:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d020f4:	60c1      	str	r1, [r0, #12]
c0d020f6:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d020f8:	4629      	mov	r1, r5
c0d020fa:	463a      	mov	r2, r7
c0d020fc:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d020fe:	4633      	mov	r3, r6
c0d02100:	f7ff fd42 	bl	c0d01b88 <find_asset_type>
    find_amount(ch, go_next_p);
c0d02104:	4668      	mov	r0, sp
c0d02106:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d02108:	6001      	str	r1, [r0, #0]
c0d0210a:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0210c:	6041      	str	r1, [r0, #4]
c0d0210e:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02110:	6081      	str	r1, [r0, #8]
c0d02112:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02114:	60c1      	str	r1, [r0, #12]
c0d02116:	6104      	str	r4, [r0, #16]
c0d02118:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d0211a:	6144      	str	r4, [r0, #20]
c0d0211c:	9908      	ldr	r1, [sp, #32]
c0d0211e:	6181      	str	r1, [r0, #24]
c0d02120:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d02122:	4628      	mov	r0, r5
c0d02124:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d02126:	463a      	mov	r2, r7
c0d02128:	4633      	mov	r3, r6
c0d0212a:	f7ff fa73 	bl	c0d01614 <find_amount>
    find_message(ch);
c0d0212e:	4668      	mov	r0, sp
c0d02130:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d02132:	6001      	str	r1, [r0, #0]
c0d02134:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d02136:	6041      	str	r1, [r0, #4]
c0d02138:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d0213a:	6081      	str	r1, [r0, #8]
c0d0213c:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d0213e:	60c1      	str	r1, [r0, #12]
c0d02140:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02142:	6101      	str	r1, [r0, #16]
c0d02144:	6144      	str	r4, [r0, #20]
c0d02146:	4628      	mov	r0, r5
c0d02148:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0214a:	463a      	mov	r2, r7
c0d0214c:	4633      	mov	r3, r6
c0d0214e:	f7ff f9fd 	bl	c0d0154c <find_message>
}
c0d02152:	b013      	add	sp, #76	; 0x4c
c0d02154:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d02158 <build_transfer2_operation>:

short build_transfer2_operation(char *input, int length, transaction *tx){
c0d02158:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0215a:	b08d      	sub	sp, #52	; 0x34
c0d0215c:	4615      	mov	r5, r2
c0d0215e:	2400      	movs	r4, #0
    
    volatile int value_length = 0;
c0d02160:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d02162:	2264      	movs	r2, #100	; 0x64
c0d02164:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d02166:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02168:	9109      	str	r1, [sp, #36]	; 0x24
c0d0216a:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d0216c:	6a2a      	ldr	r2, [r5, #32]
c0d0216e:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d02170:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_transfer2_operation_data(ch, go_next_p);
c0d02172:	466f      	mov	r7, sp
c0d02174:	61bb      	str	r3, [r7, #24]
c0d02176:	617a      	str	r2, [r7, #20]
c0d02178:	463a      	mov	r2, r7
c0d0217a:	3208      	adds	r2, #8
c0d0217c:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d0217e:	4628      	mov	r0, r5
c0d02180:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_transfer2_operation_data(ch, go_next_p);
c0d02182:	6078      	str	r0, [r7, #4]
c0d02184:	a80a      	add	r0, sp, #40	; 0x28
c0d02186:	6038      	str	r0, [r7, #0]
c0d02188:	a90c      	add	r1, sp, #48	; 0x30
c0d0218a:	4a07      	ldr	r2, [pc, #28]	; (c0d021a8 <build_transfer2_operation+0x50>)
c0d0218c:	ab0b      	add	r3, sp, #44	; 0x2c
c0d0218e:	4620      	mov	r0, r4
c0d02190:	f7ff ff5e 	bl	c0d02050 <build_transfer2_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02194:	68e8      	ldr	r0, [r5, #12]
c0d02196:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02198:	1c4a      	adds	r2, r1, #1
c0d0219a:	920a      	str	r2, [sp, #40]	; 0x28
c0d0219c:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d0219e:	6830      	ldr	r0, [r6, #0]
c0d021a0:	b200      	sxth	r0, r0
c0d021a2:	b00d      	add	sp, #52	; 0x34
c0d021a4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021a6:	46c0      	nop			; (mov r8, r8)
c0d021a8:	20001fb8 	.word	0x20001fb8

c0d021ac <build_order_create3_operation_data>:
}

void build_order_create3_operation_data(cache_holder ch, bool *go_next_p){
c0d021ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d021ae:	b093      	sub	sp, #76	; 0x4c
c0d021b0:	9e1c      	ldr	r6, [sp, #112]	; 0x70

    ch.encode[(*(ch.encode_p))++] = 32;
c0d021b2:	6834      	ldr	r4, [r6, #0]
c0d021b4:	1c65      	adds	r5, r4, #1
c0d021b6:	6035      	str	r5, [r6, #0]
c0d021b8:	9f1d      	ldr	r7, [sp, #116]	; 0x74
c0d021ba:	2520      	movs	r5, #32
c0d021bc:	553d      	strb	r5, [r7, r4]
c0d021be:	9d1e      	ldr	r5, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d021c0:	9508      	str	r5, [sp, #32]
c0d021c2:	466c      	mov	r4, sp
c0d021c4:	61a5      	str	r5, [r4, #24]
c0d021c6:	970b      	str	r7, [sp, #44]	; 0x2c
c0d021c8:	6167      	str	r7, [r4, #20]
c0d021ca:	9612      	str	r6, [sp, #72]	; 0x48
c0d021cc:	6126      	str	r6, [r4, #16]
c0d021ce:	9d1b      	ldr	r5, [sp, #108]	; 0x6c
c0d021d0:	950f      	str	r5, [sp, #60]	; 0x3c
c0d021d2:	60e5      	str	r5, [r4, #12]
c0d021d4:	9d1a      	ldr	r5, [sp, #104]	; 0x68
c0d021d6:	9511      	str	r5, [sp, #68]	; 0x44
c0d021d8:	60a5      	str	r5, [r4, #8]
c0d021da:	9d19      	ldr	r5, [sp, #100]	; 0x64
c0d021dc:	462e      	mov	r6, r5
c0d021de:	6065      	str	r5, [r4, #4]
c0d021e0:	9d18      	ldr	r5, [sp, #96]	; 0x60
c0d021e2:	462f      	mov	r7, r5
c0d021e4:	6025      	str	r5, [r4, #0]
c0d021e6:	900a      	str	r0, [sp, #40]	; 0x28
c0d021e8:	910d      	str	r1, [sp, #52]	; 0x34
c0d021ea:	920e      	str	r2, [sp, #56]	; 0x38
c0d021ec:	9310      	str	r3, [sp, #64]	; 0x40
c0d021ee:	f7fe fe35 	bl	c0d00e5c <find_fee>
    while(*go_next_p == false){};
c0d021f2:	9808      	ldr	r0, [sp, #32]
c0d021f4:	7800      	ldrb	r0, [r0, #0]
c0d021f6:	2501      	movs	r5, #1
c0d021f8:	2100      	movs	r1, #0
c0d021fa:	2800      	cmp	r0, #0
c0d021fc:	4628      	mov	r0, r5
c0d021fe:	d000      	beq.n	c0d02202 <build_order_create3_operation_data+0x56>
c0d02200:	4608      	mov	r0, r1
c0d02202:	07c0      	lsls	r0, r0, #31
c0d02204:	4628      	mov	r0, r5
c0d02206:	d1fc      	bne.n	c0d02202 <build_order_create3_operation_data+0x56>
c0d02208:	2000      	movs	r0, #0
c0d0220a:	9c08      	ldr	r4, [sp, #32]
c0d0220c:	9007      	str	r0, [sp, #28]

    *go_next_p = false;
c0d0220e:	7020      	strb	r0, [r4, #0]
    find_creator(ch, go_next_p);
c0d02210:	4668      	mov	r0, sp
c0d02212:	6007      	str	r7, [r0, #0]
c0d02214:	6046      	str	r6, [r0, #4]
c0d02216:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02218:	6081      	str	r1, [r0, #8]
c0d0221a:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d0221c:	60c1      	str	r1, [r0, #12]
c0d0221e:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d02220:	6101      	str	r1, [r0, #16]
c0d02222:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02224:	6141      	str	r1, [r0, #20]
c0d02226:	6184      	str	r4, [r0, #24]
c0d02228:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0222a:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d0222c:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d0222e:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d02230:	f7fe fe5e 	bl	c0d00ef0 <find_creator>
    while(*go_next_p == false){};
c0d02234:	7821      	ldrb	r1, [r4, #0]
c0d02236:	2001      	movs	r0, #1
c0d02238:	2900      	cmp	r1, #0
c0d0223a:	d000      	beq.n	c0d0223e <build_order_create3_operation_data+0x92>
c0d0223c:	9807      	ldr	r0, [sp, #28]
c0d0223e:	07c0      	lsls	r0, r0, #31
c0d02240:	4628      	mov	r0, r5
c0d02242:	d1fc      	bne.n	c0d0223e <build_order_create3_operation_data+0x92>

    find_side(ch);
c0d02244:	4668      	mov	r0, sp
c0d02246:	6007      	str	r7, [r0, #0]
c0d02248:	970c      	str	r7, [sp, #48]	; 0x30
c0d0224a:	6046      	str	r6, [r0, #4]
c0d0224c:	4635      	mov	r5, r6
c0d0224e:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02250:	6081      	str	r1, [r0, #8]
c0d02252:	9c0f      	ldr	r4, [sp, #60]	; 0x3c
c0d02254:	60c4      	str	r4, [r0, #12]
c0d02256:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d02258:	6101      	str	r1, [r0, #16]
c0d0225a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d0225c:	6141      	str	r1, [r0, #20]
c0d0225e:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02260:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d02262:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02264:	9e10      	ldr	r6, [sp, #64]	; 0x40
c0d02266:	4633      	mov	r3, r6
c0d02268:	f7fe ff68 	bl	c0d0113c <find_side>
    find_order_type(ch);
c0d0226c:	4668      	mov	r0, sp
c0d0226e:	6007      	str	r7, [r0, #0]
c0d02270:	462f      	mov	r7, r5
c0d02272:	9709      	str	r7, [sp, #36]	; 0x24
c0d02274:	6047      	str	r7, [r0, #4]
c0d02276:	9d11      	ldr	r5, [sp, #68]	; 0x44
c0d02278:	6085      	str	r5, [r0, #8]
c0d0227a:	60c4      	str	r4, [r0, #12]
c0d0227c:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0227e:	6101      	str	r1, [r0, #16]
c0d02280:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d02282:	6144      	str	r4, [r0, #20]
c0d02284:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02286:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d02288:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d0228a:	4633      	mov	r3, r6
c0d0228c:	f7fe ffa4 	bl	c0d011d8 <find_order_type>
    find_market_name(ch);
c0d02290:	4668      	mov	r0, sp
c0d02292:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d02294:	c0c0      	stmia	r0!, {r6, r7}
c0d02296:	6005      	str	r5, [r0, #0]
c0d02298:	9f0f      	ldr	r7, [sp, #60]	; 0x3c
c0d0229a:	6047      	str	r7, [r0, #4]
c0d0229c:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0229e:	6081      	str	r1, [r0, #8]
c0d022a0:	60c4      	str	r4, [r0, #12]
c0d022a2:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d022a4:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d022a6:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d022a8:	462a      	mov	r2, r5
c0d022aa:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d022ac:	f7fe ffe4 	bl	c0d01278 <find_market_name>
    find_amount(ch, go_next_p);
c0d022b0:	4668      	mov	r0, sp
c0d022b2:	6006      	str	r6, [r0, #0]
c0d022b4:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d022b6:	6041      	str	r1, [r0, #4]
c0d022b8:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d022ba:	6081      	str	r1, [r0, #8]
c0d022bc:	60c7      	str	r7, [r0, #12]
c0d022be:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d022c0:	6101      	str	r1, [r0, #16]
c0d022c2:	6144      	str	r4, [r0, #20]
c0d022c4:	9908      	ldr	r1, [sp, #32]
c0d022c6:	6181      	str	r1, [r0, #24]
c0d022c8:	9f0a      	ldr	r7, [sp, #40]	; 0x28
c0d022ca:	4638      	mov	r0, r7
c0d022cc:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d022ce:	4631      	mov	r1, r6
c0d022d0:	462a      	mov	r2, r5
c0d022d2:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d022d4:	462b      	mov	r3, r5
c0d022d6:	f7ff f99d 	bl	c0d01614 <find_amount>
    find_price(ch);
c0d022da:	4668      	mov	r0, sp
c0d022dc:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d022de:	6001      	str	r1, [r0, #0]
c0d022e0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d022e2:	6041      	str	r1, [r0, #4]
c0d022e4:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d022e6:	6081      	str	r1, [r0, #8]
c0d022e8:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d022ea:	60c1      	str	r1, [r0, #12]
c0d022ec:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d022ee:	6101      	str	r1, [r0, #16]
c0d022f0:	6144      	str	r4, [r0, #20]
c0d022f2:	463c      	mov	r4, r7
c0d022f4:	4620      	mov	r0, r4
c0d022f6:	4631      	mov	r1, r6
c0d022f8:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d022fa:	4632      	mov	r2, r6
c0d022fc:	462b      	mov	r3, r5
c0d022fe:	f7ff fa01 	bl	c0d01704 <find_price>

    find_use_btt_as_fee(ch);
c0d02302:	4668      	mov	r0, sp
c0d02304:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d02306:	6001      	str	r1, [r0, #0]
c0d02308:	9f09      	ldr	r7, [sp, #36]	; 0x24
c0d0230a:	6047      	str	r7, [r0, #4]
c0d0230c:	9d11      	ldr	r5, [sp, #68]	; 0x44
c0d0230e:	6085      	str	r5, [r0, #8]
c0d02310:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02312:	60c1      	str	r1, [r0, #12]
c0d02314:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d02316:	6101      	str	r1, [r0, #16]
c0d02318:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d0231a:	6141      	str	r1, [r0, #20]
c0d0231c:	4620      	mov	r0, r4
c0d0231e:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d02320:	4621      	mov	r1, r4
c0d02322:	4632      	mov	r2, r6
c0d02324:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d02326:	f7ff fa61 	bl	c0d017ec <find_use_btt_as_fee>
    find_freeze_btt_fee(ch);
c0d0232a:	4668      	mov	r0, sp
c0d0232c:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0232e:	c082      	stmia	r0!, {r1, r7}
c0d02330:	6005      	str	r5, [r0, #0]
c0d02332:	9d0f      	ldr	r5, [sp, #60]	; 0x3c
c0d02334:	6045      	str	r5, [r0, #4]
c0d02336:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d02338:	6081      	str	r1, [r0, #8]
c0d0233a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d0233c:	60c1      	str	r1, [r0, #12]
c0d0233e:	9e0a      	ldr	r6, [sp, #40]	; 0x28
c0d02340:	4630      	mov	r0, r6
c0d02342:	4621      	mov	r1, r4
c0d02344:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02346:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d02348:	f7ff fa80 	bl	c0d0184c <find_freeze_btt_fee>
    find_now(ch);
c0d0234c:	4668      	mov	r0, sp
c0d0234e:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d02350:	c082      	stmia	r0!, {r1, r7}
c0d02352:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02354:	6001      	str	r1, [r0, #0]
c0d02356:	6045      	str	r5, [r0, #4]
c0d02358:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0235a:	6081      	str	r1, [r0, #8]
c0d0235c:	9c0b      	ldr	r4, [sp, #44]	; 0x2c
c0d0235e:	60c4      	str	r4, [r0, #12]
c0d02360:	4630      	mov	r0, r6
c0d02362:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d02364:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02366:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d02368:	f7ff fac4 	bl	c0d018f4 <find_now>
    find_expiration(ch);
c0d0236c:	4668      	mov	r0, sp
c0d0236e:	9d0c      	ldr	r5, [sp, #48]	; 0x30
c0d02370:	c0a0      	stmia	r0!, {r5, r7}
c0d02372:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02374:	6001      	str	r1, [r0, #0]
c0d02376:	9f0f      	ldr	r7, [sp, #60]	; 0x3c
c0d02378:	6047      	str	r7, [r0, #4]
c0d0237a:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0237c:	6081      	str	r1, [r0, #8]
c0d0237e:	60c4      	str	r4, [r0, #12]
c0d02380:	4630      	mov	r0, r6
c0d02382:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d02384:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02386:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d02388:	f7ff fae2 	bl	c0d01950 <find_expiration>
    find_custom_btt_fee_rate(ch);
c0d0238c:	4668      	mov	r0, sp
c0d0238e:	6005      	str	r5, [r0, #0]
c0d02390:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d02392:	6041      	str	r1, [r0, #4]
c0d02394:	9d11      	ldr	r5, [sp, #68]	; 0x44
c0d02396:	6085      	str	r5, [r0, #8]
c0d02398:	60c7      	str	r7, [r0, #12]
c0d0239a:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0239c:	6101      	str	r1, [r0, #16]
c0d0239e:	6144      	str	r4, [r0, #20]
c0d023a0:	4630      	mov	r0, r6
c0d023a2:	9f0d      	ldr	r7, [sp, #52]	; 0x34
c0d023a4:	4639      	mov	r1, r7
c0d023a6:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d023a8:	4632      	mov	r2, r6
c0d023aa:	9b10      	ldr	r3, [sp, #64]	; 0x40
c0d023ac:	f7ff fb02 	bl	c0d019b4 <find_custom_btt_fee_rate>
    find_custom_no_btt_fee_rate(ch);
c0d023b0:	4668      	mov	r0, sp
c0d023b2:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d023b4:	6001      	str	r1, [r0, #0]
c0d023b6:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d023b8:	6041      	str	r1, [r0, #4]
c0d023ba:	6085      	str	r5, [r0, #8]
c0d023bc:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d023be:	60c1      	str	r1, [r0, #12]
c0d023c0:	9d12      	ldr	r5, [sp, #72]	; 0x48
c0d023c2:	6105      	str	r5, [r0, #16]
c0d023c4:	6144      	str	r4, [r0, #20]
c0d023c6:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d023c8:	4620      	mov	r0, r4
c0d023ca:	4639      	mov	r1, r7
c0d023cc:	4632      	mov	r2, r6
c0d023ce:	9e10      	ldr	r6, [sp, #64]	; 0x40
c0d023d0:	4633      	mov	r3, r6
c0d023d2:	f7ff fb31 	bl	c0d01a38 <find_custom_no_btt_fee_rate>
    find_money_id(ch);
c0d023d6:	4668      	mov	r0, sp
c0d023d8:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d023da:	6001      	str	r1, [r0, #0]
c0d023dc:	9f09      	ldr	r7, [sp, #36]	; 0x24
c0d023de:	6047      	str	r7, [r0, #4]
c0d023e0:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d023e2:	6081      	str	r1, [r0, #8]
c0d023e4:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d023e6:	60c1      	str	r1, [r0, #12]
c0d023e8:	6105      	str	r5, [r0, #16]
c0d023ea:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d023ec:	6141      	str	r1, [r0, #20]
c0d023ee:	4620      	mov	r0, r4
c0d023f0:	9c0d      	ldr	r4, [sp, #52]	; 0x34
c0d023f2:	4621      	mov	r1, r4
c0d023f4:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d023f6:	462a      	mov	r2, r5
c0d023f8:	4633      	mov	r3, r6
c0d023fa:	f7ff fb61 	bl	c0d01ac0 <find_money_id>
    find_stock_id(ch);
c0d023fe:	4668      	mov	r0, sp
c0d02400:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d02402:	c082      	stmia	r0!, {r1, r7}
c0d02404:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02406:	6001      	str	r1, [r0, #0]
c0d02408:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d0240a:	6041      	str	r1, [r0, #4]
c0d0240c:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0240e:	6081      	str	r1, [r0, #8]
c0d02410:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02412:	60c1      	str	r1, [r0, #12]
c0d02414:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d02416:	4621      	mov	r1, r4
c0d02418:	462a      	mov	r2, r5
c0d0241a:	4633      	mov	r3, r6
c0d0241c:	f7ff fb82 	bl	c0d01b24 <find_stock_id>
}
c0d02420:	b013      	add	sp, #76	; 0x4c
c0d02422:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d02424 <build_order_create3_operation>:

short build_order_create3_operation(char *input, int length, transaction *tx){
c0d02424:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02426:	b08d      	sub	sp, #52	; 0x34
c0d02428:	4615      	mov	r5, r2
c0d0242a:	2400      	movs	r4, #0

    volatile int value_length = 0;
c0d0242c:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d0242e:	2264      	movs	r2, #100	; 0x64
c0d02430:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d02432:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02434:	9109      	str	r1, [sp, #36]	; 0x24
c0d02436:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d02438:	6a2a      	ldr	r2, [r5, #32]
c0d0243a:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d0243c:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_order_create3_operation_data(ch, go_next_p);
c0d0243e:	466f      	mov	r7, sp
c0d02440:	61bb      	str	r3, [r7, #24]
c0d02442:	617a      	str	r2, [r7, #20]
c0d02444:	463a      	mov	r2, r7
c0d02446:	3208      	adds	r2, #8
c0d02448:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d0244a:	4628      	mov	r0, r5
c0d0244c:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_order_create3_operation_data(ch, go_next_p);
c0d0244e:	6078      	str	r0, [r7, #4]
c0d02450:	a80a      	add	r0, sp, #40	; 0x28
c0d02452:	6038      	str	r0, [r7, #0]
c0d02454:	a90c      	add	r1, sp, #48	; 0x30
c0d02456:	4a07      	ldr	r2, [pc, #28]	; (c0d02474 <build_order_create3_operation+0x50>)
c0d02458:	ab0b      	add	r3, sp, #44	; 0x2c
c0d0245a:	4620      	mov	r0, r4
c0d0245c:	f7ff fea6 	bl	c0d021ac <build_order_create3_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02460:	68e8      	ldr	r0, [r5, #12]
c0d02462:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02464:	1c4a      	adds	r2, r1, #1
c0d02466:	920a      	str	r2, [sp, #40]	; 0x28
c0d02468:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d0246a:	6830      	ldr	r0, [r6, #0]
c0d0246c:	b200      	sxth	r0, r0
c0d0246e:	b00d      	add	sp, #52	; 0x34
c0d02470:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02472:	46c0      	nop			; (mov r8, r8)
c0d02474:	20001fb8 	.word	0x20001fb8

c0d02478 <build_order_cancel2_operation_data>:
}

void build_order_cancel2_operation_data(cache_holder ch, bool *go_next_p){
c0d02478:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0247a:	b093      	sub	sp, #76	; 0x4c
c0d0247c:	920f      	str	r2, [sp, #60]	; 0x3c
c0d0247e:	910e      	str	r1, [sp, #56]	; 0x38
c0d02480:	9c1c      	ldr	r4, [sp, #112]	; 0x70
    ch.encode[(*(ch.encode_p))++] = 33;
c0d02482:	6825      	ldr	r5, [r4, #0]
c0d02484:	1c6e      	adds	r6, r5, #1
c0d02486:	6026      	str	r6, [r4, #0]
c0d02488:	9412      	str	r4, [sp, #72]	; 0x48
c0d0248a:	9e1d      	ldr	r6, [sp, #116]	; 0x74
c0d0248c:	9609      	str	r6, [sp, #36]	; 0x24
c0d0248e:	2721      	movs	r7, #33	; 0x21
c0d02490:	5577      	strb	r7, [r6, r5]
c0d02492:	9d1e      	ldr	r5, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d02494:	9508      	str	r5, [sp, #32]
c0d02496:	466f      	mov	r7, sp
c0d02498:	61bd      	str	r5, [r7, #24]
c0d0249a:	617e      	str	r6, [r7, #20]
c0d0249c:	613c      	str	r4, [r7, #16]
c0d0249e:	9c1b      	ldr	r4, [sp, #108]	; 0x6c
c0d024a0:	9411      	str	r4, [sp, #68]	; 0x44
c0d024a2:	60fc      	str	r4, [r7, #12]
c0d024a4:	9c1a      	ldr	r4, [sp, #104]	; 0x68
c0d024a6:	9410      	str	r4, [sp, #64]	; 0x40
c0d024a8:	60bc      	str	r4, [r7, #8]
c0d024aa:	9d19      	ldr	r5, [sp, #100]	; 0x64
c0d024ac:	607d      	str	r5, [r7, #4]
c0d024ae:	950a      	str	r5, [sp, #40]	; 0x28
c0d024b0:	9e18      	ldr	r6, [sp, #96]	; 0x60
c0d024b2:	603e      	str	r6, [r7, #0]
c0d024b4:	960b      	str	r6, [sp, #44]	; 0x2c
c0d024b6:	4604      	mov	r4, r0
c0d024b8:	940d      	str	r4, [sp, #52]	; 0x34
c0d024ba:	461f      	mov	r7, r3
c0d024bc:	970c      	str	r7, [sp, #48]	; 0x30
c0d024be:	f7fe fccd 	bl	c0d00e5c <find_fee>
    find_creator(ch, go_next_p);
c0d024c2:	4668      	mov	r0, sp
c0d024c4:	6006      	str	r6, [r0, #0]
c0d024c6:	6045      	str	r5, [r0, #4]
c0d024c8:	9d10      	ldr	r5, [sp, #64]	; 0x40
c0d024ca:	6085      	str	r5, [r0, #8]
c0d024cc:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d024ce:	60c1      	str	r1, [r0, #12]
c0d024d0:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d024d2:	6101      	str	r1, [r0, #16]
c0d024d4:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d024d6:	6146      	str	r6, [r0, #20]
c0d024d8:	9908      	ldr	r1, [sp, #32]
c0d024da:	6181      	str	r1, [r0, #24]
c0d024dc:	4620      	mov	r0, r4
c0d024de:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d024e0:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d024e2:	463b      	mov	r3, r7
c0d024e4:	f7fe fd04 	bl	c0d00ef0 <find_creator>
    find_market_name(ch);
c0d024e8:	4668      	mov	r0, sp
c0d024ea:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d024ec:	6001      	str	r1, [r0, #0]
c0d024ee:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d024f0:	6044      	str	r4, [r0, #4]
c0d024f2:	6085      	str	r5, [r0, #8]
c0d024f4:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d024f6:	60c1      	str	r1, [r0, #12]
c0d024f8:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d024fa:	6101      	str	r1, [r0, #16]
c0d024fc:	6146      	str	r6, [r0, #20]
c0d024fe:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02500:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d02502:	4629      	mov	r1, r5
c0d02504:	9f0f      	ldr	r7, [sp, #60]	; 0x3c
c0d02506:	463a      	mov	r2, r7
c0d02508:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0250a:	f7fe feb5 	bl	c0d01278 <find_market_name>
    find_order_id(ch);
c0d0250e:	4668      	mov	r0, sp
c0d02510:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d02512:	6006      	str	r6, [r0, #0]
c0d02514:	6044      	str	r4, [r0, #4]
c0d02516:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02518:	6081      	str	r1, [r0, #8]
c0d0251a:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d0251c:	60c1      	str	r1, [r0, #12]
c0d0251e:	9c12      	ldr	r4, [sp, #72]	; 0x48
c0d02520:	6104      	str	r4, [r0, #16]
c0d02522:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d02524:	6141      	str	r1, [r0, #20]
c0d02526:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02528:	4629      	mov	r1, r5
c0d0252a:	463a      	mov	r2, r7
c0d0252c:	9b0c      	ldr	r3, [sp, #48]	; 0x30
c0d0252e:	f7ff fb9b 	bl	c0d01c68 <find_order_id>
    find_money_id(ch);
c0d02532:	4668      	mov	r0, sp
c0d02534:	6006      	str	r6, [r0, #0]
c0d02536:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02538:	6041      	str	r1, [r0, #4]
c0d0253a:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d0253c:	6081      	str	r1, [r0, #8]
c0d0253e:	9f11      	ldr	r7, [sp, #68]	; 0x44
c0d02540:	60c7      	str	r7, [r0, #12]
c0d02542:	6104      	str	r4, [r0, #16]
c0d02544:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d02546:	6144      	str	r4, [r0, #20]
c0d02548:	9d0d      	ldr	r5, [sp, #52]	; 0x34
c0d0254a:	4628      	mov	r0, r5
c0d0254c:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d0254e:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d02550:	9e0c      	ldr	r6, [sp, #48]	; 0x30
c0d02552:	4633      	mov	r3, r6
c0d02554:	f7ff fab4 	bl	c0d01ac0 <find_money_id>
    find_stock_id(ch);
c0d02558:	4668      	mov	r0, sp
c0d0255a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d0255c:	6001      	str	r1, [r0, #0]
c0d0255e:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02560:	6041      	str	r1, [r0, #4]
c0d02562:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02564:	6081      	str	r1, [r0, #8]
c0d02566:	60c7      	str	r7, [r0, #12]
c0d02568:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0256a:	6101      	str	r1, [r0, #16]
c0d0256c:	6144      	str	r4, [r0, #20]
c0d0256e:	4628      	mov	r0, r5
c0d02570:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d02572:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d02574:	4633      	mov	r3, r6
c0d02576:	f7ff fad5 	bl	c0d01b24 <find_stock_id>
}
c0d0257a:	b013      	add	sp, #76	; 0x4c
c0d0257c:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d02580 <build_order_cancel2_operation>:

short build_order_cancel2_operation(char *input, int length, transaction *tx){
c0d02580:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02582:	b08d      	sub	sp, #52	; 0x34
c0d02584:	4615      	mov	r5, r2
c0d02586:	2400      	movs	r4, #0

    volatile int value_length = 0;
c0d02588:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d0258a:	2264      	movs	r2, #100	; 0x64
c0d0258c:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d0258e:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02590:	9109      	str	r1, [sp, #36]	; 0x24
c0d02592:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d02594:	6a2a      	ldr	r2, [r5, #32]
c0d02596:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d02598:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_order_cancel2_operation_data(ch, go_next_p);
c0d0259a:	466f      	mov	r7, sp
c0d0259c:	61bb      	str	r3, [r7, #24]
c0d0259e:	617a      	str	r2, [r7, #20]
c0d025a0:	463a      	mov	r2, r7
c0d025a2:	3208      	adds	r2, #8
c0d025a4:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d025a6:	4628      	mov	r0, r5
c0d025a8:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_order_cancel2_operation_data(ch, go_next_p);
c0d025aa:	6078      	str	r0, [r7, #4]
c0d025ac:	a80a      	add	r0, sp, #40	; 0x28
c0d025ae:	6038      	str	r0, [r7, #0]
c0d025b0:	a90c      	add	r1, sp, #48	; 0x30
c0d025b2:	4a07      	ldr	r2, [pc, #28]	; (c0d025d0 <build_order_cancel2_operation+0x50>)
c0d025b4:	ab0b      	add	r3, sp, #44	; 0x2c
c0d025b6:	4620      	mov	r0, r4
c0d025b8:	f7ff ff5e 	bl	c0d02478 <build_order_cancel2_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d025bc:	68e8      	ldr	r0, [r5, #12]
c0d025be:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d025c0:	1c4a      	adds	r2, r1, #1
c0d025c2:	920a      	str	r2, [sp, #40]	; 0x28
c0d025c4:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d025c6:	6830      	ldr	r0, [r6, #0]
c0d025c8:	b200      	sxth	r0, r0
c0d025ca:	b00d      	add	sp, #52	; 0x34
c0d025cc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d025ce:	46c0      	nop			; (mov r8, r8)
c0d025d0:	20001fb8 	.word	0x20001fb8

c0d025d4 <build_pledge_operation_data>:
}

void build_pledge_operation_data(cache_holder ch, bool *go_next_p){
c0d025d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d025d6:	b093      	sub	sp, #76	; 0x4c
c0d025d8:	930d      	str	r3, [sp, #52]	; 0x34
c0d025da:	920e      	str	r2, [sp, #56]	; 0x38
c0d025dc:	9109      	str	r1, [sp, #36]	; 0x24
c0d025de:	9c1c      	ldr	r4, [sp, #112]	; 0x70
    ch.encode[(*(ch.encode_p))++] = 36;
c0d025e0:	6825      	ldr	r5, [r4, #0]
c0d025e2:	1c6b      	adds	r3, r5, #1
c0d025e4:	6023      	str	r3, [r4, #0]
c0d025e6:	4627      	mov	r7, r4
c0d025e8:	970f      	str	r7, [sp, #60]	; 0x3c
c0d025ea:	9e1d      	ldr	r6, [sp, #116]	; 0x74
c0d025ec:	960b      	str	r6, [sp, #44]	; 0x2c
c0d025ee:	2324      	movs	r3, #36	; 0x24
c0d025f0:	5573      	strb	r3, [r6, r5]
c0d025f2:	9c1e      	ldr	r4, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d025f4:	940c      	str	r4, [sp, #48]	; 0x30
c0d025f6:	466b      	mov	r3, sp
c0d025f8:	619c      	str	r4, [r3, #24]
c0d025fa:	615e      	str	r6, [r3, #20]
c0d025fc:	611f      	str	r7, [r3, #16]
c0d025fe:	9c1b      	ldr	r4, [sp, #108]	; 0x6c
c0d02600:	940a      	str	r4, [sp, #40]	; 0x28
c0d02602:	60dc      	str	r4, [r3, #12]
c0d02604:	9c1a      	ldr	r4, [sp, #104]	; 0x68
c0d02606:	9412      	str	r4, [sp, #72]	; 0x48
c0d02608:	609c      	str	r4, [r3, #8]
c0d0260a:	9d19      	ldr	r5, [sp, #100]	; 0x64
c0d0260c:	605d      	str	r5, [r3, #4]
c0d0260e:	462e      	mov	r6, r5
c0d02610:	9611      	str	r6, [sp, #68]	; 0x44
c0d02612:	9d18      	ldr	r5, [sp, #96]	; 0x60
c0d02614:	601d      	str	r5, [r3, #0]
c0d02616:	9510      	str	r5, [sp, #64]	; 0x40
c0d02618:	4604      	mov	r4, r0
c0d0261a:	9408      	str	r4, [sp, #32]
c0d0261c:	9f0d      	ldr	r7, [sp, #52]	; 0x34
c0d0261e:	463b      	mov	r3, r7
c0d02620:	f7fe fc1c 	bl	c0d00e5c <find_fee>
    find_pledger(ch, go_next_p);
c0d02624:	4668      	mov	r0, sp
c0d02626:	c060      	stmia	r0!, {r5, r6}
c0d02628:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0262a:	6001      	str	r1, [r0, #0]
c0d0262c:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d0262e:	6045      	str	r5, [r0, #4]
c0d02630:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02632:	6081      	str	r1, [r0, #8]
c0d02634:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d02636:	60c6      	str	r6, [r0, #12]
c0d02638:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0263a:	6101      	str	r1, [r0, #16]
c0d0263c:	4620      	mov	r0, r4
c0d0263e:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d02640:	4621      	mov	r1, r4
c0d02642:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02644:	463b      	mov	r3, r7
c0d02646:	f7fe fd17 	bl	c0d01078 <find_pledger>
    find_contract_id(ch);
c0d0264a:	4668      	mov	r0, sp
c0d0264c:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d0264e:	6001      	str	r1, [r0, #0]
c0d02650:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02652:	6041      	str	r1, [r0, #4]
c0d02654:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d02656:	6081      	str	r1, [r0, #8]
c0d02658:	60c5      	str	r5, [r0, #12]
c0d0265a:	9f0f      	ldr	r7, [sp, #60]	; 0x3c
c0d0265c:	6107      	str	r7, [r0, #16]
c0d0265e:	6146      	str	r6, [r0, #20]
c0d02660:	9e08      	ldr	r6, [sp, #32]
c0d02662:	4630      	mov	r0, r6
c0d02664:	4621      	mov	r1, r4
c0d02666:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d02668:	462a      	mov	r2, r5
c0d0266a:	9b0d      	ldr	r3, [sp, #52]	; 0x34
c0d0266c:	f7ff fb48 	bl	c0d01d00 <find_contract_id>
    find_amount(ch, go_next_p);
c0d02670:	4668      	mov	r0, sp
c0d02672:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02674:	6001      	str	r1, [r0, #0]
c0d02676:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02678:	6041      	str	r1, [r0, #4]
c0d0267a:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0267c:	6081      	str	r1, [r0, #8]
c0d0267e:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d02680:	60c4      	str	r4, [r0, #12]
c0d02682:	6107      	str	r7, [r0, #16]
c0d02684:	9f0b      	ldr	r7, [sp, #44]	; 0x2c
c0d02686:	6147      	str	r7, [r0, #20]
c0d02688:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0268a:	6181      	str	r1, [r0, #24]
c0d0268c:	4630      	mov	r0, r6
c0d0268e:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d02690:	4631      	mov	r1, r6
c0d02692:	462a      	mov	r2, r5
c0d02694:	9d0d      	ldr	r5, [sp, #52]	; 0x34
c0d02696:	462b      	mov	r3, r5
c0d02698:	f7fe ffbc 	bl	c0d01614 <find_amount>
    find_asset_type(ch);
c0d0269c:	4668      	mov	r0, sp
c0d0269e:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d026a0:	6001      	str	r1, [r0, #0]
c0d026a2:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d026a4:	6041      	str	r1, [r0, #4]
c0d026a6:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d026a8:	6081      	str	r1, [r0, #8]
c0d026aa:	60c4      	str	r4, [r0, #12]
c0d026ac:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d026ae:	6101      	str	r1, [r0, #16]
c0d026b0:	6147      	str	r7, [r0, #20]
c0d026b2:	9808      	ldr	r0, [sp, #32]
c0d026b4:	4631      	mov	r1, r6
c0d026b6:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d026b8:	462b      	mov	r3, r5
c0d026ba:	f7ff fa65 	bl	c0d01b88 <find_asset_type>
}
c0d026be:	b013      	add	sp, #76	; 0x4c
c0d026c0:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d026c4 <build_pledge_operation>:

short build_pledge_operation(char *input, int length, transaction *tx){
c0d026c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d026c6:	b08d      	sub	sp, #52	; 0x34
c0d026c8:	4615      	mov	r5, r2
c0d026ca:	2400      	movs	r4, #0

    volatile int value_length = 0;
c0d026cc:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d026ce:	2264      	movs	r2, #100	; 0x64
c0d026d0:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d026d2:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d026d4:	9109      	str	r1, [sp, #36]	; 0x24
c0d026d6:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d026d8:	6a2a      	ldr	r2, [r5, #32]
c0d026da:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d026dc:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_pledge_operation_data(ch, go_next_p);
c0d026de:	466f      	mov	r7, sp
c0d026e0:	61bb      	str	r3, [r7, #24]
c0d026e2:	617a      	str	r2, [r7, #20]
c0d026e4:	463a      	mov	r2, r7
c0d026e6:	3208      	adds	r2, #8
c0d026e8:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d026ea:	4628      	mov	r0, r5
c0d026ec:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_pledge_operation_data(ch, go_next_p);
c0d026ee:	6078      	str	r0, [r7, #4]
c0d026f0:	a80a      	add	r0, sp, #40	; 0x28
c0d026f2:	6038      	str	r0, [r7, #0]
c0d026f4:	a90c      	add	r1, sp, #48	; 0x30
c0d026f6:	4a07      	ldr	r2, [pc, #28]	; (c0d02714 <build_pledge_operation+0x50>)
c0d026f8:	ab0b      	add	r3, sp, #44	; 0x2c
c0d026fa:	4620      	mov	r0, r4
c0d026fc:	f7ff ff6a 	bl	c0d025d4 <build_pledge_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02700:	68e8      	ldr	r0, [r5, #12]
c0d02702:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02704:	1c4a      	adds	r2, r1, #1
c0d02706:	920a      	str	r2, [sp, #40]	; 0x28
c0d02708:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d0270a:	6830      	ldr	r0, [r6, #0]
c0d0270c:	b200      	sxth	r0, r0
c0d0270e:	b00d      	add	sp, #52	; 0x34
c0d02710:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02712:	46c0      	nop			; (mov r8, r8)
c0d02714:	20001fb8 	.word	0x20001fb8

c0d02718 <build_redeem_operation_data>:
}

void build_redeem_operation_data(cache_holder ch, bool *go_next_p){
c0d02718:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0271a:	b093      	sub	sp, #76	; 0x4c
c0d0271c:	930d      	str	r3, [sp, #52]	; 0x34
c0d0271e:	920e      	str	r2, [sp, #56]	; 0x38
c0d02720:	9109      	str	r1, [sp, #36]	; 0x24
c0d02722:	9c1c      	ldr	r4, [sp, #112]	; 0x70

    ch.encode[(*(ch.encode_p))++] = 37;
c0d02724:	6825      	ldr	r5, [r4, #0]
c0d02726:	1c6b      	adds	r3, r5, #1
c0d02728:	6023      	str	r3, [r4, #0]
c0d0272a:	4627      	mov	r7, r4
c0d0272c:	970f      	str	r7, [sp, #60]	; 0x3c
c0d0272e:	9e1d      	ldr	r6, [sp, #116]	; 0x74
c0d02730:	960b      	str	r6, [sp, #44]	; 0x2c
c0d02732:	2325      	movs	r3, #37	; 0x25
c0d02734:	5573      	strb	r3, [r6, r5]
c0d02736:	9c1e      	ldr	r4, [sp, #120]	; 0x78

    find_fee(ch, go_next_p);
c0d02738:	940c      	str	r4, [sp, #48]	; 0x30
c0d0273a:	466b      	mov	r3, sp
c0d0273c:	619c      	str	r4, [r3, #24]
c0d0273e:	615e      	str	r6, [r3, #20]
c0d02740:	611f      	str	r7, [r3, #16]
c0d02742:	9c1b      	ldr	r4, [sp, #108]	; 0x6c
c0d02744:	940a      	str	r4, [sp, #40]	; 0x28
c0d02746:	60dc      	str	r4, [r3, #12]
c0d02748:	9c1a      	ldr	r4, [sp, #104]	; 0x68
c0d0274a:	9412      	str	r4, [sp, #72]	; 0x48
c0d0274c:	609c      	str	r4, [r3, #8]
c0d0274e:	9d19      	ldr	r5, [sp, #100]	; 0x64
c0d02750:	605d      	str	r5, [r3, #4]
c0d02752:	462e      	mov	r6, r5
c0d02754:	9611      	str	r6, [sp, #68]	; 0x44
c0d02756:	9d18      	ldr	r5, [sp, #96]	; 0x60
c0d02758:	601d      	str	r5, [r3, #0]
c0d0275a:	9510      	str	r5, [sp, #64]	; 0x40
c0d0275c:	4604      	mov	r4, r0
c0d0275e:	9408      	str	r4, [sp, #32]
c0d02760:	9f0d      	ldr	r7, [sp, #52]	; 0x34
c0d02762:	463b      	mov	r3, r7
c0d02764:	f7fe fb7a 	bl	c0d00e5c <find_fee>
    find_pledger(ch, go_next_p);
c0d02768:	4668      	mov	r0, sp
c0d0276a:	c060      	stmia	r0!, {r5, r6}
c0d0276c:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0276e:	6001      	str	r1, [r0, #0]
c0d02770:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d02772:	6045      	str	r5, [r0, #4]
c0d02774:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02776:	6081      	str	r1, [r0, #8]
c0d02778:	9e0b      	ldr	r6, [sp, #44]	; 0x2c
c0d0277a:	60c6      	str	r6, [r0, #12]
c0d0277c:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0277e:	6101      	str	r1, [r0, #16]
c0d02780:	4620      	mov	r0, r4
c0d02782:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d02784:	4621      	mov	r1, r4
c0d02786:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02788:	463b      	mov	r3, r7
c0d0278a:	f7fe fc75 	bl	c0d01078 <find_pledger>
    find_contract_id(ch);
c0d0278e:	4668      	mov	r0, sp
c0d02790:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02792:	6001      	str	r1, [r0, #0]
c0d02794:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d02796:	6041      	str	r1, [r0, #4]
c0d02798:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d0279a:	6081      	str	r1, [r0, #8]
c0d0279c:	60c5      	str	r5, [r0, #12]
c0d0279e:	9f0f      	ldr	r7, [sp, #60]	; 0x3c
c0d027a0:	6107      	str	r7, [r0, #16]
c0d027a2:	6146      	str	r6, [r0, #20]
c0d027a4:	9e08      	ldr	r6, [sp, #32]
c0d027a6:	4630      	mov	r0, r6
c0d027a8:	4621      	mov	r1, r4
c0d027aa:	9d0e      	ldr	r5, [sp, #56]	; 0x38
c0d027ac:	462a      	mov	r2, r5
c0d027ae:	9b0d      	ldr	r3, [sp, #52]	; 0x34
c0d027b0:	f7ff faa6 	bl	c0d01d00 <find_contract_id>
    find_amount(ch, go_next_p);
c0d027b4:	4668      	mov	r0, sp
c0d027b6:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d027b8:	6001      	str	r1, [r0, #0]
c0d027ba:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d027bc:	6041      	str	r1, [r0, #4]
c0d027be:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d027c0:	6081      	str	r1, [r0, #8]
c0d027c2:	9c0a      	ldr	r4, [sp, #40]	; 0x28
c0d027c4:	60c4      	str	r4, [r0, #12]
c0d027c6:	6107      	str	r7, [r0, #16]
c0d027c8:	9f0b      	ldr	r7, [sp, #44]	; 0x2c
c0d027ca:	6147      	str	r7, [r0, #20]
c0d027cc:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d027ce:	6181      	str	r1, [r0, #24]
c0d027d0:	4630      	mov	r0, r6
c0d027d2:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0d027d4:	4631      	mov	r1, r6
c0d027d6:	462a      	mov	r2, r5
c0d027d8:	9d0d      	ldr	r5, [sp, #52]	; 0x34
c0d027da:	462b      	mov	r3, r5
c0d027dc:	f7fe ff1a 	bl	c0d01614 <find_amount>
    find_asset_type(ch);
c0d027e0:	4668      	mov	r0, sp
c0d027e2:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d027e4:	6001      	str	r1, [r0, #0]
c0d027e6:	9911      	ldr	r1, [sp, #68]	; 0x44
c0d027e8:	6041      	str	r1, [r0, #4]
c0d027ea:	9912      	ldr	r1, [sp, #72]	; 0x48
c0d027ec:	6081      	str	r1, [r0, #8]
c0d027ee:	60c4      	str	r4, [r0, #12]
c0d027f0:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d027f2:	6101      	str	r1, [r0, #16]
c0d027f4:	6147      	str	r7, [r0, #20]
c0d027f6:	9808      	ldr	r0, [sp, #32]
c0d027f8:	4631      	mov	r1, r6
c0d027fa:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d027fc:	462b      	mov	r3, r5
c0d027fe:	f7ff f9c3 	bl	c0d01b88 <find_asset_type>

}
c0d02802:	b013      	add	sp, #76	; 0x4c
c0d02804:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d02808 <build_redeem_operation>:

short build_redeem_operation(char *input, int length, transaction *tx){
c0d02808:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0280a:	b08d      	sub	sp, #52	; 0x34
c0d0280c:	4615      	mov	r5, r2
c0d0280e:	2400      	movs	r4, #0

    volatile int value_length = 0;
c0d02810:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d02812:	2264      	movs	r2, #100	; 0x64
c0d02814:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d02816:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02818:	9109      	str	r1, [sp, #36]	; 0x24
c0d0281a:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d0281c:	6a2a      	ldr	r2, [r5, #32]
c0d0281e:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d02820:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_redeem_operation_data(ch, go_next_p);
c0d02822:	466f      	mov	r7, sp
c0d02824:	61bb      	str	r3, [r7, #24]
c0d02826:	617a      	str	r2, [r7, #20]
c0d02828:	463a      	mov	r2, r7
c0d0282a:	3208      	adds	r2, #8
c0d0282c:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d0282e:	4628      	mov	r0, r5
c0d02830:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_redeem_operation_data(ch, go_next_p);
c0d02832:	6078      	str	r0, [r7, #4]
c0d02834:	a80a      	add	r0, sp, #40	; 0x28
c0d02836:	6038      	str	r0, [r7, #0]
c0d02838:	a90c      	add	r1, sp, #48	; 0x30
c0d0283a:	4a07      	ldr	r2, [pc, #28]	; (c0d02858 <build_redeem_operation+0x50>)
c0d0283c:	ab0b      	add	r3, sp, #44	; 0x2c
c0d0283e:	4620      	mov	r0, r4
c0d02840:	f7ff ff6a 	bl	c0d02718 <build_redeem_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02844:	68e8      	ldr	r0, [r5, #12]
c0d02846:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02848:	1c4a      	adds	r2, r1, #1
c0d0284a:	920a      	str	r2, [sp, #40]	; 0x28
c0d0284c:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d0284e:	6830      	ldr	r0, [r6, #0]
c0d02850:	b200      	sxth	r0, r0
c0d02852:	b00d      	add	sp, #52	; 0x34
c0d02854:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02856:	46c0      	nop			; (mov r8, r8)
c0d02858:	20001fb8 	.word	0x20001fb8

c0d0285c <build_torrent_payment_refund_operation_data>:
}

void build_torrent_payment_refund_operation_data(cache_holder ch, bool *go_next_p){
c0d0285c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0285e:	b08f      	sub	sp, #60	; 0x3c
c0d02860:	ac0a      	add	r4, sp, #40	; 0x28
c0d02862:	c407      	stmia	r4!, {r0, r1, r2}
c0d02864:	9c18      	ldr	r4, [sp, #96]	; 0x60
    ch.encode[(*(ch.encode_p))++] = 47;
c0d02866:	6826      	ldr	r6, [r4, #0]
c0d02868:	1c75      	adds	r5, r6, #1
c0d0286a:	6025      	str	r5, [r4, #0]
c0d0286c:	9f19      	ldr	r7, [sp, #100]	; 0x64
c0d0286e:	252f      	movs	r5, #47	; 0x2f
c0d02870:	55bd      	strb	r5, [r7, r6]
c0d02872:	463d      	mov	r5, r7

    find_fee(ch, go_next_p);
c0d02874:	950e      	str	r5, [sp, #56]	; 0x38
c0d02876:	9e1a      	ldr	r6, [sp, #104]	; 0x68
c0d02878:	9608      	str	r6, [sp, #32]
c0d0287a:	466f      	mov	r7, sp
c0d0287c:	61be      	str	r6, [r7, #24]
c0d0287e:	617d      	str	r5, [r7, #20]
c0d02880:	613c      	str	r4, [r7, #16]
c0d02882:	9d17      	ldr	r5, [sp, #92]	; 0x5c
c0d02884:	950d      	str	r5, [sp, #52]	; 0x34
c0d02886:	60fd      	str	r5, [r7, #12]
c0d02888:	9d16      	ldr	r5, [sp, #88]	; 0x58
c0d0288a:	9509      	str	r5, [sp, #36]	; 0x24
c0d0288c:	60bd      	str	r5, [r7, #8]
c0d0288e:	9e15      	ldr	r6, [sp, #84]	; 0x54
c0d02890:	607e      	str	r6, [r7, #4]
c0d02892:	9d14      	ldr	r5, [sp, #80]	; 0x50
c0d02894:	603d      	str	r5, [r7, #0]
c0d02896:	461f      	mov	r7, r3
c0d02898:	f7fe fae0 	bl	c0d00e5c <find_fee>
    find_payment_id(ch);
c0d0289c:	4668      	mov	r0, sp
c0d0289e:	c060      	stmia	r0!, {r5, r6}
c0d028a0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d028a2:	6001      	str	r1, [r0, #0]
c0d028a4:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d028a6:	6041      	str	r1, [r0, #4]
c0d028a8:	6084      	str	r4, [r0, #8]
c0d028aa:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d028ac:	60c1      	str	r1, [r0, #12]
c0d028ae:	aa0a      	add	r2, sp, #40	; 0x28
c0d028b0:	ca07      	ldmia	r2, {r0, r1, r2}
c0d028b2:	463b      	mov	r3, r7
c0d028b4:	f7ff f9fe 	bl	c0d01cb4 <find_payment_id>
    find_creator(ch, go_next_p);
c0d028b8:	4668      	mov	r0, sp
c0d028ba:	c060      	stmia	r0!, {r5, r6}
c0d028bc:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d028be:	6001      	str	r1, [r0, #0]
c0d028c0:	990d      	ldr	r1, [sp, #52]	; 0x34
c0d028c2:	6041      	str	r1, [r0, #4]
c0d028c4:	6084      	str	r4, [r0, #8]
c0d028c6:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d028c8:	60c1      	str	r1, [r0, #12]
c0d028ca:	9908      	ldr	r1, [sp, #32]
c0d028cc:	6101      	str	r1, [r0, #16]
c0d028ce:	aa0a      	add	r2, sp, #40	; 0x28
c0d028d0:	ca07      	ldmia	r2, {r0, r1, r2}
c0d028d2:	463b      	mov	r3, r7
c0d028d4:	f7fe fb0c 	bl	c0d00ef0 <find_creator>
}
c0d028d8:	b00f      	add	sp, #60	; 0x3c
c0d028da:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d028dc <build_torrent_payment_refund_operation>:

short build_torrent_payment_refund_operation(char *input, int length, transaction *tx){
c0d028dc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d028de:	b08d      	sub	sp, #52	; 0x34
c0d028e0:	4615      	mov	r5, r2
c0d028e2:	2400      	movs	r4, #0
    
    volatile int value_length = 0;
c0d028e4:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d028e6:	2264      	movs	r2, #100	; 0x64
c0d028e8:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d028ea:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d028ec:	9109      	str	r1, [sp, #36]	; 0x24
c0d028ee:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d028f0:	6a2a      	ldr	r2, [r5, #32]
c0d028f2:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d028f4:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_torrent_payment_refund_operation_data(ch, go_next_p);
c0d028f6:	466f      	mov	r7, sp
c0d028f8:	61bb      	str	r3, [r7, #24]
c0d028fa:	617a      	str	r2, [r7, #20]
c0d028fc:	463a      	mov	r2, r7
c0d028fe:	3208      	adds	r2, #8
c0d02900:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02902:	4628      	mov	r0, r5
c0d02904:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_torrent_payment_refund_operation_data(ch, go_next_p);
c0d02906:	6078      	str	r0, [r7, #4]
c0d02908:	a80a      	add	r0, sp, #40	; 0x28
c0d0290a:	6038      	str	r0, [r7, #0]
c0d0290c:	a90c      	add	r1, sp, #48	; 0x30
c0d0290e:	4a07      	ldr	r2, [pc, #28]	; (c0d0292c <build_torrent_payment_refund_operation+0x50>)
c0d02910:	ab0b      	add	r3, sp, #44	; 0x2c
c0d02912:	4620      	mov	r0, r4
c0d02914:	f7ff ffa2 	bl	c0d0285c <build_torrent_payment_refund_operation_data>

    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02918:	68e8      	ldr	r0, [r5, #12]
c0d0291a:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0291c:	1c4a      	adds	r2, r1, #1
c0d0291e:	920a      	str	r2, [sp, #40]	; 0x28
c0d02920:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d02922:	6830      	ldr	r0, [r6, #0]
c0d02924:	b200      	sxth	r0, r0
c0d02926:	b00d      	add	sp, #52	; 0x34
c0d02928:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0292a:	46c0      	nop			; (mov r8, r8)
c0d0292c:	20001fb8 	.word	0x20001fb8

c0d02930 <build_proposal_operation_data>:
}

void build_proposal_operation_data(cache_holder ch, bool *go_next_p){
c0d02930:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02932:	b095      	sub	sp, #84	; 0x54
c0d02934:	9309      	str	r3, [sp, #36]	; 0x24
c0d02936:	4615      	mov	r5, r2
c0d02938:	9110      	str	r1, [sp, #64]	; 0x40
c0d0293a:	900d      	str	r0, [sp, #52]	; 0x34
c0d0293c:	9b1e      	ldr	r3, [sp, #120]	; 0x78
    ch.encode[(*(ch.encode_p))++] = 18;
c0d0293e:	681a      	ldr	r2, [r3, #0]
c0d02940:	1c54      	adds	r4, r2, #1
c0d02942:	601c      	str	r4, [r3, #0]
c0d02944:	461e      	mov	r6, r3
c0d02946:	960f      	str	r6, [sp, #60]	; 0x3c
c0d02948:	9b1f      	ldr	r3, [sp, #124]	; 0x7c
c0d0294a:	930c      	str	r3, [sp, #48]	; 0x30
c0d0294c:	2412      	movs	r4, #18
c0d0294e:	549c      	strb	r4, [r3, r2]
c0d02950:	9a20      	ldr	r2, [sp, #128]	; 0x80

    find_fee(ch, go_next_p);
c0d02952:	9208      	str	r2, [sp, #32]
c0d02954:	466c      	mov	r4, sp
c0d02956:	61a2      	str	r2, [r4, #24]
c0d02958:	6163      	str	r3, [r4, #20]
c0d0295a:	6126      	str	r6, [r4, #16]
c0d0295c:	9a1d      	ldr	r2, [sp, #116]	; 0x74
c0d0295e:	920e      	str	r2, [sp, #56]	; 0x38
c0d02960:	60e2      	str	r2, [r4, #12]
c0d02962:	9f1c      	ldr	r7, [sp, #112]	; 0x70
c0d02964:	60a7      	str	r7, [r4, #8]
c0d02966:	9e1b      	ldr	r6, [sp, #108]	; 0x6c
c0d02968:	6066      	str	r6, [r4, #4]
c0d0296a:	960b      	str	r6, [sp, #44]	; 0x2c
c0d0296c:	9a1a      	ldr	r2, [sp, #104]	; 0x68
c0d0296e:	6022      	str	r2, [r4, #0]
c0d02970:	4614      	mov	r4, r2
c0d02972:	940a      	str	r4, [sp, #40]	; 0x28
c0d02974:	462a      	mov	r2, r5
c0d02976:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d02978:	f7fe fa70 	bl	c0d00e5c <find_fee>
    find_proposaler(ch, go_next_p);
c0d0297c:	4668      	mov	r0, sp
c0d0297e:	c0d0      	stmia	r0!, {r4, r6, r7}
c0d02980:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d02982:	6001      	str	r1, [r0, #0]
c0d02984:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02986:	6041      	str	r1, [r0, #4]
c0d02988:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d0298a:	6081      	str	r1, [r0, #8]
c0d0298c:	9908      	ldr	r1, [sp, #32]
c0d0298e:	60c1      	str	r1, [r0, #12]
c0d02990:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d02992:	4630      	mov	r0, r6
c0d02994:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02996:	462a      	mov	r2, r5
c0d02998:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d0299a:	4623      	mov	r3, r4
c0d0299c:	f7fe fb0a 	bl	c0d00fb4 <find_proposaler>
    find_expiration(ch);
c0d029a0:	4668      	mov	r0, sp
c0d029a2:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d029a4:	6001      	str	r1, [r0, #0]
c0d029a6:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d029a8:	6041      	str	r1, [r0, #4]
c0d029aa:	6087      	str	r7, [r0, #8]
c0d029ac:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d029ae:	60c1      	str	r1, [r0, #12]
c0d029b0:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d029b2:	6101      	str	r1, [r0, #16]
c0d029b4:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d029b6:	6141      	str	r1, [r0, #20]
c0d029b8:	4630      	mov	r0, r6
c0d029ba:	9e10      	ldr	r6, [sp, #64]	; 0x40
c0d029bc:	4631      	mov	r1, r6
c0d029be:	462a      	mov	r2, r5
c0d029c0:	4623      	mov	r3, r4
c0d029c2:	f7fe ffc5 	bl	c0d01950 <find_expiration>
    find_proposed_ops(ch, go_next_p);
c0d029c6:	4668      	mov	r0, sp
c0d029c8:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d029ca:	6001      	str	r1, [r0, #0]
c0d029cc:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d029ce:	6041      	str	r1, [r0, #4]
c0d029d0:	6087      	str	r7, [r0, #8]
c0d029d2:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d029d4:	60c1      	str	r1, [r0, #12]
c0d029d6:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d029d8:	6101      	str	r1, [r0, #16]
c0d029da:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d029dc:	6141      	str	r1, [r0, #20]
c0d029de:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d029e0:	4631      	mov	r1, r6
c0d029e2:	462a      	mov	r2, r5
c0d029e4:	4623      	mov	r3, r4
c0d029e6:	f7ff f9b1 	bl	c0d01d4c <find_proposed_ops>
c0d029ea:	2600      	movs	r6, #0
    
    volatile int ops_i = 0;
c0d029ec:	9614      	str	r6, [sp, #80]	; 0x50
    volatile int i = 0;
c0d029ee:	9613      	str	r6, [sp, #76]	; 0x4c
    volatile int find_info_delimiter_cache = find_info_delimiter;
c0d029f0:	4855      	ldr	r0, [pc, #340]	; (c0d02b48 <build_proposal_operation_data+0x218>)
c0d029f2:	6800      	ldr	r0, [r0, #0]
c0d029f4:	9012      	str	r0, [sp, #72]	; 0x48
    volatile int id;

    // find_ops :

        id = 0;
c0d029f6:	9611      	str	r6, [sp, #68]	; 0x44
        for(; i < proposed_ops_array_size; i++){
c0d029f8:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d029fa:	4954      	ldr	r1, [pc, #336]	; (c0d02b4c <build_proposal_operation_data+0x21c>)
c0d029fc:	6809      	ldr	r1, [r1, #0]
c0d029fe:	4288      	cmp	r0, r1
c0d02a00:	da39      	bge.n	c0d02a76 <build_proposal_operation_data+0x146>
c0d02a02:	a453      	add	r4, pc, #332	; (adr r4, c0d02b50 <build_proposal_operation_data+0x220>)
c0d02a04:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02a06:	9b0d      	ldr	r3, [sp, #52]	; 0x34
c0d02a08:	9814      	ldr	r0, [sp, #80]	; 0x50
c0d02a0a:	680a      	ldr	r2, [r1, #0]
c0d02a0c:	4290      	cmp	r0, r2
c0d02a0e:	dc29      	bgt.n	c0d02a64 <build_proposal_operation_data+0x134>
            
            while(ops_i < (*(ch.value_length)) + 1){

                if(ch.input[find_info_delimiter_cache + ops_i] == '}'){
c0d02a10:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d02a12:	9a14      	ldr	r2, [sp, #80]	; 0x50
c0d02a14:	1810      	adds	r0, r2, r0
c0d02a16:	5c38      	ldrb	r0, [r7, r0]
c0d02a18:	287d      	cmp	r0, #125	; 0x7d
c0d02a1a:	d11f      	bne.n	c0d02a5c <build_proposal_operation_data+0x12c>

                    ch.flag = "id";
                    int pre_str_size = 2;
                    int op_length = find_data_processor(ch.cache, ch.flag, ch.input, ops_i, pre_str_size, ch.operation, true);
c0d02a1c:	9b14      	ldr	r3, [sp, #80]	; 0x50
c0d02a1e:	2001      	movs	r0, #1
c0d02a20:	4669      	mov	r1, sp
c0d02a22:	6088      	str	r0, [r1, #8]
c0d02a24:	2002      	movs	r0, #2
c0d02a26:	6008      	str	r0, [r1, #0]
c0d02a28:	4628      	mov	r0, r5
c0d02a2a:	4621      	mov	r1, r4
c0d02a2c:	463a      	mov	r2, r7
c0d02a2e:	f7fe f94b 	bl	c0d00cc8 <find_data_processor>
c0d02a32:	4630      	mov	r0, r6
c0d02a34:	4631      	mov	r1, r6
}

int get_id(char *value, int length){
    int id = 0;
    for(int z = 0; z < length; z++){
        id = id * 10;
c0d02a36:	220a      	movs	r2, #10
c0d02a38:	434a      	muls	r2, r1
        id += (value[z] - 48);
c0d02a3a:	1a29      	subs	r1, r5, r0
c0d02a3c:	7809      	ldrb	r1, [r1, #0]
c0d02a3e:	1851      	adds	r1, r2, r1
c0d02a40:	3930      	subs	r1, #48	; 0x30
    }
}

int get_id(char *value, int length){
    int id = 0;
    for(int z = 0; z < length; z++){
c0d02a42:	1e40      	subs	r0, r0, #1
c0d02a44:	4602      	mov	r2, r0
c0d02a46:	3202      	adds	r2, #2
c0d02a48:	d1f5      	bne.n	c0d02a36 <build_proposal_operation_data+0x106>
                if(ch.input[find_info_delimiter_cache + ops_i] == '}'){

                    ch.flag = "id";
                    int pre_str_size = 2;
                    int op_length = find_data_processor(ch.cache, ch.flag, ch.input, ops_i, pre_str_size, ch.operation, true);
                    id = get_id(ch.cache, 2);
c0d02a4a:	9111      	str	r1, [sp, #68]	; 0x44

                    i++;
c0d02a4c:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d02a4e:	1c40      	adds	r0, r0, #1
c0d02a50:	9013      	str	r0, [sp, #76]	; 0x4c
                    ops_i++;
c0d02a52:	9814      	ldr	r0, [sp, #80]	; 0x50
c0d02a54:	1c40      	adds	r0, r0, #1
c0d02a56:	9014      	str	r0, [sp, #80]	; 0x50
c0d02a58:	4623      	mov	r3, r4
c0d02a5a:	9910      	ldr	r1, [sp, #64]	; 0x40
                    //         break;    
                    // }

                    
                }
                ops_i++;
c0d02a5c:	9814      	ldr	r0, [sp, #80]	; 0x50
c0d02a5e:	1c40      	adds	r0, r0, #1
c0d02a60:	9014      	str	r0, [sp, #80]	; 0x50
c0d02a62:	e7d1      	b.n	c0d02a08 <build_proposal_operation_data+0xd8>
    volatile int id;

    // find_ops :

        id = 0;
        for(; i < proposed_ops_array_size; i++){
c0d02a64:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d02a66:	1c40      	adds	r0, r0, #1
c0d02a68:	9013      	str	r0, [sp, #76]	; 0x4c
c0d02a6a:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d02a6c:	4a37      	ldr	r2, [pc, #220]	; (c0d02b4c <build_proposal_operation_data+0x21c>)
c0d02a6e:	6812      	ldr	r2, [r2, #0]
c0d02a70:	4290      	cmp	r0, r2
c0d02a72:	dbc9      	blt.n	c0d02a08 <build_proposal_operation_data+0xd8>
c0d02a74:	e001      	b.n	c0d02a7a <build_proposal_operation_data+0x14a>
c0d02a76:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02a78:	9b0d      	ldr	r3, [sp, #52]	; 0x34
            }
        }

        // found_ops:

            if(id == 4){
c0d02a7a:	9811      	ldr	r0, [sp, #68]	; 0x44
c0d02a7c:	2804      	cmp	r0, #4
c0d02a7e:	d161      	bne.n	c0d02b44 <build_proposal_operation_data+0x214>
c0d02a80:	9e0f      	ldr	r6, [sp, #60]	; 0x3c
                // build_withdraw_operation_data(ch, go_next_p);
                
                ch.encode[(*(ch.encode_p))++] = 4;
c0d02a82:	6830      	ldr	r0, [r6, #0]
c0d02a84:	1c42      	adds	r2, r0, #1
c0d02a86:	6032      	str	r2, [r6, #0]
c0d02a88:	2204      	movs	r2, #4
c0d02a8a:	9c0c      	ldr	r4, [sp, #48]	; 0x30
c0d02a8c:	5422      	strb	r2, [r4, r0]

                find_fee(ch, go_next_p);
c0d02a8e:	4668      	mov	r0, sp
c0d02a90:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d02a92:	6002      	str	r2, [r0, #0]
c0d02a94:	9a0b      	ldr	r2, [sp, #44]	; 0x2c
c0d02a96:	6042      	str	r2, [r0, #4]
c0d02a98:	6087      	str	r7, [r0, #8]
c0d02a9a:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d02a9c:	60c2      	str	r2, [r0, #12]
c0d02a9e:	6106      	str	r6, [r0, #16]
c0d02aa0:	6144      	str	r4, [r0, #20]
c0d02aa2:	9a08      	ldr	r2, [sp, #32]
c0d02aa4:	6182      	str	r2, [r0, #24]
c0d02aa6:	4618      	mov	r0, r3
c0d02aa8:	462a      	mov	r2, r5
c0d02aaa:	930d      	str	r3, [sp, #52]	; 0x34
c0d02aac:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d02aae:	f7fe f9d5 	bl	c0d00e5c <find_fee>
                find_from(ch);
c0d02ab2:	4668      	mov	r0, sp
c0d02ab4:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02ab6:	6001      	str	r1, [r0, #0]
c0d02ab8:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02aba:	6041      	str	r1, [r0, #4]
c0d02abc:	6087      	str	r7, [r0, #8]
c0d02abe:	9e0e      	ldr	r6, [sp, #56]	; 0x38
c0d02ac0:	60c6      	str	r6, [r0, #12]
c0d02ac2:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02ac4:	6101      	str	r1, [r0, #16]
c0d02ac6:	6144      	str	r4, [r0, #20]
c0d02ac8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02aca:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02acc:	462a      	mov	r2, r5
c0d02ace:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d02ad0:	f7fe fc2e 	bl	c0d01330 <find_from>
                find_to_external_address(ch);
c0d02ad4:	4668      	mov	r0, sp
c0d02ad6:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02ad8:	6001      	str	r1, [r0, #0]
c0d02ada:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02adc:	6041      	str	r1, [r0, #4]
c0d02ade:	6087      	str	r7, [r0, #8]
c0d02ae0:	60c6      	str	r6, [r0, #12]
c0d02ae2:	9e0f      	ldr	r6, [sp, #60]	; 0x3c
c0d02ae4:	6106      	str	r6, [r0, #16]
c0d02ae6:	6144      	str	r4, [r0, #20]
c0d02ae8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d02aea:	9c10      	ldr	r4, [sp, #64]	; 0x40
c0d02aec:	4621      	mov	r1, r4
c0d02aee:	462a      	mov	r2, r5
c0d02af0:	9b09      	ldr	r3, [sp, #36]	; 0x24
c0d02af2:	f7fe fccb 	bl	c0d0148c <find_to_external_address>
                find_asset_type(ch);
c0d02af6:	4668      	mov	r0, sp
c0d02af8:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02afa:	6001      	str	r1, [r0, #0]
c0d02afc:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02afe:	6041      	str	r1, [r0, #4]
c0d02b00:	6087      	str	r7, [r0, #8]
c0d02b02:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d02b04:	60c1      	str	r1, [r0, #12]
c0d02b06:	6106      	str	r6, [r0, #16]
c0d02b08:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d02b0a:	6141      	str	r1, [r0, #20]
c0d02b0c:	9e0d      	ldr	r6, [sp, #52]	; 0x34
c0d02b0e:	4630      	mov	r0, r6
c0d02b10:	4621      	mov	r1, r4
c0d02b12:	462a      	mov	r2, r5
c0d02b14:	9c09      	ldr	r4, [sp, #36]	; 0x24
c0d02b16:	4623      	mov	r3, r4
c0d02b18:	f7ff f836 	bl	c0d01b88 <find_asset_type>
                find_amount(ch, go_next_p);
c0d02b1c:	4668      	mov	r0, sp
c0d02b1e:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02b20:	6001      	str	r1, [r0, #0]
c0d02b22:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d02b24:	6041      	str	r1, [r0, #4]
c0d02b26:	6087      	str	r7, [r0, #8]
c0d02b28:	990e      	ldr	r1, [sp, #56]	; 0x38
c0d02b2a:	60c1      	str	r1, [r0, #12]
c0d02b2c:	990f      	ldr	r1, [sp, #60]	; 0x3c
c0d02b2e:	6101      	str	r1, [r0, #16]
c0d02b30:	990c      	ldr	r1, [sp, #48]	; 0x30
c0d02b32:	6141      	str	r1, [r0, #20]
c0d02b34:	9908      	ldr	r1, [sp, #32]
c0d02b36:	6181      	str	r1, [r0, #24]
c0d02b38:	4630      	mov	r0, r6
c0d02b3a:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d02b3c:	462a      	mov	r2, r5
c0d02b3e:	4623      	mov	r3, r4
c0d02b40:	f7fe fd68 	bl	c0d01614 <find_amount>
            }

            // if(id != 0){
            //     goto find_ops;
            // }
}
c0d02b44:	b015      	add	sp, #84	; 0x54
c0d02b46:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02b48:	20001fac 	.word	0x20001fac
c0d02b4c:	20001fb4 	.word	0x20001fb4
c0d02b50:	00006469 	.word	0x00006469

c0d02b54 <build_proposal_operation>:

short build_proposal_operation(char *input, int length, transaction *tx) {
c0d02b54:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02b56:	b08d      	sub	sp, #52	; 0x34
c0d02b58:	4615      	mov	r5, r2
c0d02b5a:	2400      	movs	r4, #0
    volatile int value_length = 0;
c0d02b5c:	940c      	str	r4, [sp, #48]	; 0x30
    volatile int cache_length = 100;
c0d02b5e:	2264      	movs	r2, #100	; 0x64
c0d02b60:	920b      	str	r2, [sp, #44]	; 0x2c
    volatile int data_index = 0;
c0d02b62:	940a      	str	r4, [sp, #40]	; 0x28
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02b64:	9109      	str	r1, [sp, #36]	; 0x24
c0d02b66:	6aae      	ldr	r6, [r5, #40]	; 0x28
c0d02b68:	6a2a      	ldr	r2, [r5, #32]
c0d02b6a:	ab08      	add	r3, sp, #32

    volatile bool go_next = false;
c0d02b6c:	701c      	strb	r4, [r3, #0]
    volatile bool *go_next_p = &go_next;

    build_proposal_operation_data(ch, go_next_p);
c0d02b6e:	466f      	mov	r7, sp
c0d02b70:	61bb      	str	r3, [r7, #24]
c0d02b72:	617a      	str	r2, [r7, #20]
c0d02b74:	463a      	mov	r2, r7
c0d02b76:	3208      	adds	r2, #8
c0d02b78:	c243      	stmia	r2!, {r0, r1, r6}
    volatile int data_index = 0;
    volatile int *value_length_p = &value_length;
    volatile int *cache_length_p = &cache_length;
    volatile int *data_index_p = &data_index;

    cache_holder ch = {flag, value_length_p, &cache, cache_length_p, data_index_p, &(tx->operation), input, length, tx->encode_p, tx->encode};
c0d02b7a:	4628      	mov	r0, r5
c0d02b7c:	300c      	adds	r0, #12

    volatile bool go_next = false;
    volatile bool *go_next_p = &go_next;

    build_proposal_operation_data(ch, go_next_p);
c0d02b7e:	6078      	str	r0, [r7, #4]
c0d02b80:	a80a      	add	r0, sp, #40	; 0x28
c0d02b82:	6038      	str	r0, [r7, #0]
c0d02b84:	a90c      	add	r1, sp, #48	; 0x30
c0d02b86:	4a07      	ldr	r2, [pc, #28]	; (c0d02ba4 <build_proposal_operation+0x50>)
c0d02b88:	ab0b      	add	r3, sp, #44	; 0x2c
c0d02b8a:	4620      	mov	r0, r4
c0d02b8c:	f7ff fed0 	bl	c0d02930 <build_proposal_operation_data>


    // if(proposed_ops_array[0] > 0){
    // ch.operation->data[(*(ch.data_p))++] = '\0';
    // }
    ch.operation->data[(*(ch.data_p))++] = '\0';
c0d02b90:	68e8      	ldr	r0, [r5, #12]
c0d02b92:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d02b94:	1c4a      	adds	r2, r1, #1
c0d02b96:	920a      	str	r2, [sp, #40]	; 0x28
c0d02b98:	5444      	strb	r4, [r0, r1]

    return *(ch.encode_p);
c0d02b9a:	6830      	ldr	r0, [r6, #0]
c0d02b9c:	b200      	sxth	r0, r0
c0d02b9e:	b00d      	add	sp, #52	; 0x34
c0d02ba0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02ba2:	46c0      	nop			; (mov r8, r8)
c0d02ba4:	20001fb8 	.word	0x20001fb8

c0d02ba8 <build_operation>:
    l = distribution(ch, go_next_p, id);

    return l;
}

int build_operation(char *input, int length, transaction *tx){
c0d02ba8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02baa:	b085      	sub	sp, #20
c0d02bac:	4614      	mov	r4, r2
c0d02bae:	460d      	mov	r5, r1
c0d02bb0:	4606      	mov	r6, r0

    find_value_length = 0;
c0d02bb2:	483f      	ldr	r0, [pc, #252]	; (c0d02cb0 <build_operation+0x108>)
c0d02bb4:	2700      	movs	r7, #0
c0d02bb6:	6007      	str	r7, [r0, #0]
    find_i = 0;
c0d02bb8:	483e      	ldr	r0, [pc, #248]	; (c0d02cb4 <build_operation+0x10c>)
c0d02bba:	6007      	str	r7, [r0, #0]
    find_info_start = 0;
c0d02bbc:	483e      	ldr	r0, [pc, #248]	; (c0d02cb8 <build_operation+0x110>)
c0d02bbe:	6007      	str	r7, [r0, #0]
    find_info_delimiter = 0;
c0d02bc0:	483e      	ldr	r0, [pc, #248]	; (c0d02cbc <build_operation+0x114>)
c0d02bc2:	6007      	str	r7, [r0, #0]
    proposed_ops_array_size = 0;
c0d02bc4:	483e      	ldr	r0, [pc, #248]	; (c0d02cc0 <build_operation+0x118>)
c0d02bc6:	6007      	str	r7, [r0, #0]

    internal_structure_type_1 = false;
c0d02bc8:	483e      	ldr	r0, [pc, #248]	; (c0d02cc4 <build_operation+0x11c>)
c0d02bca:	7007      	strb	r7, [r0, #0]
    internal_structure_type_2 = false;
c0d02bcc:	483e      	ldr	r0, [pc, #248]	; (c0d02cc8 <build_operation+0x120>)
c0d02bce:	7007      	strb	r7, [r0, #0]
    internal_structure = false;
c0d02bd0:	483e      	ldr	r0, [pc, #248]	; (c0d02ccc <build_operation+0x124>)
c0d02bd2:	7007      	strb	r7, [r0, #0]
    // log[log_p++] = (char)(*(tx->encode_p) + 48);

    // log[log_p++] = input[0];
    // log[log_p++] = input[1];

    cache = &(all_data[cache_data_p]);
c0d02bd4:	204b      	movs	r0, #75	; 0x4b
c0d02bd6:	00c0      	lsls	r0, r0, #3
c0d02bd8:	493d      	ldr	r1, [pc, #244]	; (c0d02cd0 <build_operation+0x128>)
c0d02bda:	1808      	adds	r0, r1, r0
c0d02bdc:	493d      	ldr	r1, [pc, #244]	; (c0d02cd4 <build_operation+0x12c>)
c0d02bde:	6008      	str	r0, [r1, #0]

    return find_value_length;
}

int find_data(char *value, char *flag, char *input, int length, short key_length, operation_data *operation){
    return find_data_processor(value, flag, input, length, key_length, operation, true);
c0d02be0:	2001      	movs	r0, #1
c0d02be2:	4669      	mov	r1, sp
c0d02be4:	6088      	str	r0, [r1, #8]
c0d02be6:	2002      	movs	r0, #2
c0d02be8:	6008      	str	r0, [r1, #0]
c0d02bea:	a804      	add	r0, sp, #16
c0d02bec:	a13a      	add	r1, pc, #232	; (adr r1, c0d02cd8 <build_operation+0x130>)
c0d02bee:	4632      	mov	r2, r6
c0d02bf0:	462b      	mov	r3, r5
c0d02bf2:	f7fe f869 	bl	c0d00cc8 <find_data_processor>
c0d02bf6:	4639      	mov	r1, r7
}

int get_id(char *value, int length){
    int id = 0;
    for(int z = 0; z < length; z++){
        id = id * 10;
c0d02bf8:	200a      	movs	r0, #10
c0d02bfa:	4348      	muls	r0, r1
c0d02bfc:	a904      	add	r1, sp, #16
        id += (value[z] - 48);
c0d02bfe:	1bc9      	subs	r1, r1, r7
c0d02c00:	7809      	ldrb	r1, [r1, #0]
c0d02c02:	1841      	adds	r1, r0, r1
c0d02c04:	3930      	subs	r1, #48	; 0x30
    }
}

int get_id(char *value, int length){
    int id = 0;
    for(int z = 0; z < length; z++){
c0d02c06:	1e7f      	subs	r7, r7, #1
c0d02c08:	4638      	mov	r0, r7
c0d02c0a:	3002      	adds	r0, #2
c0d02c0c:	d1f4      	bne.n	c0d02bf8 <build_operation+0x50>
c0d02c0e:	2000      	movs	r0, #0
    // l = build_operation_distribution(input, length, tx, id);

    // return l;

    int l = 0;
    switch(id){
c0d02c10:	291f      	cmp	r1, #31
c0d02c12:	dd0d      	ble.n	c0d02c30 <build_operation+0x88>
c0d02c14:	2923      	cmp	r1, #35	; 0x23
c0d02c16:	dd17      	ble.n	c0d02c48 <build_operation+0xa0>
c0d02c18:	2924      	cmp	r1, #36	; 0x24
c0d02c1a:	d029      	beq.n	c0d02c70 <build_operation+0xc8>
c0d02c1c:	2925      	cmp	r1, #37	; 0x25
c0d02c1e:	d02d      	beq.n	c0d02c7c <build_operation+0xd4>
c0d02c20:	292f      	cmp	r1, #47	; 0x2f
c0d02c22:	d142      	bne.n	c0d02caa <build_operation+0x102>
            break;
        // case 43:
        //     l = build_torrent_payment_operation(nput, length, tx);
        //     break;
        case 47:
            l = build_torrent_payment_refund_operation(input, length, tx);
c0d02c24:	4630      	mov	r0, r6
c0d02c26:	4629      	mov	r1, r5
c0d02c28:	4622      	mov	r2, r4
c0d02c2a:	f7ff fe57 	bl	c0d028dc <build_torrent_payment_refund_operation>
c0d02c2e:	e03c      	b.n	c0d02caa <build_operation+0x102>
c0d02c30:	2919      	cmp	r1, #25
c0d02c32:	dc13      	bgt.n	c0d02c5c <build_operation+0xb4>
c0d02c34:	2904      	cmp	r1, #4
c0d02c36:	d027      	beq.n	c0d02c88 <build_operation+0xe0>
c0d02c38:	2912      	cmp	r1, #18
c0d02c3a:	d136      	bne.n	c0d02caa <build_operation+0x102>
    switch(id){
        case 4:
            l = build_withdraw_operation(input, length, tx);
            break;
        case 18:
            l = build_proposal_operation(input, length, tx);
c0d02c3c:	4630      	mov	r0, r6
c0d02c3e:	4629      	mov	r1, r5
c0d02c40:	4622      	mov	r2, r4
c0d02c42:	f7ff ff87 	bl	c0d02b54 <build_proposal_operation>
c0d02c46:	e030      	b.n	c0d02caa <build_operation+0x102>
c0d02c48:	2920      	cmp	r1, #32
c0d02c4a:	d023      	beq.n	c0d02c94 <build_operation+0xec>
c0d02c4c:	2921      	cmp	r1, #33	; 0x21
c0d02c4e:	d12c      	bne.n	c0d02caa <build_operation+0x102>
            break;
        case 32:
            l = build_order_create3_operation(input, length, tx);
            break;
        case 33:
            l = build_order_cancel2_operation(input, length, tx);
c0d02c50:	4630      	mov	r0, r6
c0d02c52:	4629      	mov	r1, r5
c0d02c54:	4622      	mov	r2, r4
c0d02c56:	f7ff fc93 	bl	c0d02580 <build_order_cancel2_operation>
c0d02c5a:	e026      	b.n	c0d02caa <build_operation+0x102>
c0d02c5c:	291a      	cmp	r1, #26
c0d02c5e:	d01f      	beq.n	c0d02ca0 <build_operation+0xf8>
c0d02c60:	291c      	cmp	r1, #28
c0d02c62:	d122      	bne.n	c0d02caa <build_operation+0x102>
            break;
        case 26:
            l = build_withdraw2_operation(input, length, tx);
            break;
        case 28:
            l = build_transfer2_operation(input, length, tx);
c0d02c64:	4630      	mov	r0, r6
c0d02c66:	4629      	mov	r1, r5
c0d02c68:	4622      	mov	r2, r4
c0d02c6a:	f7ff fa75 	bl	c0d02158 <build_transfer2_operation>
c0d02c6e:	e01c      	b.n	c0d02caa <build_operation+0x102>
            break;
        case 33:
            l = build_order_cancel2_operation(input, length, tx);
            break;
        case 36:
            l = build_pledge_operation(input, length, tx);
c0d02c70:	4630      	mov	r0, r6
c0d02c72:	4629      	mov	r1, r5
c0d02c74:	4622      	mov	r2, r4
c0d02c76:	f7ff fd25 	bl	c0d026c4 <build_pledge_operation>
c0d02c7a:	e016      	b.n	c0d02caa <build_operation+0x102>
            break;
        case 37:
            l = build_redeem_operation(input, length, tx);
c0d02c7c:	4630      	mov	r0, r6
c0d02c7e:	4629      	mov	r1, r5
c0d02c80:	4622      	mov	r2, r4
c0d02c82:	f7ff fdc1 	bl	c0d02808 <build_redeem_operation>
c0d02c86:	e010      	b.n	c0d02caa <build_operation+0x102>
    // return l;

    int l = 0;
    switch(id){
        case 4:
            l = build_withdraw_operation(input, length, tx);
c0d02c88:	4630      	mov	r0, r6
c0d02c8a:	4629      	mov	r1, r5
c0d02c8c:	4622      	mov	r2, r4
c0d02c8e:	f7ff f907 	bl	c0d01ea0 <build_withdraw_operation>
c0d02c92:	e00a      	b.n	c0d02caa <build_operation+0x102>
            break;
        case 28:
            l = build_transfer2_operation(input, length, tx);
            break;
        case 32:
            l = build_order_create3_operation(input, length, tx);
c0d02c94:	4630      	mov	r0, r6
c0d02c96:	4629      	mov	r1, r5
c0d02c98:	4622      	mov	r2, r4
c0d02c9a:	f7ff fbc3 	bl	c0d02424 <build_order_create3_operation>
c0d02c9e:	e004      	b.n	c0d02caa <build_operation+0x102>
            break;
        case 18:
            l = build_proposal_operation(input, length, tx);
            break;
        case 26:
            l = build_withdraw2_operation(input, length, tx);
c0d02ca0:	4630      	mov	r0, r6
c0d02ca2:	4629      	mov	r1, r5
c0d02ca4:	4622      	mov	r2, r4
c0d02ca6:	f7ff f9a9 	bl	c0d01ffc <build_withdraw2_operation>

    

    // // os_memcpy(&(tx->encode[0]), &(log[0]), log_p);

    return l;
c0d02caa:	b005      	add	sp, #20
c0d02cac:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02cae:	46c0      	nop			; (mov r8, r8)
c0d02cb0:	20001fa0 	.word	0x20001fa0
c0d02cb4:	20001fa4 	.word	0x20001fa4
c0d02cb8:	20001fb0 	.word	0x20001fb0
c0d02cbc:	20001fac 	.word	0x20001fac
c0d02cc0:	20001fb4 	.word	0x20001fb4
c0d02cc4:	20001fa9 	.word	0x20001fa9
c0d02cc8:	20001faa 	.word	0x20001faa
c0d02ccc:	20001fa8 	.word	0x20001fa8
c0d02cd0:	20001800 	.word	0x20001800
c0d02cd4:	20001fb8 	.word	0x20001fb8
c0d02cd8:	00006469 	.word	0x00006469

c0d02cdc <uint32_to_bytes>:
#include "context.h"

int uint32_to_bytes(uint32_t val, char *out) {

    out[0] = ((val >> 24) & 0xFF);
c0d02cdc:	0e02      	lsrs	r2, r0, #24
c0d02cde:	700a      	strb	r2, [r1, #0]
    out[1] = ((val >> 16) & 0xFF);
c0d02ce0:	0c02      	lsrs	r2, r0, #16
c0d02ce2:	704a      	strb	r2, [r1, #1]
    out[2] = ((val >> 8) & 0xFF);
c0d02ce4:	0a02      	lsrs	r2, r0, #8
c0d02ce6:	708a      	strb	r2, [r1, #2]
    out[3] = ((val) & 0xFF);
c0d02ce8:	70c8      	strb	r0, [r1, #3]

    return 4;
c0d02cea:	2004      	movs	r0, #4
c0d02cec:	4770      	bx	lr

c0d02cee <uint32_to_bytes_net>:
}

int uint32_to_bytes_net(uint32_t val, char *out) {

    out[3] = ((val >> 24) & 0xFF);
c0d02cee:	0e02      	lsrs	r2, r0, #24
c0d02cf0:	70ca      	strb	r2, [r1, #3]
    out[2] = ((val >> 16) & 0xFF);
c0d02cf2:	0c02      	lsrs	r2, r0, #16
c0d02cf4:	708a      	strb	r2, [r1, #2]
    out[1] = ((val >> 8) & 0xFF);
c0d02cf6:	0a02      	lsrs	r2, r0, #8
c0d02cf8:	704a      	strb	r2, [r1, #1]
    out[0] = ((val) & 0xFF);
c0d02cfa:	7008      	strb	r0, [r1, #0]

    return 4;
c0d02cfc:	2004      	movs	r0, #4
c0d02cfe:	4770      	bx	lr

c0d02d00 <get_uint_128_bytes>:
}

int get_uint_128_bytes(uint128_t *value, char *out){
    
    int p = 0;
    out[p++] = ((value->elements[0]) & 0xFF);
c0d02d00:	7802      	ldrb	r2, [r0, #0]
c0d02d02:	700a      	strb	r2, [r1, #0]
    out[p++] = ((value->elements[0] >> 8) & 0xFF);
c0d02d04:	7842      	ldrb	r2, [r0, #1]
c0d02d06:	704a      	strb	r2, [r1, #1]
    out[p++] = ((value->elements[0] >> 16) & 0xFF);
c0d02d08:	7882      	ldrb	r2, [r0, #2]
c0d02d0a:	708a      	strb	r2, [r1, #2]
    out[p++] = ((value->elements[0] >> 24) & 0xFF);
c0d02d0c:	78c2      	ldrb	r2, [r0, #3]
c0d02d0e:	70ca      	strb	r2, [r1, #3]
    out[p++] = ((value->elements[0] >> 32) & 0xFF);
c0d02d10:	7902      	ldrb	r2, [r0, #4]
c0d02d12:	710a      	strb	r2, [r1, #4]
    out[p++] = ((value->elements[0] >> 40) & 0xFF);
c0d02d14:	7942      	ldrb	r2, [r0, #5]
c0d02d16:	714a      	strb	r2, [r1, #5]
    out[p++] = ((value->elements[0] >> 48) & 0xFF);
c0d02d18:	7982      	ldrb	r2, [r0, #6]
c0d02d1a:	718a      	strb	r2, [r1, #6]
    out[p++] = ((value->elements[0] >> 56) & 0xFF);
c0d02d1c:	79c2      	ldrb	r2, [r0, #7]
c0d02d1e:	71ca      	strb	r2, [r1, #7]
    
    out[p++] = ((value->elements[1]) & 0xFF);
c0d02d20:	7a02      	ldrb	r2, [r0, #8]
c0d02d22:	720a      	strb	r2, [r1, #8]
    out[p++] = ((value->elements[1] >> 8) & 0xFF);
c0d02d24:	7a42      	ldrb	r2, [r0, #9]
c0d02d26:	724a      	strb	r2, [r1, #9]
    out[p++] = ((value->elements[1] >> 16) & 0xFF);
c0d02d28:	7a82      	ldrb	r2, [r0, #10]
c0d02d2a:	728a      	strb	r2, [r1, #10]
    out[p++] = ((value->elements[1] >> 24) & 0xFF);
c0d02d2c:	7ac2      	ldrb	r2, [r0, #11]
c0d02d2e:	72ca      	strb	r2, [r1, #11]
    out[p++] = ((value->elements[1] >> 32) & 0xFF);
c0d02d30:	7b02      	ldrb	r2, [r0, #12]
c0d02d32:	730a      	strb	r2, [r1, #12]
    out[p++] = ((value->elements[1] >> 40) & 0xFF);
c0d02d34:	7b42      	ldrb	r2, [r0, #13]
c0d02d36:	734a      	strb	r2, [r1, #13]
    out[p++] = ((value->elements[1] >> 48) & 0xFF);
c0d02d38:	7b82      	ldrb	r2, [r0, #14]
c0d02d3a:	738a      	strb	r2, [r1, #14]
    out[p++] = ((value->elements[1] >> 56) & 0xFF);
c0d02d3c:	7bc0      	ldrb	r0, [r0, #15]
c0d02d3e:	73c8      	strb	r0, [r1, #15]
c0d02d40:	2010      	movs	r0, #16
    
    return p;
c0d02d42:	4770      	bx	lr

c0d02d44 <get_uint_128_bytes_c>:
}

int get_uint_128_bytes_c(uint128_t *value, char *out){
    
    int p = 0;
    out[p++] = ((value->elements[0] >> 56) & 0xFF);
c0d02d44:	79c2      	ldrb	r2, [r0, #7]
c0d02d46:	700a      	strb	r2, [r1, #0]
    out[p++] = ((value->elements[0] >> 48) & 0xFF);
c0d02d48:	7982      	ldrb	r2, [r0, #6]
c0d02d4a:	704a      	strb	r2, [r1, #1]
    out[p++] = ((value->elements[0] >> 40) & 0xFF);
c0d02d4c:	7942      	ldrb	r2, [r0, #5]
c0d02d4e:	708a      	strb	r2, [r1, #2]
    out[p++] = ((value->elements[0] >> 32) & 0xFF);
c0d02d50:	7902      	ldrb	r2, [r0, #4]
c0d02d52:	70ca      	strb	r2, [r1, #3]
    out[p++] = ((value->elements[0] >> 24) & 0xFF);
c0d02d54:	78c2      	ldrb	r2, [r0, #3]
c0d02d56:	710a      	strb	r2, [r1, #4]
    out[p++] = ((value->elements[0] >> 16) & 0xFF);
c0d02d58:	7882      	ldrb	r2, [r0, #2]
c0d02d5a:	714a      	strb	r2, [r1, #5]
    out[p++] = ((value->elements[0] >> 8) & 0xFF);
c0d02d5c:	7842      	ldrb	r2, [r0, #1]
c0d02d5e:	718a      	strb	r2, [r1, #6]
    out[p++] = ((value->elements[0]) & 0xFF);
c0d02d60:	7802      	ldrb	r2, [r0, #0]
c0d02d62:	71ca      	strb	r2, [r1, #7]
    
    out[p++] = ((value->elements[1] >> 56) & 0xFF);
c0d02d64:	7bc2      	ldrb	r2, [r0, #15]
c0d02d66:	720a      	strb	r2, [r1, #8]
    out[p++] = ((value->elements[1] >> 48) & 0xFF);
c0d02d68:	7b82      	ldrb	r2, [r0, #14]
c0d02d6a:	724a      	strb	r2, [r1, #9]
    out[p++] = ((value->elements[1] >> 40) & 0xFF);
c0d02d6c:	7b42      	ldrb	r2, [r0, #13]
c0d02d6e:	728a      	strb	r2, [r1, #10]
    out[p++] = ((value->elements[1] >> 32) & 0xFF);
c0d02d70:	7b02      	ldrb	r2, [r0, #12]
c0d02d72:	72ca      	strb	r2, [r1, #11]
    out[p++] = ((value->elements[1] >> 24) & 0xFF);
c0d02d74:	7ac2      	ldrb	r2, [r0, #11]
c0d02d76:	730a      	strb	r2, [r1, #12]
    out[p++] = ((value->elements[1] >> 16) & 0xFF);
c0d02d78:	7a82      	ldrb	r2, [r0, #10]
c0d02d7a:	734a      	strb	r2, [r1, #13]
    out[p++] = ((value->elements[1] >> 8) & 0xFF);
c0d02d7c:	7a42      	ldrb	r2, [r0, #9]
c0d02d7e:	738a      	strb	r2, [r1, #14]
    out[p++] = ((value->elements[1]) & 0xFF);
c0d02d80:	7a00      	ldrb	r0, [r0, #8]
c0d02d82:	73c8      	strb	r0, [r1, #15]
c0d02d84:	2010      	movs	r0, #16
    
    return p;
c0d02d86:	4770      	bx	lr

c0d02d88 <get_uint_256_bytes>:
}

int get_uint_256_bytes(uint256_t *value, char *out){
c0d02d88:	b5b0      	push	{r4, r5, r7, lr}
c0d02d8a:	460c      	mov	r4, r1
c0d02d8c:	4605      	mov	r5, r0
    
    int p = 0;
    p = get_uint_128_bytes_c(&(value->elements[0]), out);
c0d02d8e:	f7ff ffd9 	bl	c0d02d44 <get_uint_128_bytes_c>
    p = get_uint_128_bytes_c(&(value->elements[1]), out + p);
c0d02d92:	3510      	adds	r5, #16
c0d02d94:	3410      	adds	r4, #16
c0d02d96:	4628      	mov	r0, r5
c0d02d98:	4621      	mov	r1, r4
c0d02d9a:	f7ff ffd3 	bl	c0d02d44 <get_uint_128_bytes_c>
c0d02d9e:	2010      	movs	r0, #16
    
    return p;
c0d02da0:	bdb0      	pop	{r4, r5, r7, pc}

c0d02da2 <os_boot>:

// apdu buffer must hold a complete apdu to avoid troubles
unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];


void os_boot(void) {
c0d02da2:	b580      	push	{r7, lr}
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0d02da4:	2000      	movs	r0, #0
c0d02da6:	f000 ff07 	bl	c0d03bb8 <try_context_set>
#endif // HAVE_BOLOS
}
c0d02daa:	bd80      	pop	{r7, pc}

c0d02dac <os_memmove>:


REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d02dac:	b5b0      	push	{r4, r5, r7, lr}
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d02dae:	4288      	cmp	r0, r1
c0d02db0:	d90d      	bls.n	c0d02dce <os_memmove+0x22>
    while(length--) {
c0d02db2:	2a00      	cmp	r2, #0
c0d02db4:	d014      	beq.n	c0d02de0 <os_memmove+0x34>
c0d02db6:	1e49      	subs	r1, r1, #1
c0d02db8:	4252      	negs	r2, r2
c0d02dba:	1e40      	subs	r0, r0, #1
c0d02dbc:	2300      	movs	r3, #0
c0d02dbe:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d02dc0:	461c      	mov	r4, r3
c0d02dc2:	4354      	muls	r4, r2
c0d02dc4:	5d0d      	ldrb	r5, [r1, r4]
c0d02dc6:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d02dc8:	1c52      	adds	r2, r2, #1
c0d02dca:	d1f9      	bne.n	c0d02dc0 <os_memmove+0x14>
c0d02dcc:	e008      	b.n	c0d02de0 <os_memmove+0x34>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d02dce:	2a00      	cmp	r2, #0
c0d02dd0:	d006      	beq.n	c0d02de0 <os_memmove+0x34>
c0d02dd2:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d02dd4:	b29c      	uxth	r4, r3
c0d02dd6:	5d0d      	ldrb	r5, [r1, r4]
c0d02dd8:	5505      	strb	r5, [r0, r4]
      l++;
c0d02dda:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d02ddc:	1e52      	subs	r2, r2, #1
c0d02dde:	d1f9      	bne.n	c0d02dd4 <os_memmove+0x28>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d02de0:	bdb0      	pop	{r4, r5, r7, pc}

c0d02de2 <os_memset>:

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d02de2:	b580      	push	{r7, lr}
c0d02de4:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d02de6:	2a00      	cmp	r2, #0
c0d02de8:	d003      	beq.n	c0d02df2 <os_memset+0x10>
    DSTCHAR[length] = c;
c0d02dea:	4611      	mov	r1, r2
c0d02dec:	461a      	mov	r2, r3
c0d02dee:	f004 f823 	bl	c0d06e38 <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d02df2:	bd80      	pop	{r7, pc}

c0d02df4 <os_memcmp>:
  while(nbintval--) {
    ((unsigned int*) dst)[nbintval] = initval;
  }
}

char os_memcmp(const void WIDE * buf1, const void WIDE * buf2, unsigned int length) {
c0d02df4:	b570      	push	{r4, r5, r6, lr}
#define BUF1 ((unsigned char const WIDE *)buf1)
#define BUF2 ((unsigned char const WIDE *)buf2)
  while(length--) {
c0d02df6:	1e43      	subs	r3, r0, #1
c0d02df8:	1e49      	subs	r1, r1, #1
c0d02dfa:	4252      	negs	r2, r2
c0d02dfc:	2000      	movs	r0, #0
c0d02dfe:	43c4      	mvns	r4, r0
c0d02e00:	2a00      	cmp	r2, #0
c0d02e02:	d00c      	beq.n	c0d02e1e <os_memcmp+0x2a>
    if (BUF1[length] != BUF2[length]) {
c0d02e04:	4626      	mov	r6, r4
c0d02e06:	4356      	muls	r6, r2
c0d02e08:	5d8d      	ldrb	r5, [r1, r6]
c0d02e0a:	5d9e      	ldrb	r6, [r3, r6]
c0d02e0c:	1c52      	adds	r2, r2, #1
c0d02e0e:	42ae      	cmp	r6, r5
c0d02e10:	d0f6      	beq.n	c0d02e00 <os_memcmp+0xc>
      return (BUF1[length] > BUF2[length])? 1:-1;
c0d02e12:	2000      	movs	r0, #0
c0d02e14:	43c1      	mvns	r1, r0
c0d02e16:	2001      	movs	r0, #1
c0d02e18:	42ae      	cmp	r6, r5
c0d02e1a:	d800      	bhi.n	c0d02e1e <os_memcmp+0x2a>
c0d02e1c:	4608      	mov	r0, r1
  }
  return 0;
#undef BUF1
#undef BUF2

}
c0d02e1e:	b2c0      	uxtb	r0, r0
c0d02e20:	bd70      	pop	{r4, r5, r6, pc}

c0d02e22 <os_longjmp>:
  return (try_context_t*) current_ctx->jmp_buf[5];
}
#endif // BOLOS_EXCEPTION_OLD

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d02e22:	b510      	push	{r4, lr}
c0d02e24:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0d02e26:	f000 febb 	bl	c0d03ba0 <try_context_get>
c0d02e2a:	4621      	mov	r1, r4
c0d02e2c:	f004 f8aa 	bl	c0d06f84 <longjmp>

c0d02e30 <io_seproxyhal_general_status>:

#ifndef IO_RAPDU_TRANSMIT_TIMEOUT_MS 
#define IO_RAPDU_TRANSMIT_TIMEOUT_MS 2000UL
#endif // IO_RAPDU_TRANSMIT_TIMEOUT_MS

void io_seproxyhal_general_status(void) {
c0d02e30:	b580      	push	{r7, lr}
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d02e32:	f000 fe99 	bl	c0d03b68 <io_seph_is_status_sent>
c0d02e36:	2800      	cmp	r0, #0
c0d02e38:	d10b      	bne.n	c0d02e52 <io_seproxyhal_general_status+0x22>
    return;
  }

  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d02e3a:	4806      	ldr	r0, [pc, #24]	; (c0d02e54 <io_seproxyhal_general_status+0x24>)
c0d02e3c:	2160      	movs	r1, #96	; 0x60
c0d02e3e:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d02e40:	2100      	movs	r1, #0
c0d02e42:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d02e44:	2202      	movs	r2, #2
c0d02e46:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d02e48:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d02e4a:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d02e4c:	2105      	movs	r1, #5
c0d02e4e:	f000 fe7f 	bl	c0d03b50 <io_seph_send>
}
c0d02e52:	bd80      	pop	{r7, pc}
c0d02e54:	20001df0 	.word	0x20001df0

c0d02e58 <io_seproxyhal_handle_usb_event>:
}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
c0d02e58:	b5b0      	push	{r4, r5, r7, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d02e5a:	481a      	ldr	r0, [pc, #104]	; (c0d02ec4 <io_seproxyhal_handle_usb_event+0x6c>)
c0d02e5c:	78c0      	ldrb	r0, [r0, #3]
c0d02e5e:	2803      	cmp	r0, #3
c0d02e60:	dc07      	bgt.n	c0d02e72 <io_seproxyhal_handle_usb_event+0x1a>
c0d02e62:	2801      	cmp	r0, #1
c0d02e64:	d00d      	beq.n	c0d02e82 <io_seproxyhal_handle_usb_event+0x2a>
c0d02e66:	2802      	cmp	r0, #2
c0d02e68:	d128      	bne.n	c0d02ebc <io_seproxyhal_handle_usb_event+0x64>
      }
      os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
      os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d02e6a:	4817      	ldr	r0, [pc, #92]	; (c0d02ec8 <io_seproxyhal_handle_usb_event+0x70>)
c0d02e6c:	f003 f8f3 	bl	c0d06056 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d02e70:	bdb0      	pop	{r4, r5, r7, pc}
c0d02e72:	2804      	cmp	r0, #4
c0d02e74:	d01f      	beq.n	c0d02eb6 <io_seproxyhal_handle_usb_event+0x5e>
c0d02e76:	2808      	cmp	r0, #8
c0d02e78:	d120      	bne.n	c0d02ebc <io_seproxyhal_handle_usb_event+0x64>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d02e7a:	4813      	ldr	r0, [pc, #76]	; (c0d02ec8 <io_seproxyhal_handle_usb_event+0x70>)
c0d02e7c:	f003 f8e9 	bl	c0d06052 <USBD_LL_Resume>
      break;
  }
}
c0d02e80:	bdb0      	pop	{r4, r5, r7, pc}
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
  switch(G_io_seproxyhal_spi_buffer[3]) {
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d02e82:	4c11      	ldr	r4, [pc, #68]	; (c0d02ec8 <io_seproxyhal_handle_usb_event+0x70>)
c0d02e84:	2101      	movs	r1, #1
c0d02e86:	4620      	mov	r0, r4
c0d02e88:	f003 f8de 	bl	c0d06048 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d02e8c:	4620      	mov	r0, r4
c0d02e8e:	f003 f8bc 	bl	c0d0600a <USBD_LL_Reset>
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
c0d02e92:	4c0e      	ldr	r4, [pc, #56]	; (c0d02ecc <io_seproxyhal_handle_usb_event+0x74>)
c0d02e94:	79a0      	ldrb	r0, [r4, #6]
c0d02e96:	2800      	cmp	r0, #0
c0d02e98:	d111      	bne.n	c0d02ebe <io_seproxyhal_handle_usb_event+0x66>
        THROW(EXCEPTION_IO_RESET);
      }
      os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d02e9a:	4620      	mov	r0, r4
c0d02e9c:	300c      	adds	r0, #12
c0d02e9e:	2500      	movs	r5, #0
c0d02ea0:	2204      	movs	r2, #4
c0d02ea2:	4629      	mov	r1, r5
c0d02ea4:	f7ff ff9d 	bl	c0d02de2 <os_memset>
      os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d02ea8:	3410      	adds	r4, #16
c0d02eaa:	2208      	movs	r2, #8
c0d02eac:	4620      	mov	r0, r4
c0d02eae:	4629      	mov	r1, r5
c0d02eb0:	f7ff ff97 	bl	c0d02de2 <os_memset>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d02eb4:	bdb0      	pop	{r4, r5, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d02eb6:	4804      	ldr	r0, [pc, #16]	; (c0d02ec8 <io_seproxyhal_handle_usb_event+0x70>)
c0d02eb8:	f003 f8c9 	bl	c0d0604e <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d02ebc:	bdb0      	pop	{r4, r5, r7, pc}
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
      USBD_LL_Reset(&USBD_Device);
      // ongoing APDU detected, throw a reset, even if not the media. to avoid potential troubles.
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
        THROW(EXCEPTION_IO_RESET);
c0d02ebe:	2010      	movs	r0, #16
c0d02ec0:	f7ff ffaf 	bl	c0d02e22 <os_longjmp>
c0d02ec4:	20001df0 	.word	0x20001df0
c0d02ec8:	20002338 	.word	0x20002338
c0d02ecc:	20002110 	.word	0x20002110

c0d02ed0 <io_seproxyhal_get_ep_rx_size>:
      break;
  }
}

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  if ((epnum & 0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d02ed0:	217f      	movs	r1, #127	; 0x7f
c0d02ed2:	4001      	ands	r1, r0
c0d02ed4:	2000      	movs	r0, #0
c0d02ed6:	2903      	cmp	r1, #3
c0d02ed8:	d803      	bhi.n	c0d02ee2 <io_seproxyhal_get_ep_rx_size+0x12>
c0d02eda:	b2c8      	uxtb	r0, r1
  return G_io_app.usb_ep_xfer_len[epnum&0x7F];
c0d02edc:	4901      	ldr	r1, [pc, #4]	; (c0d02ee4 <io_seproxyhal_get_ep_rx_size+0x14>)
c0d02ede:	1808      	adds	r0, r1, r0
c0d02ee0:	7b00      	ldrb	r0, [r0, #12]
}
  return 0;
}
c0d02ee2:	4770      	bx	lr
c0d02ee4:	20002110 	.word	0x20002110

c0d02ee8 <io_seproxyhal_handle_usb_ep_xfer_event>:

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d02ee8:	b580      	push	{r7, lr}
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d02eea:	4816      	ldr	r0, [pc, #88]	; (c0d02f44 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d02eec:	7901      	ldrb	r1, [r0, #4]
c0d02eee:	2904      	cmp	r1, #4
c0d02ef0:	d018      	beq.n	c0d02f24 <io_seproxyhal_handle_usb_ep_xfer_event+0x3c>
c0d02ef2:	2902      	cmp	r1, #2
c0d02ef4:	d006      	beq.n	c0d02f04 <io_seproxyhal_handle_usb_ep_xfer_event+0x1c>
c0d02ef6:	2901      	cmp	r1, #1
c0d02ef8:	d122      	bne.n	c0d02f40 <io_seproxyhal_handle_usb_ep_xfer_event+0x58>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d02efa:	1d81      	adds	r1, r0, #6
c0d02efc:	4813      	ldr	r0, [pc, #76]	; (c0d02f4c <io_seproxyhal_handle_usb_ep_xfer_event+0x64>)
c0d02efe:	f002 ff88 	bl	c0d05e12 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d02f02:	bd80      	pop	{r7, pc}
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    /* This event is received after the prepare data packet has been flushed to the usb host */
    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d02f04:	78c2      	ldrb	r2, [r0, #3]
c0d02f06:	217f      	movs	r1, #127	; 0x7f
c0d02f08:	4011      	ands	r1, r2
c0d02f0a:	2903      	cmp	r1, #3
c0d02f0c:	d818      	bhi.n	c0d02f40 <io_seproxyhal_handle_usb_ep_xfer_event+0x58>
c0d02f0e:	b2c9      	uxtb	r1, r1
        // discard ep timeout as we received the sent packet confirmation
        G_io_app.usb_ep_timeouts[G_io_seproxyhal_spi_buffer[3]&0x7F].timeout = 0;
c0d02f10:	004a      	lsls	r2, r1, #1
c0d02f12:	4b0d      	ldr	r3, [pc, #52]	; (c0d02f48 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d02f14:	189a      	adds	r2, r3, r2
c0d02f16:	2300      	movs	r3, #0
c0d02f18:	8213      	strh	r3, [r2, #16]
        // propagate sending ack of the data
        USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d02f1a:	1d82      	adds	r2, r0, #6
c0d02f1c:	480b      	ldr	r0, [pc, #44]	; (c0d02f4c <io_seproxyhal_handle_usb_ep_xfer_event+0x64>)
c0d02f1e:	f002 ffff 	bl	c0d05f20 <USBD_LL_DataInStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d02f22:	bd80      	pop	{r7, pc}
      }
      break;

    /* This event is received when a new DATA token is received on an endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      if ((G_io_seproxyhal_spi_buffer[3]&0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d02f24:	78c2      	ldrb	r2, [r0, #3]
c0d02f26:	217f      	movs	r1, #127	; 0x7f
c0d02f28:	4011      	ands	r1, r2
c0d02f2a:	2903      	cmp	r1, #3
c0d02f2c:	d808      	bhi.n	c0d02f40 <io_seproxyhal_handle_usb_ep_xfer_event+0x58>
c0d02f2e:	b2c9      	uxtb	r1, r1
        // saved just in case it is needed ...
        G_io_app.usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d02f30:	4a05      	ldr	r2, [pc, #20]	; (c0d02f48 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d02f32:	1852      	adds	r2, r2, r1
c0d02f34:	7943      	ldrb	r3, [r0, #5]
c0d02f36:	7313      	strb	r3, [r2, #12]
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d02f38:	1d82      	adds	r2, r0, #6
c0d02f3a:	4804      	ldr	r0, [pc, #16]	; (c0d02f4c <io_seproxyhal_handle_usb_ep_xfer_event+0x64>)
c0d02f3c:	f002 ff97 	bl	c0d05e6e <USBD_LL_DataOutStage>
      }
      break;
  }
}
c0d02f40:	bd80      	pop	{r7, pc}
c0d02f42:	46c0      	nop			; (mov r8, r8)
c0d02f44:	20001df0 	.word	0x20001df0
c0d02f48:	20002110 	.word	0x20002110
c0d02f4c:	20002338 	.word	0x20002338

c0d02f50 <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if 
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d02f50:	b570      	push	{r4, r5, r6, lr}
c0d02f52:	4615      	mov	r5, r2
c0d02f54:	460e      	mov	r6, r1
c0d02f56:	4604      	mov	r4, r0
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d02f58:	2dff      	cmp	r5, #255	; 0xff
c0d02f5a:	d81b      	bhi.n	c0d02f94 <io_usb_send_ep+0x44>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d02f5c:	480e      	ldr	r0, [pc, #56]	; (c0d02f98 <io_usb_send_ep+0x48>)
c0d02f5e:	2150      	movs	r1, #80	; 0x50
c0d02f60:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d02f62:	1ce9      	adds	r1, r5, #3
c0d02f64:	0a0a      	lsrs	r2, r1, #8
c0d02f66:	7042      	strb	r2, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d02f68:	7081      	strb	r1, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d02f6a:	2180      	movs	r1, #128	; 0x80
c0d02f6c:	4321      	orrs	r1, r4
c0d02f6e:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d02f70:	2120      	movs	r1, #32
c0d02f72:	7101      	strb	r1, [r0, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d02f74:	7145      	strb	r5, [r0, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d02f76:	2106      	movs	r1, #6
c0d02f78:	f000 fdea 	bl	c0d03b50 <io_seph_send>
  io_seproxyhal_spi_send(buffer, length);
c0d02f7c:	4630      	mov	r0, r6
c0d02f7e:	4629      	mov	r1, r5
c0d02f80:	f000 fde6 	bl	c0d03b50 <io_seph_send>
  // setup timeout of the endpoint
  G_io_app.usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d02f84:	207f      	movs	r0, #127	; 0x7f
c0d02f86:	4020      	ands	r0, r4
c0d02f88:	0040      	lsls	r0, r0, #1
c0d02f8a:	4904      	ldr	r1, [pc, #16]	; (c0d02f9c <io_usb_send_ep+0x4c>)
c0d02f8c:	1808      	adds	r0, r1, r0
c0d02f8e:	217d      	movs	r1, #125	; 0x7d
c0d02f90:	0109      	lsls	r1, r1, #4
c0d02f92:	8201      	strh	r1, [r0, #16]
}
c0d02f94:	bd70      	pop	{r4, r5, r6, pc}
c0d02f96:	46c0      	nop			; (mov r8, r8)
c0d02f98:	20001df0 	.word	0x20001df0
c0d02f9c:	20002110 	.word	0x20002110

c0d02fa0 <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d02fa0:	b580      	push	{r7, lr}
c0d02fa2:	460a      	mov	r2, r1
c0d02fa4:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d02fa6:	2082      	movs	r0, #130	; 0x82
c0d02fa8:	2314      	movs	r3, #20
c0d02faa:	f7ff ffd1 	bl	c0d02f50 <io_usb_send_ep>
}
c0d02fae:	bd80      	pop	{r7, pc}

c0d02fb0 <io_usb_send_apdu_data_ep0x83>:

#ifdef HAVE_WEBUSB
void io_usb_send_apdu_data_ep0x83(unsigned char* buffer, unsigned short length) {
c0d02fb0:	b580      	push	{r7, lr}
c0d02fb2:	460a      	mov	r2, r1
c0d02fb4:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x83, buffer, length, 20);
c0d02fb6:	2083      	movs	r0, #131	; 0x83
c0d02fb8:	2314      	movs	r3, #20
c0d02fba:	f7ff ffc9 	bl	c0d02f50 <io_usb_send_ep>
}
c0d02fbe:	bd80      	pop	{r7, pc}

c0d02fc0 <io_seproxyhal_handle_capdu_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif // HAVE_BLUENRG

void io_seproxyhal_handle_capdu_event(void) {
c0d02fc0:	b510      	push	{r4, lr}
  if (G_io_app.apdu_state == APDU_IDLE) {
c0d02fc2:	480b      	ldr	r0, [pc, #44]	; (c0d02ff0 <io_seproxyhal_handle_capdu_event+0x30>)
c0d02fc4:	7801      	ldrb	r1, [r0, #0]
c0d02fc6:	2900      	cmp	r1, #0
c0d02fc8:	d111      	bne.n	c0d02fee <io_seproxyhal_handle_capdu_event+0x2e>
    size_t max = MIN(sizeof(G_io_apdu_buffer)-3, sizeof(G_io_seproxyhal_spi_buffer)-3);
    size_t size = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d02fca:	490a      	ldr	r1, [pc, #40]	; (c0d02ff4 <io_seproxyhal_handle_capdu_event+0x34>)
c0d02fcc:	788b      	ldrb	r3, [r1, #2]
c0d02fce:	784a      	ldrb	r2, [r1, #1]

    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d02fd0:	2406      	movs	r4, #6
c0d02fd2:	7184      	strb	r4, [r0, #6]
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
c0d02fd4:	240a      	movs	r4, #10
c0d02fd6:	7004      	strb	r4, [r0, #0]
#endif // HAVE_BLUENRG

void io_seproxyhal_handle_capdu_event(void) {
  if (G_io_app.apdu_state == APDU_IDLE) {
    size_t max = MIN(sizeof(G_io_apdu_buffer)-3, sizeof(G_io_seproxyhal_spi_buffer)-3);
    size_t size = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d02fd8:	0212      	lsls	r2, r2, #8
c0d02fda:	431a      	orrs	r2, r3

    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
    G_io_app.apdu_length = MIN(size, max);
c0d02fdc:	237d      	movs	r3, #125	; 0x7d
c0d02fde:	2a7d      	cmp	r2, #125	; 0x7d
c0d02fe0:	d300      	bcc.n	c0d02fe4 <io_seproxyhal_handle_capdu_event+0x24>
c0d02fe2:	461a      	mov	r2, r3
c0d02fe4:	8042      	strh	r2, [r0, #2]
    // copy apdu to apdu buffer
    os_memmove(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
c0d02fe6:	1cc9      	adds	r1, r1, #3
c0d02fe8:	4803      	ldr	r0, [pc, #12]	; (c0d02ff8 <io_seproxyhal_handle_capdu_event+0x38>)
c0d02fea:	f7ff fedf 	bl	c0d02dac <os_memmove>
  }
}
c0d02fee:	bd10      	pop	{r4, pc}
c0d02ff0:	20002110 	.word	0x20002110
c0d02ff4:	20001df0 	.word	0x20001df0
c0d02ff8:	20001fbc 	.word	0x20001fbc

c0d02ffc <io_seproxyhal_handle_event>:

unsigned int io_seproxyhal_handle_event(void) {
c0d02ffc:	b5b0      	push	{r4, r5, r7, lr}
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d02ffe:	481f      	ldr	r0, [pc, #124]	; (c0d0307c <io_seproxyhal_handle_event+0x80>)
c0d03000:	7882      	ldrb	r2, [r0, #2]
c0d03002:	7841      	ldrb	r1, [r0, #1]
c0d03004:	0209      	lsls	r1, r1, #8
c0d03006:	4311      	orrs	r1, r2
c0d03008:	7800      	ldrb	r0, [r0, #0]

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d0300a:	280f      	cmp	r0, #15
c0d0300c:	dc09      	bgt.n	c0d03022 <io_seproxyhal_handle_event+0x26>
c0d0300e:	280e      	cmp	r0, #14
c0d03010:	d00e      	beq.n	c0d03030 <io_seproxyhal_handle_event+0x34>
c0d03012:	280f      	cmp	r0, #15
c0d03014:	d122      	bne.n	c0d0305c <io_seproxyhal_handle_event+0x60>
c0d03016:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d03018:	2901      	cmp	r1, #1
c0d0301a:	d129      	bne.n	c0d03070 <io_seproxyhal_handle_event+0x74>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d0301c:	f7ff ff1c 	bl	c0d02e58 <io_seproxyhal_handle_usb_event>
c0d03020:	e025      	b.n	c0d0306e <io_seproxyhal_handle_event+0x72>
c0d03022:	2810      	cmp	r0, #16
c0d03024:	d01e      	beq.n	c0d03064 <io_seproxyhal_handle_event+0x68>
c0d03026:	2816      	cmp	r0, #22
c0d03028:	d118      	bne.n	c0d0305c <io_seproxyhal_handle_event+0x60>
      }
      return 1;
  #endif // HAVE_BLE

    case SEPROXYHAL_TAG_CAPDU_EVENT:
      io_seproxyhal_handle_capdu_event();
c0d0302a:	f7ff ffc9 	bl	c0d02fc0 <io_seproxyhal_handle_capdu_event>
c0d0302e:	e01e      	b.n	c0d0306e <io_seproxyhal_handle_event+0x72>
      return 1;

      // ask the user if not processed here
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
c0d03030:	4813      	ldr	r0, [pc, #76]	; (c0d03080 <io_seproxyhal_handle_event+0x84>)
c0d03032:	6881      	ldr	r1, [r0, #8]
c0d03034:	3164      	adds	r1, #100	; 0x64
c0d03036:	6081      	str	r1, [r0, #8]
c0d03038:	2100      	movs	r1, #0
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
c0d0303a:	1a42      	subs	r2, r0, r1
c0d0303c:	8ad3      	ldrh	r3, [r2, #22]
c0d0303e:	2b00      	cmp	r3, #0
c0d03040:	d009      	beq.n	c0d03056 <io_seproxyhal_handle_event+0x5a>
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
c0d03042:	2464      	movs	r4, #100	; 0x64
c0d03044:	2b64      	cmp	r3, #100	; 0x64
c0d03046:	461d      	mov	r5, r3
c0d03048:	d300      	bcc.n	c0d0304c <io_seproxyhal_handle_event+0x50>
c0d0304a:	4625      	mov	r5, r4
c0d0304c:	1b5b      	subs	r3, r3, r5
c0d0304e:	82d3      	strh	r3, [r2, #22]
c0d03050:	4a0c      	ldr	r2, [pc, #48]	; (c0d03084 <io_seproxyhal_handle_event+0x88>)
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
c0d03052:	4213      	tst	r3, r2
c0d03054:	d00d      	beq.n	c0d03072 <io_seproxyhal_handle_event+0x76>
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
c0d03056:	1c89      	adds	r1, r1, #2
c0d03058:	2908      	cmp	r1, #8
c0d0305a:	d1ee      	bne.n	c0d0303a <io_seproxyhal_handle_event+0x3e>
        __attribute__((fallthrough));
      }
#endif // HAVE_BLE_APDU
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d0305c:	2002      	movs	r0, #2
c0d0305e:	f7fd fbc7 	bl	c0d007f0 <io_event>
  }
  // defaultly return as not processed
  return 0;
}
c0d03062:	bdb0      	pop	{r4, r5, r7, pc}
c0d03064:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3) {
c0d03066:	2903      	cmp	r1, #3
c0d03068:	d302      	bcc.n	c0d03070 <io_seproxyhal_handle_event+0x74>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d0306a:	f7ff ff3d 	bl	c0d02ee8 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d0306e:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaultly return as not processed
  return 0;
}
c0d03070:	bdb0      	pop	{r4, r5, r7, pc}
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
              // timeout !
              G_io_app.apdu_state = APDU_IDLE;
c0d03072:	2100      	movs	r1, #0
c0d03074:	7001      	strb	r1, [r0, #0]
              THROW(EXCEPTION_IO_RESET);
c0d03076:	2010      	movs	r0, #16
c0d03078:	f7ff fed3 	bl	c0d02e22 <os_longjmp>
c0d0307c:	20001df0 	.word	0x20001df0
c0d03080:	20002110 	.word	0x20002110
c0d03084:	0000ffff 	.word	0x0000ffff

c0d03088 <io_seproxyhal_init>:
#ifdef HAVE_BOLOS_APP_STACK_CANARY
#define APP_STACK_CANARY_MAGIC 0xDEAD0031
extern unsigned int app_stack_canary;
#endif // HAVE_BOLOS_APP_STACK_CANARY

void io_seproxyhal_init(void) {
c0d03088:	b5b0      	push	{r4, r5, r7, lr}
#ifndef HAVE_BOLOS
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d0308a:	200a      	movs	r0, #10
c0d0308c:	f000 fc3a 	bl	c0d03904 <check_api_level>

  // wipe the io structure before it's used
#ifdef TARGET_NANOX
  unsigned int plane = G_io_app.plane_mode;
#endif // TARGET_NANOX
  os_memset(&G_io_app, 0, sizeof(G_io_app));
c0d03090:	4c08      	ldr	r4, [pc, #32]	; (c0d030b4 <io_seproxyhal_init+0x2c>)
c0d03092:	2500      	movs	r5, #0
c0d03094:	2218      	movs	r2, #24
c0d03096:	4620      	mov	r0, r4
c0d03098:	4629      	mov	r1, r5
c0d0309a:	f7ff fea2 	bl	c0d02de2 <os_memset>
#ifdef TARGET_NANOX
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
c0d0309e:	7025      	strb	r5, [r4, #0]
  G_io_app.apdu_length = 0;
c0d030a0:	8065      	strh	r5, [r4, #2]
  G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d030a2:	71a5      	strb	r5, [r4, #6]

  G_io_app.ms = 0;
c0d030a4:	60a5      	str	r5, [r4, #8]
  #ifdef DEBUG_APDU
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU

  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d030a6:	f000 fb8f 	bl	c0d037c8 <io_usb_hid_init>
// #endif // TARGET_NANOX
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d030aa:	4803      	ldr	r0, [pc, #12]	; (c0d030b8 <io_seproxyhal_init+0x30>)
c0d030ac:	6005      	str	r5, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d030ae:	6045      	str	r5, [r0, #4]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d030b0:	bdb0      	pop	{r4, r5, r7, pc}
c0d030b2:	46c0      	nop			; (mov r8, r8)
c0d030b4:	20002110 	.word	0x20002110
c0d030b8:	20002128 	.word	0x20002128

c0d030bc <io_seproxyhal_init_ux>:

// #ifdef TARGET_NANOX
//   // wipe frame buffer
//   screen_clear();
// #endif // TARGET_NANOX
}
c0d030bc:	4770      	bx	lr
	...

c0d030c0 <io_seproxyhal_init_button>:

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d030c0:	4802      	ldr	r0, [pc, #8]	; (c0d030cc <io_seproxyhal_init_button+0xc>)
c0d030c2:	2100      	movs	r1, #0
c0d030c4:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d030c6:	6041      	str	r1, [r0, #4]
}
c0d030c8:	4770      	bx	lr
c0d030ca:	46c0      	nop			; (mov r8, r8)
c0d030cc:	20002128 	.word	0x20002128

c0d030d0 <io_seproxyhal_display_icon>:
    }
  }
}

#else // TARGET_NANOX
void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_det) {
c0d030d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d030d2:	b089      	sub	sp, #36	; 0x24
c0d030d4:	4605      	mov	r5, r0
  bagl_component_t icon_component_mod;
  const bagl_icon_details_t* icon_details = (bagl_icon_details_t*)PIC(icon_det);
c0d030d6:	4608      	mov	r0, r1
c0d030d8:	f000 fbfc 	bl	c0d038d4 <pic>
c0d030dc:	4604      	mov	r4, r0
  if (icon_details && icon_details->bitmap) {
c0d030de:	2c00      	cmp	r4, #0
c0d030e0:	d043      	beq.n	c0d0316a <io_seproxyhal_display_icon+0x9a>
c0d030e2:	6920      	ldr	r0, [r4, #16]
c0d030e4:	2800      	cmp	r0, #0
c0d030e6:	d040      	beq.n	c0d0316a <io_seproxyhal_display_icon+0x9a>
    // ensure not being out of bounds in the icon component agianst the declared icon real size
    os_memmove(&icon_component_mod, PIC(icon_component), sizeof(bagl_component_t));
c0d030e8:	4628      	mov	r0, r5
c0d030ea:	f000 fbf3 	bl	c0d038d4 <pic>
c0d030ee:	4601      	mov	r1, r0
c0d030f0:	ad02      	add	r5, sp, #8
c0d030f2:	221c      	movs	r2, #28
c0d030f4:	4628      	mov	r0, r5
c0d030f6:	9201      	str	r2, [sp, #4]
c0d030f8:	f7ff fe58 	bl	c0d02dac <os_memmove>
    icon_component_mod.width = icon_details->width;
c0d030fc:	6821      	ldr	r1, [r4, #0]
c0d030fe:	80e9      	strh	r1, [r5, #6]
    icon_component_mod.height = icon_details->height;
c0d03100:	6862      	ldr	r2, [r4, #4]
c0d03102:	812a      	strh	r2, [r5, #8]
    // component type = ICON, provided bitmap
    // => bitmap transmitted


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d03104:	68a0      	ldr	r0, [r4, #8]
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d03106:	4f1a      	ldr	r7, [pc, #104]	; (c0d03170 <io_seproxyhal_display_icon+0xa0>)
c0d03108:	2365      	movs	r3, #101	; 0x65
c0d0310a:	703b      	strb	r3, [r7, #0]


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
    // bitmap size
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d0310c:	b292      	uxth	r2, r2
c0d0310e:	4342      	muls	r2, r0
c0d03110:	b28b      	uxth	r3, r1
c0d03112:	4353      	muls	r3, r2
c0d03114:	08d9      	lsrs	r1, r3, #3
c0d03116:	1c4e      	adds	r6, r1, #1
c0d03118:	2207      	movs	r2, #7
c0d0311a:	4213      	tst	r3, r2
c0d0311c:	d100      	bne.n	c0d03120 <io_seproxyhal_display_icon+0x50>
c0d0311e:	460e      	mov	r6, r1
c0d03120:	4631      	mov	r1, r6
c0d03122:	9100      	str	r1, [sp, #0]
c0d03124:	2604      	movs	r6, #4
    // component type = ICON, provided bitmap
    // => bitmap transmitted


    // color index size
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d03126:	4086      	lsls	r6, r0
    // bitmap size
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
c0d03128:	1870      	adds	r0, r6, r1
                            +w; /* image bitmap size */
c0d0312a:	301d      	adds	r0, #29
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
    G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0312c:	0a01      	lsrs	r1, r0, #8
c0d0312e:	7079      	strb	r1, [r7, #1]
    G_io_seproxyhal_spi_buffer[2] = length;
c0d03130:	70b8      	strb	r0, [r7, #2]
c0d03132:	2103      	movs	r1, #3
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d03134:	4638      	mov	r0, r7
c0d03136:	f000 fd0b 	bl	c0d03b50 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d0313a:	4628      	mov	r0, r5
c0d0313c:	9901      	ldr	r1, [sp, #4]
c0d0313e:	f000 fd07 	bl	c0d03b50 <io_seph_send>
    G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d03142:	68a0      	ldr	r0, [r4, #8]
c0d03144:	7038      	strb	r0, [r7, #0]
c0d03146:	2101      	movs	r1, #1
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d03148:	4638      	mov	r0, r7
c0d0314a:	f000 fd01 	bl	c0d03b50 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d0314e:	68e0      	ldr	r0, [r4, #12]
c0d03150:	f000 fbc0 	bl	c0d038d4 <pic>
c0d03154:	b2b1      	uxth	r1, r6
c0d03156:	f000 fcfb 	bl	c0d03b50 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d0315a:	9800      	ldr	r0, [sp, #0]
c0d0315c:	b285      	uxth	r5, r0
c0d0315e:	6920      	ldr	r0, [r4, #16]
c0d03160:	f000 fbb8 	bl	c0d038d4 <pic>
c0d03164:	4629      	mov	r1, r5
c0d03166:	f000 fcf3 	bl	c0d03b50 <io_seph_send>
  #endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
  }
}
c0d0316a:	b009      	add	sp, #36	; 0x24
c0d0316c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0316e:	46c0      	nop			; (mov r8, r8)
c0d03170:	20001df0 	.word	0x20001df0

c0d03174 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t * el) {
c0d03174:	b570      	push	{r4, r5, r6, lr}

  const bagl_element_t* element = (const bagl_element_t*) PIC(el);
c0d03176:	f000 fbad 	bl	c0d038d4 <pic>
c0d0317a:	4604      	mov	r4, r0

  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d0317c:	7820      	ldrb	r0, [r4, #0]
c0d0317e:	267f      	movs	r6, #127	; 0x7f
c0d03180:	4006      	ands	r6, r0

  // avoid sending another status :), fixes a lot of bugs in the end
  if (io_seproxyhal_spi_is_status_sent()) {
c0d03182:	f000 fcf1 	bl	c0d03b68 <io_seph_is_status_sent>
c0d03186:	2800      	cmp	r0, #0
c0d03188:	d130      	bne.n	c0d031ec <io_seproxyhal_display_default+0x78>
c0d0318a:	2e00      	cmp	r6, #0
c0d0318c:	d02e      	beq.n	c0d031ec <io_seproxyhal_display_default+0x78>
    return;
  }

  if (type != BAGL_NONE) {
    if (element->text != NULL) {
c0d0318e:	69e0      	ldr	r0, [r4, #28]
c0d03190:	2800      	cmp	r0, #0
c0d03192:	d01d      	beq.n	c0d031d0 <io_seproxyhal_display_default+0x5c>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d03194:	f000 fb9e 	bl	c0d038d4 <pic>
c0d03198:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0319a:	2e05      	cmp	r6, #5
c0d0319c:	d102      	bne.n	c0d031a4 <io_seproxyhal_display_default+0x30>
c0d0319e:	7ea0      	ldrb	r0, [r4, #26]
c0d031a0:	2800      	cmp	r0, #0
c0d031a2:	d024      	beq.n	c0d031ee <io_seproxyhal_display_default+0x7a>
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d031a4:	4628      	mov	r0, r5
c0d031a6:	f003 fefb 	bl	c0d06fa0 <strlen>
c0d031aa:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d031ac:	4812      	ldr	r0, [pc, #72]	; (c0d031f8 <io_seproxyhal_display_default+0x84>)
c0d031ae:	2165      	movs	r1, #101	; 0x65
c0d031b0:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d031b2:	4631      	mov	r1, r6
c0d031b4:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d031b6:	0a0a      	lsrs	r2, r1, #8
c0d031b8:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d031ba:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d031bc:	2103      	movs	r1, #3
c0d031be:	f000 fcc7 	bl	c0d03b50 <io_seph_send>
c0d031c2:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d031c4:	4620      	mov	r0, r4
c0d031c6:	f000 fcc3 	bl	c0d03b50 <io_seph_send>
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
c0d031ca:	b2b1      	uxth	r1, r6
c0d031cc:	4628      	mov	r0, r5
c0d031ce:	e00b      	b.n	c0d031e8 <io_seproxyhal_display_default+0x74>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d031d0:	4809      	ldr	r0, [pc, #36]	; (c0d031f8 <io_seproxyhal_display_default+0x84>)
c0d031d2:	2165      	movs	r1, #101	; 0x65
c0d031d4:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d031d6:	2100      	movs	r1, #0
c0d031d8:	7041      	strb	r1, [r0, #1]
c0d031da:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d031dc:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d031de:	2103      	movs	r1, #3
c0d031e0:	f000 fcb6 	bl	c0d03b50 <io_seph_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d031e4:	4620      	mov	r0, r4
c0d031e6:	4629      	mov	r1, r5
c0d031e8:	f000 fcb2 	bl	c0d03b50 <io_seph_send>
    }
  }
}
c0d031ec:	bd70      	pop	{r4, r5, r6, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
c0d031ee:	4620      	mov	r0, r4
c0d031f0:	4629      	mov	r1, r5
c0d031f2:	f7ff ff6d 	bl	c0d030d0 <io_seproxyhal_display_icon>
      G_io_seproxyhal_spi_buffer[2] = length;
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
    }
  }
}
c0d031f6:	bd70      	pop	{r4, r5, r6, pc}
c0d031f8:	20001df0 	.word	0x20001df0

c0d031fc <bagl_label_roundtrip_duration_ms>:
#endif // TARGET_NANOX

unsigned int bagl_label_roundtrip_duration_ms(const bagl_element_t* e, unsigned int average_char_width) {
c0d031fc:	b580      	push	{r7, lr}
c0d031fe:	460a      	mov	r2, r1
  return bagl_label_roundtrip_duration_ms_buf(e, e->text, average_char_width);
c0d03200:	69c1      	ldr	r1, [r0, #28]
c0d03202:	f000 f801 	bl	c0d03208 <bagl_label_roundtrip_duration_ms_buf>
c0d03206:	bd80      	pop	{r7, pc}

c0d03208 <bagl_label_roundtrip_duration_ms_buf>:
}

unsigned int bagl_label_roundtrip_duration_ms_buf(const bagl_element_t* e, const char* str, unsigned int average_char_width) {
c0d03208:	b570      	push	{r4, r5, r6, lr}
c0d0320a:	4616      	mov	r6, r2
c0d0320c:	4604      	mov	r4, r0
c0d0320e:	2500      	movs	r5, #0
  // not a scrollable label
  if (e == NULL || (e->component.type != BAGL_LABEL && e->component.type != BAGL_LABELINE)) {
c0d03210:	2c00      	cmp	r4, #0
c0d03212:	d01c      	beq.n	c0d0324e <bagl_label_roundtrip_duration_ms_buf+0x46>
c0d03214:	7820      	ldrb	r0, [r4, #0]
c0d03216:	2807      	cmp	r0, #7
c0d03218:	d001      	beq.n	c0d0321e <bagl_label_roundtrip_duration_ms_buf+0x16>
c0d0321a:	2802      	cmp	r0, #2
c0d0321c:	d117      	bne.n	c0d0324e <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  
  unsigned int text_adr = PIC((unsigned int)str);
c0d0321e:	4608      	mov	r0, r1
c0d03220:	f000 fb58 	bl	c0d038d4 <pic>
  unsigned int textlen = 0;
  
  // no delay, no text to display
  if (!text_adr) {
c0d03224:	2800      	cmp	r0, #0
c0d03226:	d012      	beq.n	c0d0324e <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0;
  }
  textlen = strlen((const char*)text_adr);
c0d03228:	f003 feba 	bl	c0d06fa0 <strlen>
  
  // no delay, all text fits
  textlen = textlen * average_char_width;
c0d0322c:	4346      	muls	r6, r0
  if (textlen <= e->component.width) {
c0d0322e:	88e0      	ldrh	r0, [r4, #6]
c0d03230:	4286      	cmp	r6, r0
c0d03232:	d90c      	bls.n	c0d0324e <bagl_label_roundtrip_duration_ms_buf+0x46>
    return 0; 
  }
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
c0d03234:	1a31      	subs	r1, r6, r0
c0d03236:	207d      	movs	r0, #125	; 0x7d
c0d03238:	0100      	lsls	r0, r0, #4
c0d0323a:	4348      	muls	r0, r1
c0d0323c:	7ea1      	ldrb	r1, [r4, #26]
c0d0323e:	f003 fc4f 	bl	c0d06ae0 <__aeabi_uidiv>
c0d03242:	7aa1      	ldrb	r1, [r4, #10]
c0d03244:	0049      	lsls	r1, r1, #1
c0d03246:	b2c9      	uxtb	r1, r1
c0d03248:	2264      	movs	r2, #100	; 0x64
c0d0324a:	434a      	muls	r2, r1
c0d0324c:	1815      	adds	r5, r2, r0
}
c0d0324e:	4628      	mov	r0, r5
c0d03250:	bd70      	pop	{r4, r5, r6, pc}
	...

c0d03254 <io_seproxyhal_button_push>:

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d03254:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03256:	b081      	sub	sp, #4
c0d03258:	4604      	mov	r4, r0
  if (button_callback) {
c0d0325a:	2c00      	cmp	r4, #0
c0d0325c:	d027      	beq.n	c0d032ae <io_seproxyhal_button_push+0x5a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_ux_os.button_mask) {
c0d0325e:	4815      	ldr	r0, [pc, #84]	; (c0d032b4 <io_seproxyhal_button_push+0x60>)
c0d03260:	6807      	ldr	r7, [r0, #0]
c0d03262:	6845      	ldr	r5, [r0, #4]
c0d03264:	4e14      	ldr	r6, [pc, #80]	; (c0d032b8 <io_seproxyhal_button_push+0x64>)
c0d03266:	428f      	cmp	r7, r1
c0d03268:	d101      	bne.n	c0d0326e <io_seproxyhal_button_push+0x1a>
      // each 100ms ~
      G_ux_os.button_same_mask_counter++;
c0d0326a:	1c6d      	adds	r5, r5, #1
c0d0326c:	6045      	str	r5, [r0, #4]
    }

    // when new_button_mask is 0 and 

    // append the button mask
    button_mask = G_ux_os.button_mask | new_button_mask;
c0d0326e:	430f      	orrs	r7, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
c0d03270:	2900      	cmp	r1, #0
c0d03272:	d002      	beq.n	c0d0327a <io_seproxyhal_button_push+0x26>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_ux_os.button_mask = button_mask;
c0d03274:	6007      	str	r7, [r0, #0]
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d03276:	463a      	mov	r2, r7
c0d03278:	e004      	b.n	c0d03284 <io_seproxyhal_button_push+0x30>
c0d0327a:	2200      	movs	r2, #0
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_ux_os.button_mask = 0;
c0d0327c:	6002      	str	r2, [r0, #0]
      G_ux_os.button_same_mask_counter=0;
c0d0327e:	6042      	str	r2, [r0, #4]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d03280:	1c73      	adds	r3, r6, #1
c0d03282:	431f      	orrs	r7, r3
    else {
      G_ux_os.button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d03284:	428a      	cmp	r2, r1
c0d03286:	d001      	beq.n	c0d0328c <io_seproxyhal_button_push+0x38>
      G_ux_os.button_same_mask_counter=0;
c0d03288:	2100      	movs	r1, #0
c0d0328a:	6041      	str	r1, [r0, #4]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0328c:	2d08      	cmp	r5, #8
c0d0328e:	d30b      	bcc.n	c0d032a8 <io_seproxyhal_button_push+0x54>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d03290:	2103      	movs	r1, #3
c0d03292:	4628      	mov	r0, r5
c0d03294:	f003 fcaa 	bl	c0d06bec <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d03298:	2001      	movs	r0, #1
c0d0329a:	0780      	lsls	r0, r0, #30
c0d0329c:	4338      	orrs	r0, r7
      G_ux_os.button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d0329e:	2900      	cmp	r1, #0
c0d032a0:	d000      	beq.n	c0d032a4 <io_seproxyhal_button_push+0x50>
c0d032a2:	4638      	mov	r0, r7
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d032a4:	4030      	ands	r0, r6
c0d032a6:	e000      	b.n	c0d032aa <io_seproxyhal_button_push+0x56>
c0d032a8:	4638      	mov	r0, r7
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d032aa:	4629      	mov	r1, r5
c0d032ac:	47a0      	blx	r4

  }
}
c0d032ae:	b001      	add	sp, #4
c0d032b0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d032b2:	46c0      	nop			; (mov r8, r8)
c0d032b4:	20002128 	.word	0x20002128
c0d032b8:	7fffffff 	.word	0x7fffffff

c0d032bc <io_seproxyhal_setup_ticker>:

#endif // HAVE_BAGL

void io_seproxyhal_setup_ticker(unsigned int interval_ms) {
c0d032bc:	b580      	push	{r7, lr}
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SET_TICKER_INTERVAL;
c0d032be:	4a07      	ldr	r2, [pc, #28]	; (c0d032dc <io_seproxyhal_setup_ticker+0x20>)
c0d032c0:	214e      	movs	r1, #78	; 0x4e
c0d032c2:	7011      	strb	r1, [r2, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d032c4:	2100      	movs	r1, #0
c0d032c6:	7051      	strb	r1, [r2, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d032c8:	2102      	movs	r1, #2
c0d032ca:	7091      	strb	r1, [r2, #2]
  G_io_seproxyhal_spi_buffer[3] = (interval_ms>>8)&0xff;
c0d032cc:	0a01      	lsrs	r1, r0, #8
c0d032ce:	70d1      	strb	r1, [r2, #3]
  G_io_seproxyhal_spi_buffer[4] = (interval_ms)&0xff;
c0d032d0:	7110      	strb	r0, [r2, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d032d2:	2105      	movs	r1, #5
c0d032d4:	4610      	mov	r0, r2
c0d032d6:	f000 fc3b 	bl	c0d03b50 <io_seph_send>
}
c0d032da:	bd80      	pop	{r7, pc}
c0d032dc:	20001df0 	.word	0x20001df0

c0d032e0 <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d032e0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d032e2:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d032e4:	4e0f      	ldr	r6, [pc, #60]	; (c0d03324 <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d032e6:	2401      	movs	r4, #1
c0d032e8:	7034      	strb	r4, [r6, #0]

#ifndef HAVE_BOLOS
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d032ea:	1cb1      	adds	r1, r6, #2
c0d032ec:	27ff      	movs	r7, #255	; 0xff
c0d032ee:	3750      	adds	r7, #80	; 0x50
c0d032f0:	1c7a      	adds	r2, r7, #1
c0d032f2:	4620      	mov	r0, r4
c0d032f4:	f000 fc12 	bl	c0d03b1c <os_registry_get_current_app_tag>
c0d032f8:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d032fa:	7075      	strb	r5, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d032fc:	1b7a      	subs	r2, r7, r5
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d032fe:	1977      	adds	r7, r6, r5
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
  G_io_apdu_buffer[tx_len++] = len;
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len);
c0d03300:	1cf9      	adds	r1, r7, #3
c0d03302:	2002      	movs	r0, #2
c0d03304:	f000 fc0a 	bl	c0d03b1c <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d03308:	70b8      	strb	r0, [r7, #2]
c0d0330a:	182d      	adds	r5, r5, r0
unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d0330c:	1976      	adds	r6, r6, r5
#endif // HAVE_BOLOS

#if !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)
  // to be fixed within io tasks
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d0330e:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d03310:	f000 fbf8 	bl	c0d03b04 <os_flags>
c0d03314:	7130      	strb	r0, [r6, #4]
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d03316:	2090      	movs	r0, #144	; 0x90
c0d03318:	7170      	strb	r0, [r6, #5]
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d0331a:	2000      	movs	r0, #0
c0d0331c:	71b0      	strb	r0, [r6, #6]
c0d0331e:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d03320:	b001      	add	sp, #4
c0d03322:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03324:	20001fbc 	.word	0x20001fbc

c0d03328 <io_exchange>:
}


unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d03328:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0332a:	b08b      	sub	sp, #44	; 0x2c
c0d0332c:	460b      	mov	r3, r1
c0d0332e:	4606      	mov	r6, r0
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d03330:	2007      	movs	r0, #7
c0d03332:	4206      	tst	r6, r0
c0d03334:	d007      	beq.n	c0d03346 <io_exchange+0x1e>
c0d03336:	4634      	mov	r4, r6
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d03338:	b2e0      	uxtb	r0, r4
c0d0333a:	4619      	mov	r1, r3
c0d0333c:	f7fd fa36 	bl	c0d007ac <io_exchange_al>
  }
}
c0d03340:	b280      	uxth	r0, r0
c0d03342:	b00b      	add	sp, #44	; 0x2c
c0d03344:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03346:	9000      	str	r0, [sp, #0]
c0d03348:	48a5      	ldr	r0, [pc, #660]	; (c0d035e0 <io_exchange+0x2b8>)
        // seed cookie
        // host: <nothing>
        // device: <format(1B)> <len(1B)> <seed magic cookie if pin is entered(len)> 9000 | 6985
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\x02\x00\x00", 4) == 0) {
          tx_len = 0;
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
c0d0334a:	9001      	str	r0, [sp, #4]
c0d0334c:	2083      	movs	r0, #131	; 0x83
c0d0334e:	9005      	str	r0, [sp, #20]
c0d03350:	4da5      	ldr	r5, [pc, #660]	; (c0d035e8 <io_exchange+0x2c0>)
c0d03352:	4fa4      	ldr	r7, [pc, #656]	; (c0d035e4 <io_exchange+0x2bc>)
c0d03354:	4634      	mov	r4, r6
reply_apdu:
  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d03356:	2110      	movs	r1, #16
c0d03358:	4630      	mov	r0, r6
c0d0335a:	4008      	ands	r0, r1
c0d0335c:	b29a      	uxth	r2, r3
c0d0335e:	2a00      	cmp	r2, #0
c0d03360:	9607      	str	r6, [sp, #28]
c0d03362:	d100      	bne.n	c0d03366 <io_exchange+0x3e>
c0d03364:	e0b3      	b.n	c0d034ce <io_exchange+0x1a6>
c0d03366:	2800      	cmp	r0, #0
c0d03368:	d000      	beq.n	c0d0336c <io_exchange+0x44>
c0d0336a:	e0b0      	b.n	c0d034ce <io_exchange+0x1a6>
c0d0336c:	9302      	str	r3, [sp, #8]
c0d0336e:	9204      	str	r2, [sp, #16]
c0d03370:	9103      	str	r1, [sp, #12]
c0d03372:	9006      	str	r0, [sp, #24]
c0d03374:	e007      	b.n	c0d03386 <io_exchange+0x5e>
      // ensure it's our turn to send a command/status, could lag a bit before sending the reply
      while (io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d03376:	2180      	movs	r1, #128	; 0x80
c0d03378:	2200      	movs	r2, #0
c0d0337a:	4638      	mov	r0, r7
c0d0337c:	f000 fc00 	bl	c0d03b80 <io_seph_recv>
c0d03380:	2001      	movs	r0, #1
        // process without sending status on tickers etc, to ensure keeping the hand
        os_io_seph_recv_and_process(1);
c0d03382:	f000 f94b 	bl	c0d0361c <os_io_seph_recv_and_process>
c0d03386:	f000 fbef 	bl	c0d03b68 <io_seph_is_status_sent>
c0d0338a:	2800      	cmp	r0, #0
c0d0338c:	d1f3      	bne.n	c0d03376 <io_exchange+0x4e>
      }

      // reinit sending timeout for APDU replied within io_exchange
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d0338e:	207d      	movs	r0, #125	; 0x7d
c0d03390:	0100      	lsls	r0, r0, #4
c0d03392:	68a9      	ldr	r1, [r5, #8]
c0d03394:	180e      	adds	r6, r1, r0
c0d03396:	7828      	ldrb	r0, [r5, #0]

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
c0d03398:	2809      	cmp	r0, #9
c0d0339a:	9a04      	ldr	r2, [sp, #16]
c0d0339c:	dc3f      	bgt.n	c0d0341e <io_exchange+0xf6>
c0d0339e:	2807      	cmp	r0, #7
c0d033a0:	d044      	beq.n	c0d0342c <io_exchange+0x104>
c0d033a2:	2809      	cmp	r0, #9
c0d033a4:	d160      	bne.n	c0d03468 <io_exchange+0x140>
c0d033a6:	2100      	movs	r1, #0
c0d033a8:	4c90      	ldr	r4, [pc, #576]	; (c0d035ec <io_exchange+0x2c4>)
          // case to handle U2F channels. u2f apdu to be dispatched in the upper layers
          case APDU_U2F:
            // prepare reply, the remaining segments will be pumped during USB/BLE events handling while waiting for the next APDU

            // the reply has been prepared by the application, stop sending anti timeouts
            u2f_message_set_autoreply_wait_user_presence(&G_io_u2f, false);
c0d033aa:	4620      	mov	r0, r4
c0d033ac:	9102      	str	r1, [sp, #8]
c0d033ae:	f001 fadf 	bl	c0d04970 <u2f_message_set_autoreply_wait_user_presence>
c0d033b2:	e010      	b.n	c0d033d6 <io_exchange+0xae>

            // continue processing currently received command until completely received.
            while(!u2f_message_repliable(&G_io_u2f)) {

              io_seproxyhal_general_status();
c0d033b4:	f7ff fd3c 	bl	c0d02e30 <io_seproxyhal_general_status>
              do {
                io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d033b8:	2180      	movs	r1, #128	; 0x80
c0d033ba:	2200      	movs	r2, #0
c0d033bc:	4638      	mov	r0, r7
c0d033be:	f000 fbdf 	bl	c0d03b80 <io_seph_recv>
                // check for reply timeout
                if (G_io_app.ms >= timeout_ms) {
c0d033c2:	68a8      	ldr	r0, [r5, #8]
c0d033c4:	42b0      	cmp	r0, r6
c0d033c6:	d300      	bcc.n	c0d033ca <io_exchange+0xa2>
c0d033c8:	e101      	b.n	c0d035ce <io_exchange+0x2a6>
                  THROW(EXCEPTION_IO_RESET);
                }
                // avoid a general status to be replied
                io_seproxyhal_handle_event();
c0d033ca:	f7ff fe17 	bl	c0d02ffc <io_seproxyhal_handle_event>
              } while (io_seproxyhal_spi_is_status_sent());
c0d033ce:	f000 fbcb 	bl	c0d03b68 <io_seph_is_status_sent>
c0d033d2:	2800      	cmp	r0, #0
c0d033d4:	d1f0      	bne.n	c0d033b8 <io_exchange+0x90>
c0d033d6:	4620      	mov	r0, r4
c0d033d8:	f000 fffe 	bl	c0d043d8 <u2f_message_repliable>
c0d033dc:	2800      	cmp	r0, #0
c0d033de:	d0e9      	beq.n	c0d033b4 <io_exchange+0x8c>
c0d033e0:	9a04      	ldr	r2, [sp, #16]
            }
#ifdef U2F_PROXY_MAGIC

            // user presence + counter + rapdu + sw must fit the apdu buffer
            if (1U+ 4U+ tx_len +2U > sizeof(G_io_apdu_buffer)) {
c0d033e2:	1dd4      	adds	r4, r2, #7
c0d033e4:	0860      	lsrs	r0, r4, #1
c0d033e6:	28a9      	cmp	r0, #169	; 0xa9
c0d033e8:	d300      	bcc.n	c0d033ec <io_exchange+0xc4>
c0d033ea:	e0f6      	b.n	c0d035da <io_exchange+0x2b2>
              THROW(INVALID_PARAMETER);
            }

            // u2F tunnel needs the status words to be included in the signature response BLOB, do it now.
            // always return 9000 in the signature to avoid error @ transport level in u2f layers. 
            G_io_apdu_buffer[tx_len] = 0x90; //G_io_apdu_buffer[tx_len-2];
c0d033ec:	9805      	ldr	r0, [sp, #20]
c0d033ee:	300d      	adds	r0, #13
c0d033f0:	497f      	ldr	r1, [pc, #508]	; (c0d035f0 <io_exchange+0x2c8>)
c0d033f2:	5488      	strb	r0, [r1, r2]
c0d033f4:	1888      	adds	r0, r1, r2
            G_io_apdu_buffer[tx_len+1] = 0x00; //G_io_apdu_buffer[tx_len-1];
c0d033f6:	9b02      	ldr	r3, [sp, #8]
c0d033f8:	7043      	strb	r3, [r0, #1]
            tx_len += 2;
c0d033fa:	1c92      	adds	r2, r2, #2
            os_memmove(G_io_apdu_buffer+5, G_io_apdu_buffer, tx_len);
c0d033fc:	9801      	ldr	r0, [sp, #4]
c0d033fe:	4002      	ands	r2, r0
c0d03400:	1d48      	adds	r0, r1, #5
c0d03402:	f7ff fcd3 	bl	c0d02dac <os_memmove>
c0d03406:	2205      	movs	r2, #5
            // zeroize user presence and counter
            os_memset(G_io_apdu_buffer, 0, 5);
c0d03408:	4879      	ldr	r0, [pc, #484]	; (c0d035f0 <io_exchange+0x2c8>)
c0d0340a:	9902      	ldr	r1, [sp, #8]
c0d0340c:	f7ff fce9 	bl	c0d02de2 <os_memset>
            u2f_message_reply(&G_io_u2f, U2F_CMD_MSG, G_io_apdu_buffer, tx_len+5);
c0d03410:	b2a3      	uxth	r3, r4
c0d03412:	4876      	ldr	r0, [pc, #472]	; (c0d035ec <io_exchange+0x2c4>)
c0d03414:	9905      	ldr	r1, [sp, #20]
c0d03416:	4a76      	ldr	r2, [pc, #472]	; (c0d035f0 <io_exchange+0x2c8>)
c0d03418:	f001 fabe 	bl	c0d04998 <u2f_message_reply>
c0d0341c:	e03f      	b.n	c0d0349e <io_exchange+0x176>
c0d0341e:	280a      	cmp	r0, #10
c0d03420:	d00a      	beq.n	c0d03438 <io_exchange+0x110>
c0d03422:	280b      	cmp	r0, #11
c0d03424:	d123      	bne.n	c0d0346e <io_exchange+0x146>
            io_usb_ccid_reply(G_io_apdu_buffer, tx_len);
            goto break_send;
#endif // HAVE_USB_CLASS_CCID
#ifdef HAVE_WEBUSB
          case APDU_USB_WEBUSB:
            io_usb_hid_send(io_usb_send_apdu_data_ep0x83, tx_len);
c0d03426:	487c      	ldr	r0, [pc, #496]	; (c0d03618 <io_exchange+0x2f0>)
c0d03428:	4478      	add	r0, pc
c0d0342a:	e001      	b.n	c0d03430 <io_exchange+0x108>
            goto break_send;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_send(io_usb_send_apdu_data, tx_len);
c0d0342c:	4879      	ldr	r0, [pc, #484]	; (c0d03614 <io_exchange+0x2ec>)
c0d0342e:	4478      	add	r0, pc
c0d03430:	4611      	mov	r1, r2
c0d03432:	f000 fa35 	bl	c0d038a0 <io_usb_hid_send>
c0d03436:	e032      	b.n	c0d0349e <io_exchange+0x176>
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
            break;

          case APDU_RAW:
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d03438:	486e      	ldr	r0, [pc, #440]	; (c0d035f4 <io_exchange+0x2cc>)
c0d0343a:	9902      	ldr	r1, [sp, #8]
c0d0343c:	4008      	ands	r0, r1
c0d0343e:	0840      	lsrs	r0, r0, #1
c0d03440:	28a9      	cmp	r0, #169	; 0xa9
c0d03442:	d300      	bcc.n	c0d03446 <io_exchange+0x11e>
c0d03444:	e0c9      	b.n	c0d035da <io_exchange+0x2b2>
              THROW(INVALID_PARAMETER);
            }
            // reply the RAW APDU over SEPROXYHAL protocol
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d03446:	2053      	movs	r0, #83	; 0x53
c0d03448:	7038      	strb	r0, [r7, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d0344a:	0a10      	lsrs	r0, r2, #8
c0d0344c:	7078      	strb	r0, [r7, #1]
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d0344e:	70b9      	strb	r1, [r7, #2]
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d03450:	2103      	movs	r1, #3
c0d03452:	4638      	mov	r0, r7
c0d03454:	4614      	mov	r4, r2
c0d03456:	f000 fb7b 	bl	c0d03b50 <io_seph_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d0345a:	4865      	ldr	r0, [pc, #404]	; (c0d035f0 <io_exchange+0x2c8>)
c0d0345c:	4621      	mov	r1, r4
c0d0345e:	f000 fb77 	bl	c0d03b50 <io_seph_send>

            // isngle packet reply, mark immediate idle
            G_io_app.apdu_state = APDU_IDLE;
c0d03462:	2000      	movs	r0, #0
c0d03464:	7028      	strb	r0, [r5, #0]
c0d03466:	e01d      	b.n	c0d034a4 <io_exchange+0x17c>
c0d03468:	2800      	cmp	r0, #0
c0d0346a:	d100      	bne.n	c0d0346e <io_exchange+0x146>
c0d0346c:	e0b2      	b.n	c0d035d4 <io_exchange+0x2ac>
      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_app.apdu_state) {
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d0346e:	b2e0      	uxtb	r0, r4
c0d03470:	4611      	mov	r1, r2
c0d03472:	f7fd f99b 	bl	c0d007ac <io_exchange_al>
c0d03476:	2800      	cmp	r0, #0
c0d03478:	d011      	beq.n	c0d0349e <io_exchange+0x176>
c0d0347a:	e0ab      	b.n	c0d035d4 <io_exchange+0x2ac>
        // TODO: add timeout here to avoid spending too much time when host has disconnected
        while (G_io_app.apdu_state != APDU_IDLE) {
#ifdef HAVE_TINY_COROUTINE
          tcr_yield();
#else // HAVE_TINY_COROUTINE
          io_seproxyhal_general_status();
c0d0347c:	f7ff fcd8 	bl	c0d02e30 <io_seproxyhal_general_status>
          do {
            io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d03480:	2180      	movs	r1, #128	; 0x80
c0d03482:	2200      	movs	r2, #0
c0d03484:	4638      	mov	r0, r7
c0d03486:	f000 fb7b 	bl	c0d03b80 <io_seph_recv>
            // check for reply timeout (when asynch reply (over hid or u2f for example))
            // this case shall be covered by usb_ep_timeout but is not, investigate that
            if (G_io_app.ms >= timeout_ms) {
c0d0348a:	68a8      	ldr	r0, [r5, #8]
c0d0348c:	42b0      	cmp	r0, r6
c0d0348e:	d300      	bcc.n	c0d03492 <io_exchange+0x16a>
c0d03490:	e09d      	b.n	c0d035ce <io_exchange+0x2a6>
              THROW(EXCEPTION_IO_RESET);
            }
            // avoid a general status to be replied
            io_seproxyhal_handle_event();
c0d03492:	f7ff fdb3 	bl	c0d02ffc <io_seproxyhal_handle_event>
          } while (io_seproxyhal_spi_is_status_sent());
c0d03496:	f000 fb67 	bl	c0d03b68 <io_seph_is_status_sent>
c0d0349a:	2800      	cmp	r0, #0
c0d0349c:	d1f0      	bne.n	c0d03480 <io_exchange+0x158>
c0d0349e:	7828      	ldrb	r0, [r5, #0]
c0d034a0:	2800      	cmp	r0, #0
c0d034a2:	d1eb      	bne.n	c0d0347c <io_exchange+0x154>
c0d034a4:	2000      	movs	r0, #0
#endif // HAVE_TINY_COROUTINE
        }
        // reset apdu state
        G_io_app.apdu_state = APDU_IDLE;
c0d034a6:	7028      	strb	r0, [r5, #0]
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d034a8:	71a8      	strb	r0, [r5, #6]

        G_io_app.apdu_length = 0;
c0d034aa:	8068      	strh	r0, [r5, #2]
c0d034ac:	9e07      	ldr	r6, [sp, #28]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d034ae:	06b1      	lsls	r1, r6, #26
c0d034b0:	d500      	bpl.n	c0d034b4 <io_exchange+0x18c>
c0d034b2:	e745      	b.n	c0d03340 <io_exchange+0x18>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d034b4:	f7ff fcbc 	bl	c0d02e30 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d034b8:	0630      	lsls	r0, r6, #24
c0d034ba:	9806      	ldr	r0, [sp, #24]
c0d034bc:	9903      	ldr	r1, [sp, #12]
c0d034be:	d506      	bpl.n	c0d034ce <io_exchange+0x1a6>
#define SYSCALL_os_sched_exit_ID_IN 0x60009abeUL
#define SYSCALL_os_sched_exit_ID_OUT 0x90009adeUL
__attribute__((always_inline)) inline void
os_sched_exit_inline(bolos_task_status_t exit_code) {
  volatile unsigned int parameters[2 + 1];
  parameters[0] = (unsigned int)exit_code;
c0d034c0:	9108      	str	r1, [sp, #32]
c0d034c2:	aa08      	add	r2, sp, #32
  __asm volatile("mov r0, %1\n"
c0d034c4:	4b4c      	ldr	r3, [pc, #304]	; (c0d035f8 <io_exchange+0x2d0>)
c0d034c6:	4618      	mov	r0, r3
c0d034c8:	4611      	mov	r1, r2
c0d034ca:	df01      	svc	1
c0d034cc:	9806      	ldr	r0, [sp, #24]
        //reset();
      }
    }

#ifndef HAVE_TINY_COROUTINE
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d034ce:	2800      	cmp	r0, #0
c0d034d0:	d104      	bne.n	c0d034dc <io_exchange+0x1b4>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d034d2:	0670      	lsls	r0, r6, #25
c0d034d4:	d474      	bmi.n	c0d035c0 <io_exchange+0x298>
        // return apdu data - header
        return G_io_app.apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_app.apdu_state = APDU_IDLE;
c0d034d6:	2000      	movs	r0, #0
c0d034d8:	7028      	strb	r0, [r5, #0]
      G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d034da:	71a8      	strb	r0, [r5, #6]
c0d034dc:	2000      	movs	r0, #0
c0d034de:	8068      	strh	r0, [r5, #2]
#ifdef HAVE_TINY_COROUTINE
      // give back hand to the seph task which interprets all incoming events first
      tcr_yield();
#else // HAVE_TINY_COROUTINE

      if (!io_seproxyhal_spi_is_status_sent()) {
c0d034e0:	f000 fb42 	bl	c0d03b68 <io_seph_is_status_sent>
c0d034e4:	2800      	cmp	r0, #0
c0d034e6:	d101      	bne.n	c0d034ec <io_exchange+0x1c4>
        io_seproxyhal_general_status();
c0d034e8:	f7ff fca2 	bl	c0d02e30 <io_seproxyhal_general_status>
      }
      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d034ec:	2480      	movs	r4, #128	; 0x80
c0d034ee:	2600      	movs	r6, #0
c0d034f0:	4638      	mov	r0, r7
c0d034f2:	4621      	mov	r1, r4
c0d034f4:	4632      	mov	r2, r6
c0d034f6:	f000 fb43 	bl	c0d03b80 <io_seph_recv>

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
c0d034fa:	2802      	cmp	r0, #2
c0d034fc:	d806      	bhi.n	c0d0350c <io_exchange+0x1e4>
c0d034fe:	78b9      	ldrb	r1, [r7, #2]
c0d03500:	787a      	ldrb	r2, [r7, #1]
c0d03502:	0212      	lsls	r2, r2, #8
c0d03504:	430a      	orrs	r2, r1
c0d03506:	1cd1      	adds	r1, r2, #3
c0d03508:	4288      	cmp	r0, r1
c0d0350a:	d108      	bne.n	c0d0351e <io_exchange+0x1f6>
        G_io_app.apdu_state = APDU_IDLE;
        G_io_app.apdu_length = 0;
        continue;
      }

      io_seproxyhal_handle_event();
c0d0350c:	f7ff fd76 	bl	c0d02ffc <io_seproxyhal_handle_event>
#endif // HAVE_TINY_COROUTINE

      // an apdu has been received asynchroneously, return it
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
c0d03510:	8868      	ldrh	r0, [r5, #2]
c0d03512:	7829      	ldrb	r1, [r5, #0]
c0d03514:	2900      	cmp	r1, #0
c0d03516:	d0e3      	beq.n	c0d034e0 <io_exchange+0x1b8>
c0d03518:	2800      	cmp	r0, #0
c0d0351a:	d0e1      	beq.n	c0d034e0 <io_exchange+0x1b8>
c0d0351c:	e002      	b.n	c0d03524 <io_exchange+0x1fc>
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // can't process split TLV, continue
      if (rx_len < 3 && rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
        LOG("invalid TLV format\n");
        G_io_app.apdu_state = APDU_IDLE;
c0d0351e:	2000      	movs	r0, #0
c0d03520:	7028      	strb	r0, [r5, #0]
c0d03522:	e7db      	b.n	c0d034dc <io_exchange+0x1b4>
      // an apdu has been received asynchroneously, return it
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
#ifndef HAVE_BOLOS_NO_DEFAULT_APDU
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
c0d03524:	2204      	movs	r2, #4
c0d03526:	4832      	ldr	r0, [pc, #200]	; (c0d035f0 <io_exchange+0x2c8>)
c0d03528:	a134      	add	r1, pc, #208	; (adr r1, c0d035fc <io_exchange+0x2d4>)
c0d0352a:	f7ff fc63 	bl	c0d02df4 <os_memcmp>
c0d0352e:	2800      	cmp	r0, #0
c0d03530:	d02d      	beq.n	c0d0358e <io_exchange+0x266>
          // disable 'return after tx' and 'asynch reply' flags
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
c0d03532:	2204      	movs	r2, #4
c0d03534:	482e      	ldr	r0, [pc, #184]	; (c0d035f0 <io_exchange+0x2c8>)
c0d03536:	a133      	add	r1, pc, #204	; (adr r1, c0d03604 <io_exchange+0x2dc>)
c0d03538:	f7ff fc5c 	bl	c0d02df4 <os_memcmp>
c0d0353c:	2800      	cmp	r0, #0
c0d0353e:	d017      	beq.n	c0d03570 <io_exchange+0x248>
        }
#ifndef BOLOS_OS_UPGRADER
        // seed cookie
        // host: <nothing>
        // device: <format(1B)> <len(1B)> <seed magic cookie if pin is entered(len)> 9000 | 6985
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\x02\x00\x00", 4) == 0) {
c0d03540:	2204      	movs	r2, #4
c0d03542:	482b      	ldr	r0, [pc, #172]	; (c0d035f0 <io_exchange+0x2c8>)
c0d03544:	a131      	add	r1, pc, #196	; (adr r1, c0d0360c <io_exchange+0x2e4>)
c0d03546:	f7ff fc55 	bl	c0d02df4 <os_memcmp>
c0d0354a:	2800      	cmp	r0, #0
c0d0354c:	d13d      	bne.n	c0d035ca <io_exchange+0x2a2>
          tx_len = 0;
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
c0d0354e:	9805      	ldr	r0, [sp, #20]
c0d03550:	3027      	adds	r0, #39	; 0x27
c0d03552:	b2c4      	uxtb	r4, r0
c0d03554:	f000 fab2 	bl	c0d03abc <os_global_pin_is_validated>
c0d03558:	42a0      	cmp	r0, r4
c0d0355a:	d01d      	beq.n	c0d03598 <io_exchange+0x270>
            tx_len += i;
            G_io_apdu_buffer[tx_len++] = 0x90;
            G_io_apdu_buffer[tx_len++] = 0x00;
          }
          else {
            G_io_apdu_buffer[tx_len++] = 0x69;
c0d0355c:	2069      	movs	r0, #105	; 0x69
c0d0355e:	4924      	ldr	r1, [pc, #144]	; (c0d035f0 <io_exchange+0x2c8>)
c0d03560:	7008      	strb	r0, [r1, #0]
            G_io_apdu_buffer[tx_len++] = 0x85;
c0d03562:	9805      	ldr	r0, [sp, #20]
c0d03564:	1c80      	adds	r0, r0, #2
c0d03566:	7048      	strb	r0, [r1, #1]
c0d03568:	2302      	movs	r3, #2
c0d0356a:	4630      	mov	r0, r6
c0d0356c:	4634      	mov	r4, r6
c0d0356e:	e6f2      	b.n	c0d03356 <io_exchange+0x2e>
          goto reply_apdu; 
        }
        // exit app after replied
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\xA7\x00\x00", 4) == 0) {
          tx_len = 0;
          G_io_apdu_buffer[tx_len++] = 0x90;
c0d03570:	9805      	ldr	r0, [sp, #20]
c0d03572:	300d      	adds	r0, #13
c0d03574:	491e      	ldr	r1, [pc, #120]	; (c0d035f0 <io_exchange+0x2c8>)
c0d03576:	7008      	strb	r0, [r1, #0]
c0d03578:	2000      	movs	r0, #0
          G_io_apdu_buffer[tx_len++] = 0x00;
c0d0357a:	7048      	strb	r0, [r1, #1]
c0d0357c:	9907      	ldr	r1, [sp, #28]
          // exit app after replied
          channel |= IO_RESET_AFTER_REPLIED;
c0d0357e:	430c      	orrs	r4, r1
c0d03580:	2302      	movs	r3, #2
  }
  after_debug:
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d03582:	9800      	ldr	r0, [sp, #0]
c0d03584:	4201      	tst	r1, r0
c0d03586:	4626      	mov	r6, r4
c0d03588:	d100      	bne.n	c0d0358c <io_exchange+0x264>
c0d0358a:	e6e4      	b.n	c0d03356 <io_exchange+0x2e>
c0d0358c:	e6d4      	b.n	c0d03338 <io_exchange+0x10>
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
#ifndef HAVE_BOLOS_NO_DEFAULT_APDU
        // handle reserved apdus
        // get name and version
        if (os_memcmp(G_io_apdu_buffer, "\xB0\x01\x00\x00", 4) == 0) {
          tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d0358e:	f7ff fea7 	bl	c0d032e0 <os_io_seproxyhal_get_app_name_and_version>
c0d03592:	4603      	mov	r3, r0
c0d03594:	2600      	movs	r6, #0
c0d03596:	e6dd      	b.n	c0d03354 <io_exchange+0x2c>
c0d03598:	2001      	movs	r0, #1
c0d0359a:	4c15      	ldr	r4, [pc, #84]	; (c0d035f0 <io_exchange+0x2c8>)
        else if (os_memcmp(G_io_apdu_buffer, "\xB0\x02\x00\x00", 4) == 0) {
          tx_len = 0;
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
            unsigned int i;
            // format
            G_io_apdu_buffer[tx_len++] = 0x01;
c0d0359c:	7020      	strb	r0, [r4, #0]

#ifndef HAVE_BOLOS
            i = os_perso_seed_cookie(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
c0d0359e:	1ca0      	adds	r0, r4, #2
c0d035a0:	2140      	movs	r1, #64	; 0x40
c0d035a2:	f000 fa7d 	bl	c0d03aa0 <os_perso_seed_cookie>
#else
            i = os_perso_seed_cookie_os(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
#endif // HAVE_BOLOS

            G_io_apdu_buffer[tx_len++] = i;
c0d035a6:	7060      	strb	r0, [r4, #1]
            tx_len += i;
c0d035a8:	1c81      	adds	r1, r0, #2
c0d035aa:	9b01      	ldr	r3, [sp, #4]
            G_io_apdu_buffer[tx_len++] = 0x90;
c0d035ac:	4019      	ands	r1, r3
c0d035ae:	9a05      	ldr	r2, [sp, #20]
c0d035b0:	320d      	adds	r2, #13
c0d035b2:	5462      	strb	r2, [r4, r1]
c0d035b4:	1cc1      	adds	r1, r0, #3
            G_io_apdu_buffer[tx_len++] = 0x00;
c0d035b6:	4019      	ands	r1, r3
c0d035b8:	2600      	movs	r6, #0
c0d035ba:	5466      	strb	r6, [r4, r1]
c0d035bc:	1d03      	adds	r3, r0, #4
c0d035be:	e6c9      	b.n	c0d03354 <io_exchange+0x2c>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_app.apdu_length-5;
c0d035c0:	8868      	ldrh	r0, [r5, #2]
c0d035c2:	9901      	ldr	r1, [sp, #4]
c0d035c4:	1840      	adds	r0, r0, r1
c0d035c6:	1f00      	subs	r0, r0, #4
c0d035c8:	e6ba      	b.n	c0d03340 <io_exchange+0x18>
          channel &= ~IO_FLAGS;
          goto reply_apdu; 
        }
#endif // BOLOS_OS_UPGRADER
#endif // HAVE_BOLOS_NO_DEFAULT_APDU
        return G_io_app.apdu_length;
c0d035ca:	8868      	ldrh	r0, [r5, #2]
c0d035cc:	e6b8      	b.n	c0d03340 <io_exchange+0x18>
c0d035ce:	2010      	movs	r0, #16
c0d035d0:	f7ff fc27 	bl	c0d02e22 <os_longjmp>
              goto break_send;
            }
            __attribute__((fallthrough));
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d035d4:	2009      	movs	r0, #9
c0d035d6:	f7ff fc24 	bl	c0d02e22 <os_longjmp>
c0d035da:	2002      	movs	r0, #2
c0d035dc:	f7ff fc21 	bl	c0d02e22 <os_longjmp>
c0d035e0:	0000ffff 	.word	0x0000ffff
c0d035e4:	20001df0 	.word	0x20001df0
c0d035e8:	20002110 	.word	0x20002110
c0d035ec:	20002130 	.word	0x20002130
c0d035f0:	20001fbc 	.word	0x20001fbc
c0d035f4:	0000fffe 	.word	0x0000fffe
c0d035f8:	60009abe 	.word	0x60009abe
c0d035fc:	000001b0 	.word	0x000001b0
c0d03600:	00000000 	.word	0x00000000
c0d03604:	0000a7b0 	.word	0x0000a7b0
c0d03608:	00000000 	.word	0x00000000
c0d0360c:	000002b0 	.word	0x000002b0
c0d03610:	00000000 	.word	0x00000000
c0d03614:	fffffb6f 	.word	0xfffffb6f
c0d03618:	fffffb85 	.word	0xfffffb85

c0d0361c <os_io_seph_recv_and_process>:
  default:
    return io_exchange_al(channel, tx_len);
  }
}

unsigned int os_io_seph_recv_and_process(unsigned int dont_process_ux_events) {
c0d0361c:	b570      	push	{r4, r5, r6, lr}
c0d0361e:	4604      	mov	r4, r0
  // send general status before receiving next event
  if (!io_seproxyhal_spi_is_status_sent()) {
c0d03620:	f000 faa2 	bl	c0d03b68 <io_seph_is_status_sent>
c0d03624:	2800      	cmp	r0, #0
c0d03626:	d101      	bne.n	c0d0362c <os_io_seph_recv_and_process+0x10>
    io_seproxyhal_general_status();
c0d03628:	f7ff fc02 	bl	c0d02e30 <io_seproxyhal_general_status>
  }

  io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d0362c:	4e0c      	ldr	r6, [pc, #48]	; (c0d03660 <os_io_seph_recv_and_process+0x44>)
c0d0362e:	2180      	movs	r1, #128	; 0x80
c0d03630:	2500      	movs	r5, #0
c0d03632:	4630      	mov	r0, r6
c0d03634:	462a      	mov	r2, r5
c0d03636:	f000 faa3 	bl	c0d03b80 <io_seph_recv>

  switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0363a:	7830      	ldrb	r0, [r6, #0]
c0d0363c:	2815      	cmp	r0, #21
c0d0363e:	d806      	bhi.n	c0d0364e <os_io_seph_recv_and_process+0x32>
c0d03640:	2101      	movs	r1, #1
c0d03642:	4081      	lsls	r1, r0
c0d03644:	4807      	ldr	r0, [pc, #28]	; (c0d03664 <os_io_seph_recv_and_process+0x48>)
c0d03646:	4201      	tst	r1, r0
c0d03648:	d001      	beq.n	c0d0364e <os_io_seph_recv_and_process+0x32>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
    case SEPROXYHAL_TAG_TICKER_EVENT:
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
    case SEPROXYHAL_TAG_STATUS_EVENT:
      // perform UX event on these ones, don't process as an IO event
      if (dont_process_ux_events) {
c0d0364a:	2c00      	cmp	r4, #0
c0d0364c:	d105      	bne.n	c0d0365a <os_io_seph_recv_and_process+0x3e>
      }
      __attribute__((fallthrough));

    default:
      // if malformed, then a stall is likely to occur
      if (io_seproxyhal_handle_event()) {
c0d0364e:	f7ff fcd5 	bl	c0d02ffc <io_seproxyhal_handle_event>
        return 1;
      }
  }
  return 0;
c0d03652:	2501      	movs	r5, #1
c0d03654:	2800      	cmp	r0, #0
c0d03656:	d100      	bne.n	c0d0365a <os_io_seph_recv_and_process+0x3e>
c0d03658:	4605      	mov	r5, r0
}
c0d0365a:	4628      	mov	r0, r5
c0d0365c:	bd70      	pop	{r4, r5, r6, pc}
c0d0365e:	46c0      	nop			; (mov r8, r8)
c0d03660:	20001df0 	.word	0x20001df0
c0d03664:	00207020 	.word	0x00207020

c0d03668 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d03668:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0366a:	b081      	sub	sp, #4
c0d0366c:	9200      	str	r2, [sp, #0]
c0d0366e:	460f      	mov	r7, r1
c0d03670:	4605      	mov	r5, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d03672:	4c4c      	ldr	r4, [pc, #304]	; (c0d037a4 <io_usb_hid_receive+0x13c>)
c0d03674:	42a7      	cmp	r7, r4
c0d03676:	d010      	beq.n	c0d0369a <io_usb_hid_receive+0x32>
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d03678:	4c4a      	ldr	r4, [pc, #296]	; (c0d037a4 <io_usb_hid_receive+0x13c>)
c0d0367a:	2100      	movs	r1, #0
c0d0367c:	2640      	movs	r6, #64	; 0x40
c0d0367e:	4620      	mov	r0, r4
c0d03680:	4632      	mov	r2, r6
c0d03682:	f7ff fbae 	bl	c0d02de2 <os_memset>
c0d03686:	9800      	ldr	r0, [sp, #0]
    os_memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d03688:	2840      	cmp	r0, #64	; 0x40
c0d0368a:	4602      	mov	r2, r0
c0d0368c:	d300      	bcc.n	c0d03690 <io_usb_hid_receive+0x28>
c0d0368e:	4632      	mov	r2, r6
c0d03690:	4620      	mov	r0, r4
c0d03692:	4639      	mov	r1, r7
c0d03694:	f7ff fb8a 	bl	c0d02dac <os_memmove>
c0d03698:	4c42      	ldr	r4, [pc, #264]	; (c0d037a4 <io_usb_hid_receive+0x13c>)
c0d0369a:	78a0      	ldrb	r0, [r4, #2]
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d0369c:	2801      	cmp	r0, #1
c0d0369e:	dc0a      	bgt.n	c0d036b6 <io_usb_hid_receive+0x4e>
c0d036a0:	2800      	cmp	r0, #0
c0d036a2:	d02b      	beq.n	c0d036fc <io_usb_hid_receive+0x94>
c0d036a4:	2801      	cmp	r0, #1
c0d036a6:	d16b      	bne.n	c0d03780 <io_usb_hid_receive+0x118>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_usb_ep_buffer+3, 4);
c0d036a8:	1ce0      	adds	r0, r4, #3
c0d036aa:	2104      	movs	r1, #4
c0d036ac:	f000 f94e 	bl	c0d0394c <cx_rng>
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d036b0:	2140      	movs	r1, #64	; 0x40
c0d036b2:	4620      	mov	r0, r4
c0d036b4:	e02e      	b.n	c0d03714 <io_usb_hid_receive+0xac>
c0d036b6:	2802      	cmp	r0, #2
c0d036b8:	d02a      	beq.n	c0d03710 <io_usb_hid_receive+0xa8>
c0d036ba:	2805      	cmp	r0, #5
c0d036bc:	d160      	bne.n	c0d03780 <io_usb_hid_receive+0x118>

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d036be:	7920      	ldrb	r0, [r4, #4]
c0d036c0:	78e1      	ldrb	r1, [r4, #3]
c0d036c2:	0209      	lsls	r1, r1, #8
c0d036c4:	4301      	orrs	r1, r0
c0d036c6:	4a38      	ldr	r2, [pc, #224]	; (c0d037a8 <io_usb_hid_receive+0x140>)
c0d036c8:	6810      	ldr	r0, [r2, #0]
c0d036ca:	2700      	movs	r7, #0
c0d036cc:	4281      	cmp	r1, r0
c0d036ce:	d15d      	bne.n	c0d0378c <io_usb_hid_receive+0x124>
c0d036d0:	4623      	mov	r3, r4
c0d036d2:	4e36      	ldr	r6, [pc, #216]	; (c0d037ac <io_usb_hid_receive+0x144>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d036d4:	9800      	ldr	r0, [sp, #0]
c0d036d6:	1980      	adds	r0, r0, r6
c0d036d8:	1f04      	subs	r4, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d036da:	6810      	ldr	r0, [r2, #0]
c0d036dc:	2800      	cmp	r0, #0
c0d036de:	d01c      	beq.n	c0d0371a <io_usb_hid_receive+0xb2>
c0d036e0:	4617      	mov	r7, r2
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d036e2:	4621      	mov	r1, r4
c0d036e4:	4031      	ands	r1, r6
c0d036e6:	4832      	ldr	r0, [pc, #200]	; (c0d037b0 <io_usb_hid_receive+0x148>)
c0d036e8:	6802      	ldr	r2, [r0, #0]
c0d036ea:	4291      	cmp	r1, r2
c0d036ec:	d900      	bls.n	c0d036f0 <io_usb_hid_receive+0x88>
        l = G_io_usb_hid_remaining_length;
c0d036ee:	6804      	ldr	r4, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d036f0:	4622      	mov	r2, r4
c0d036f2:	4032      	ands	r2, r6
c0d036f4:	482f      	ldr	r0, [pc, #188]	; (c0d037b4 <io_usb_hid_receive+0x14c>)
c0d036f6:	6800      	ldr	r0, [r0, #0]
c0d036f8:	1d59      	adds	r1, r3, #5
c0d036fa:	e033      	b.n	c0d03764 <io_usb_hid_receive+0xfc>
    G_io_usb_hid_sequence_number++;
    break;

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
c0d036fc:	1ce0      	adds	r0, r4, #3
c0d036fe:	2700      	movs	r7, #0
c0d03700:	2204      	movs	r2, #4
c0d03702:	4639      	mov	r1, r7
c0d03704:	f7ff fb6d 	bl	c0d02de2 <os_memset>
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d03708:	2140      	movs	r1, #64	; 0x40
c0d0370a:	4620      	mov	r0, r4
c0d0370c:	47a8      	blx	r5
c0d0370e:	e03d      	b.n	c0d0378c <io_usb_hid_receive+0x124>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_usb_ep_buffer, IO_HID_EP_LENGTH);
c0d03710:	4824      	ldr	r0, [pc, #144]	; (c0d037a4 <io_usb_hid_receive+0x13c>)
c0d03712:	2140      	movs	r1, #64	; 0x40
c0d03714:	47a8      	blx	r5
c0d03716:	2700      	movs	r7, #0
c0d03718:	e038      	b.n	c0d0378c <io_usb_hid_receive+0x124>
c0d0371a:	461c      	mov	r4, r3
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d0371c:	79a0      	ldrb	r0, [r4, #6]
c0d0371e:	7961      	ldrb	r1, [r4, #5]
c0d03720:	0209      	lsls	r1, r1, #8
c0d03722:	4301      	orrs	r1, r0
c0d03724:	4824      	ldr	r0, [pc, #144]	; (c0d037b8 <io_usb_hid_receive+0x150>)
c0d03726:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d03728:	6801      	ldr	r1, [r0, #0]
c0d0372a:	0849      	lsrs	r1, r1, #1
c0d0372c:	29a8      	cmp	r1, #168	; 0xa8
c0d0372e:	d82d      	bhi.n	c0d0378c <io_usb_hid_receive+0x124>
c0d03730:	4617      	mov	r7, r2
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d03732:	6801      	ldr	r1, [r0, #0]
c0d03734:	481e      	ldr	r0, [pc, #120]	; (c0d037b0 <io_usb_hid_receive+0x148>)
c0d03736:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d03738:	491e      	ldr	r1, [pc, #120]	; (c0d037b4 <io_usb_hid_receive+0x14c>)
c0d0373a:	4a20      	ldr	r2, [pc, #128]	; (c0d037bc <io_usb_hid_receive+0x154>)
c0d0373c:	600a      	str	r2, [r1, #0]

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d0373e:	7861      	ldrb	r1, [r4, #1]
c0d03740:	7822      	ldrb	r2, [r4, #0]
c0d03742:	0212      	lsls	r2, r2, #8
c0d03744:	430a      	orrs	r2, r1
c0d03746:	491e      	ldr	r1, [pc, #120]	; (c0d037c0 <io_usb_hid_receive+0x158>)
c0d03748:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d0374a:	491e      	ldr	r1, [pc, #120]	; (c0d037c4 <io_usb_hid_receive+0x15c>)
c0d0374c:	9a00      	ldr	r2, [sp, #0]
c0d0374e:	1854      	adds	r4, r2, r1
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      // retain the channel id to use for the reply
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);

      if (l > G_io_usb_hid_remaining_length) {
c0d03750:	4621      	mov	r1, r4
c0d03752:	4031      	ands	r1, r6
c0d03754:	6802      	ldr	r2, [r0, #0]
c0d03756:	4291      	cmp	r1, r2
c0d03758:	d900      	bls.n	c0d0375c <io_usb_hid_receive+0xf4>
        l = G_io_usb_hid_remaining_length;
c0d0375a:	6804      	ldr	r4, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d0375c:	4622      	mov	r2, r4
c0d0375e:	4032      	ands	r2, r6
c0d03760:	1dd9      	adds	r1, r3, #7
c0d03762:	4816      	ldr	r0, [pc, #88]	; (c0d037bc <io_usb_hid_receive+0x154>)
c0d03764:	f7ff fb22 	bl	c0d02dac <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d03768:	4034      	ands	r4, r6
c0d0376a:	4812      	ldr	r0, [pc, #72]	; (c0d037b4 <io_usb_hid_receive+0x14c>)
c0d0376c:	6801      	ldr	r1, [r0, #0]
c0d0376e:	1909      	adds	r1, r1, r4
c0d03770:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d03772:	480f      	ldr	r0, [pc, #60]	; (c0d037b0 <io_usb_hid_receive+0x148>)
c0d03774:	6801      	ldr	r1, [r0, #0]
c0d03776:	1b09      	subs	r1, r1, r4
c0d03778:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d0377a:	6838      	ldr	r0, [r7, #0]
c0d0377c:	1c40      	adds	r0, r0, #1
c0d0377e:	6038      	str	r0, [r7, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d03780:	480b      	ldr	r0, [pc, #44]	; (c0d037b0 <io_usb_hid_receive+0x148>)
c0d03782:	6801      	ldr	r1, [r0, #0]
c0d03784:	2001      	movs	r0, #1
c0d03786:	2702      	movs	r7, #2
c0d03788:	2900      	cmp	r1, #0
c0d0378a:	d107      	bne.n	c0d0379c <io_usb_hid_receive+0x134>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0378c:	4806      	ldr	r0, [pc, #24]	; (c0d037a8 <io_usb_hid_receive+0x140>)
c0d0378e:	2100      	movs	r1, #0
c0d03790:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d03792:	4807      	ldr	r0, [pc, #28]	; (c0d037b0 <io_usb_hid_receive+0x148>)
c0d03794:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_current_buffer = NULL;
c0d03796:	4807      	ldr	r0, [pc, #28]	; (c0d037b4 <io_usb_hid_receive+0x14c>)
c0d03798:	6001      	str	r1, [r0, #0]
c0d0379a:	4638      	mov	r0, r7
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d0379c:	b2c0      	uxtb	r0, r0
c0d0379e:	b001      	add	sp, #4
c0d037a0:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d037a2:	46c0      	nop			; (mov r8, r8)
c0d037a4:	20002174 	.word	0x20002174
c0d037a8:	200021b4 	.word	0x200021b4
c0d037ac:	0000ffff 	.word	0x0000ffff
c0d037b0:	200021bc 	.word	0x200021bc
c0d037b4:	200021c0 	.word	0x200021c0
c0d037b8:	200021b8 	.word	0x200021b8
c0d037bc:	20001fbc 	.word	0x20001fbc
c0d037c0:	200021c4 	.word	0x200021c4
c0d037c4:	0001fff9 	.word	0x0001fff9

c0d037c8 <io_usb_hid_init>:

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d037c8:	4803      	ldr	r0, [pc, #12]	; (c0d037d8 <io_usb_hid_init+0x10>)
c0d037ca:	2100      	movs	r1, #0
c0d037cc:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d037ce:	4803      	ldr	r0, [pc, #12]	; (c0d037dc <io_usb_hid_init+0x14>)
c0d037d0:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_current_buffer = NULL;
c0d037d2:	4803      	ldr	r0, [pc, #12]	; (c0d037e0 <io_usb_hid_init+0x18>)
c0d037d4:	6001      	str	r1, [r0, #0]
}
c0d037d6:	4770      	bx	lr
c0d037d8:	200021b4 	.word	0x200021b4
c0d037dc:	200021bc 	.word	0x200021bc
c0d037e0:	200021c0 	.word	0x200021c0

c0d037e4 <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d037e4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d037e6:	b081      	sub	sp, #4
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
c0d037e8:	4f27      	ldr	r7, [pc, #156]	; (c0d03888 <io_usb_hid_sent+0xa4>)
c0d037ea:	6839      	ldr	r1, [r7, #0]
c0d037ec:	4a27      	ldr	r2, [pc, #156]	; (c0d0388c <io_usb_hid_sent+0xa8>)
c0d037ee:	2900      	cmp	r1, #0
c0d037f0:	d023      	beq.n	c0d0383a <io_usb_hid_sent+0x56>
c0d037f2:	6811      	ldr	r1, [r2, #0]
c0d037f4:	2900      	cmp	r1, #0
c0d037f6:	d020      	beq.n	c0d0383a <io_usb_hid_sent+0x56>
c0d037f8:	9000      	str	r0, [sp, #0]
    // fill the chunk
    os_memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d037fa:	4d27      	ldr	r5, [pc, #156]	; (c0d03898 <io_usb_hid_sent+0xb4>)
c0d037fc:	2100      	movs	r1, #0
c0d037fe:	2240      	movs	r2, #64	; 0x40
c0d03800:	4628      	mov	r0, r5
c0d03802:	f7ff faee 	bl	c0d02de2 <os_memset>

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d03806:	4825      	ldr	r0, [pc, #148]	; (c0d0389c <io_usb_hid_sent+0xb8>)
c0d03808:	6801      	ldr	r1, [r0, #0]
c0d0380a:	0a09      	lsrs	r1, r1, #8
c0d0380c:	7029      	strb	r1, [r5, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d0380e:	6800      	ldr	r0, [r0, #0]
c0d03810:	7068      	strb	r0, [r5, #1]
    G_io_usb_ep_buffer[2] = 0x05;
c0d03812:	2005      	movs	r0, #5
c0d03814:	70a8      	strb	r0, [r5, #2]
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d03816:	4c1e      	ldr	r4, [pc, #120]	; (c0d03890 <io_usb_hid_sent+0xac>)
c0d03818:	6820      	ldr	r0, [r4, #0]
c0d0381a:	0a00      	lsrs	r0, r0, #8
c0d0381c:	70e8      	strb	r0, [r5, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d0381e:	6820      	ldr	r0, [r4, #0]
c0d03820:	7128      	strb	r0, [r5, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d03822:	6821      	ldr	r1, [r4, #0]
c0d03824:	6838      	ldr	r0, [r7, #0]
c0d03826:	2900      	cmp	r1, #0
c0d03828:	d00f      	beq.n	c0d0384a <io_usb_hid_sent+0x66>
c0d0382a:	263b      	movs	r6, #59	; 0x3b
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d0382c:	283b      	cmp	r0, #59	; 0x3b
c0d0382e:	d800      	bhi.n	c0d03832 <io_usb_hid_sent+0x4e>
c0d03830:	683e      	ldr	r6, [r7, #0]
c0d03832:	4816      	ldr	r0, [pc, #88]	; (c0d0388c <io_usb_hid_sent+0xa8>)
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d03834:	6801      	ldr	r1, [r0, #0]
c0d03836:	1d68      	adds	r0, r5, #5
c0d03838:	e013      	b.n	c0d03862 <io_usb_hid_sent+0x7e>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0383a:	4815      	ldr	r0, [pc, #84]	; (c0d03890 <io_usb_hid_sent+0xac>)
c0d0383c:	2100      	movs	r1, #0
c0d0383e:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d03840:	6039      	str	r1, [r7, #0]
  G_io_usb_hid_current_buffer = NULL;
c0d03842:	6011      	str	r1, [r2, #0]
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
c0d03844:	4813      	ldr	r0, [pc, #76]	; (c0d03894 <io_usb_hid_sent+0xb0>)
c0d03846:	7001      	strb	r1, [r0, #0]
c0d03848:	e01c      	b.n	c0d03884 <io_usb_hid_sent+0xa0>
c0d0384a:	2639      	movs	r6, #57	; 0x39
    G_io_usb_ep_buffer[2] = 0x05;
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d0384c:	2839      	cmp	r0, #57	; 0x39
c0d0384e:	d800      	bhi.n	c0d03852 <io_usb_hid_sent+0x6e>
c0d03850:	683e      	ldr	r6, [r7, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d03852:	6838      	ldr	r0, [r7, #0]
c0d03854:	0a00      	lsrs	r0, r0, #8
c0d03856:	7168      	strb	r0, [r5, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d03858:	6838      	ldr	r0, [r7, #0]
c0d0385a:	71a8      	strb	r0, [r5, #6]
c0d0385c:	480b      	ldr	r0, [pc, #44]	; (c0d0388c <io_usb_hid_sent+0xa8>)
      os_memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d0385e:	6801      	ldr	r1, [r0, #0]
c0d03860:	1de8      	adds	r0, r5, #7
c0d03862:	4632      	mov	r2, r6
c0d03864:	f7ff faa2 	bl	c0d02dac <os_memmove>
c0d03868:	4908      	ldr	r1, [pc, #32]	; (c0d0388c <io_usb_hid_sent+0xa8>)
c0d0386a:	9a00      	ldr	r2, [sp, #0]
c0d0386c:	6808      	ldr	r0, [r1, #0]
c0d0386e:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d03870:	6008      	str	r0, [r1, #0]
c0d03872:	6838      	ldr	r0, [r7, #0]
c0d03874:	1b80      	subs	r0, r0, r6
c0d03876:	6038      	str	r0, [r7, #0]
      os_memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;   
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d03878:	6820      	ldr	r0, [r4, #0]
c0d0387a:	1c40      	adds	r0, r0, #1
c0d0387c:	6020      	str	r0, [r4, #0]
    // send the chunk
    // always padded (USB HID transport) :)
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d0387e:	4806      	ldr	r0, [pc, #24]	; (c0d03898 <io_usb_hid_sent+0xb4>)
c0d03880:	2140      	movs	r1, #64	; 0x40
c0d03882:	4790      	blx	r2
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
  }
}
c0d03884:	b001      	add	sp, #4
c0d03886:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03888:	200021bc 	.word	0x200021bc
c0d0388c:	200021c0 	.word	0x200021c0
c0d03890:	200021b4 	.word	0x200021b4
c0d03894:	20002110 	.word	0x20002110
c0d03898:	20002174 	.word	0x20002174
c0d0389c:	200021c4 	.word	0x200021c4

c0d038a0 <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d038a0:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d038a2:	2900      	cmp	r1, #0
c0d038a4:	d00b      	beq.n	c0d038be <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d038a6:	4a06      	ldr	r2, [pc, #24]	; (c0d038c0 <io_usb_hid_send+0x20>)
c0d038a8:	2300      	movs	r3, #0
c0d038aa:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d038ac:	4a05      	ldr	r2, [pc, #20]	; (c0d038c4 <io_usb_hid_send+0x24>)
c0d038ae:	4b06      	ldr	r3, [pc, #24]	; (c0d038c8 <io_usb_hid_send+0x28>)
c0d038b0:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_remaining_length = sndlength;
c0d038b2:	4a06      	ldr	r2, [pc, #24]	; (c0d038cc <io_usb_hid_send+0x2c>)
c0d038b4:	6011      	str	r1, [r2, #0]
    G_io_usb_hid_total_length = sndlength;
c0d038b6:	4a06      	ldr	r2, [pc, #24]	; (c0d038d0 <io_usb_hid_send+0x30>)
c0d038b8:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d038ba:	f7ff ff93 	bl	c0d037e4 <io_usb_hid_sent>
  }
}
c0d038be:	bd80      	pop	{r7, pc}
c0d038c0:	200021b4 	.word	0x200021b4
c0d038c4:	200021c0 	.word	0x200021c0
c0d038c8:	20001fbc 	.word	0x20001fbc
c0d038cc:	200021bc 	.word	0x200021bc
c0d038d0:	200021b8 	.word	0x200021b8

c0d038d4 <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d038d4:	b580      	push	{r7, lr}
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d038d6:	4904      	ldr	r1, [pc, #16]	; (c0d038e8 <pic+0x14>)
c0d038d8:	4288      	cmp	r0, r1
c0d038da:	d304      	bcc.n	c0d038e6 <pic+0x12>
c0d038dc:	4903      	ldr	r1, [pc, #12]	; (c0d038ec <pic+0x18>)
c0d038de:	4288      	cmp	r0, r1
c0d038e0:	d201      	bcs.n	c0d038e6 <pic+0x12>
		link_address = pic_internal(link_address);
c0d038e2:	f000 f805 	bl	c0d038f0 <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d038e6:	bd80      	pop	{r7, pc}
c0d038e8:	c0d00000 	.word	0xc0d00000
c0d038ec:	c0d07c40 	.word	0xc0d07c40

c0d038f0 <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d038f0:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d038f2:	4902      	ldr	r1, [pc, #8]	; (c0d038fc <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d038f4:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d038f6:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d038f8:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d038fa:	4770      	bx	lr
c0d038fc:	c0d038f1 	.word	0xc0d038f1

c0d03900 <SVC_Call>:

// avoid a separate asm file, but avoid any intrusion from the compiler
__attribute__((naked)) void SVC_Call(unsigned int syscall_id, volatile unsigned int * parameters);
__attribute__((naked)) void SVC_Call(__attribute__((unused)) unsigned int syscall_id, __attribute__((unused)) volatile unsigned int * parameters) {
  // delegate svc, ensure no optimization by gcc with naked and r0, r1 marked as clobbered
  asm volatile("svc #1":::"r0","r1");
c0d03900:	df01      	svc	1
  asm volatile("bx  lr");
c0d03902:	4770      	bx	lr

c0d03904 <check_api_level>:
}
void check_api_level ( unsigned int apiLevel ) 
{
c0d03904:	b580      	push	{r7, lr}
c0d03906:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)apiLevel;
c0d03908:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_check_api_level_ID_IN, parameters);
c0d0390a:	4803      	ldr	r0, [pc, #12]	; (c0d03918 <check_api_level+0x14>)
c0d0390c:	a901      	add	r1, sp, #4
c0d0390e:	f7ff fff7 	bl	c0d03900 <SVC_Call>
}
c0d03912:	b004      	add	sp, #16
c0d03914:	bd80      	pop	{r7, pc}
c0d03916:	46c0      	nop			; (mov r8, r8)
c0d03918:	60000137 	.word	0x60000137

c0d0391c <halt>:

void halt ( void ) 
{
c0d0391c:	b580      	push	{r7, lr}
c0d0391e:	b082      	sub	sp, #8
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_halt_ID_IN, parameters);
c0d03920:	4802      	ldr	r0, [pc, #8]	; (c0d0392c <halt+0x10>)
c0d03922:	4669      	mov	r1, sp
c0d03924:	f7ff ffec 	bl	c0d03900 <SVC_Call>
}
c0d03928:	b002      	add	sp, #8
c0d0392a:	bd80      	pop	{r7, pc}
c0d0392c:	6000023c 	.word	0x6000023c

c0d03930 <nvm_write>:

void nvm_write ( void * dst_adr, void * src_adr, unsigned int src_len ) 
{
c0d03930:	b580      	push	{r7, lr}
c0d03932:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)dst_adr;
c0d03934:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)src_adr;
c0d03936:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)src_len;
c0d03938:	9203      	str	r2, [sp, #12]
  SVC_Call(SYSCALL_nvm_write_ID_IN, parameters);
c0d0393a:	4803      	ldr	r0, [pc, #12]	; (c0d03948 <nvm_write+0x18>)
c0d0393c:	a901      	add	r1, sp, #4
c0d0393e:	f7ff ffdf 	bl	c0d03900 <SVC_Call>
}
c0d03942:	b006      	add	sp, #24
c0d03944:	bd80      	pop	{r7, pc}
c0d03946:	46c0      	nop			; (mov r8, r8)
c0d03948:	6000037f 	.word	0x6000037f

c0d0394c <cx_rng>:
  SVC_Call(SYSCALL_cx_rng_u8_ID_IN, parameters);
  return (unsigned char)(((volatile unsigned int*)parameters)[1]);
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d0394c:	b580      	push	{r7, lr}
c0d0394e:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d03950:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)len;
c0d03952:	9101      	str	r1, [sp, #4]
  SVC_Call(SYSCALL_cx_rng_ID_IN, parameters);
c0d03954:	4803      	ldr	r0, [pc, #12]	; (c0d03964 <cx_rng+0x18>)
c0d03956:	4669      	mov	r1, sp
c0d03958:	f7ff ffd2 	bl	c0d03900 <SVC_Call>
  return (unsigned char *)(((volatile unsigned int*)parameters)[1]);
c0d0395c:	9801      	ldr	r0, [sp, #4]
c0d0395e:	b004      	add	sp, #16
c0d03960:	bd80      	pop	{r7, pc}
c0d03962:	46c0      	nop			; (mov r8, r8)
c0d03964:	6000052c 	.word	0x6000052c

c0d03968 <cx_hash>:
}

int cx_hash ( cx_hash_t * hash, int mode, const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len ) 
{
c0d03968:	b580      	push	{r7, lr}
c0d0396a:	b088      	sub	sp, #32
  volatile unsigned int parameters [2+6];
  parameters[0] = (unsigned int)hash;
c0d0396c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)mode;
c0d0396e:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)in;
c0d03970:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d03972:	9303      	str	r3, [sp, #12]
c0d03974:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[4] = (unsigned int)out;
c0d03976:	9004      	str	r0, [sp, #16]
c0d03978:	980b      	ldr	r0, [sp, #44]	; 0x2c
  parameters[5] = (unsigned int)out_len;
c0d0397a:	9005      	str	r0, [sp, #20]
  SVC_Call(SYSCALL_cx_hash_ID_IN, parameters);
c0d0397c:	4803      	ldr	r0, [pc, #12]	; (c0d0398c <cx_hash+0x24>)
c0d0397e:	4669      	mov	r1, sp
c0d03980:	f7ff ffbe 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d03984:	9801      	ldr	r0, [sp, #4]
c0d03986:	b008      	add	sp, #32
c0d03988:	bd80      	pop	{r7, pc}
c0d0398a:	46c0      	nop			; (mov r8, r8)
c0d0398c:	6000073b 	.word	0x6000073b

c0d03990 <cx_ripemd160_init>:
}

int cx_ripemd160_init ( cx_ripemd160_t * hash ) 
{
c0d03990:	b580      	push	{r7, lr}
c0d03992:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)hash;
c0d03994:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_cx_ripemd160_init_ID_IN, parameters);
c0d03996:	4803      	ldr	r0, [pc, #12]	; (c0d039a4 <cx_ripemd160_init+0x14>)
c0d03998:	a901      	add	r1, sp, #4
c0d0399a:	f7ff ffb1 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d0399e:	9802      	ldr	r0, [sp, #8]
c0d039a0:	b004      	add	sp, #16
c0d039a2:	bd80      	pop	{r7, pc}
c0d039a4:	6000087f 	.word	0x6000087f

c0d039a8 <cx_sha256_init>:
  SVC_Call(SYSCALL_cx_sha224_init_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d039a8:	b580      	push	{r7, lr}
c0d039aa:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)hash;
c0d039ac:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_cx_sha256_init_ID_IN, parameters);
c0d039ae:	4803      	ldr	r0, [pc, #12]	; (c0d039bc <cx_sha256_init+0x14>)
c0d039b0:	a901      	add	r1, sp, #4
c0d039b2:	f7ff ffa5 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d039b6:	9802      	ldr	r0, [sp, #8]
c0d039b8:	b004      	add	sp, #16
c0d039ba:	bd80      	pop	{r7, pc}
c0d039bc:	60000adb 	.word	0x60000adb

c0d039c0 <cx_sha512_init>:
  SVC_Call(SYSCALL_cx_sha384_init_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_sha512_init ( cx_sha512_t * hash ) 
{
c0d039c0:	b580      	push	{r7, lr}
c0d039c2:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)hash;
c0d039c4:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_cx_sha512_init_ID_IN, parameters);
c0d039c6:	4803      	ldr	r0, [pc, #12]	; (c0d039d4 <cx_sha512_init+0x14>)
c0d039c8:	a901      	add	r1, sp, #4
c0d039ca:	f7ff ff99 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d039ce:	9802      	ldr	r0, [sp, #8]
c0d039d0:	b004      	add	sp, #16
c0d039d2:	bd80      	pop	{r7, pc}
c0d039d4:	60000dc1 	.word	0x60000dc1

c0d039d8 <cx_ecfp_init_private_key>:
  SVC_Call(SYSCALL_cx_ecfp_init_public_key_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey ) 
{
c0d039d8:	b580      	push	{r7, lr}
c0d039da:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d039dc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)rawkey;
c0d039de:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)key_len;
c0d039e0:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)pvkey;
c0d039e2:	9303      	str	r3, [sp, #12]
  SVC_Call(SYSCALL_cx_ecfp_init_private_key_ID_IN, parameters);
c0d039e4:	4803      	ldr	r0, [pc, #12]	; (c0d039f4 <cx_ecfp_init_private_key+0x1c>)
c0d039e6:	4669      	mov	r1, sp
c0d039e8:	f7ff ff8a 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d039ec:	9801      	ldr	r0, [sp, #4]
c0d039ee:	b006      	add	sp, #24
c0d039f0:	bd80      	pop	{r7, pc}
c0d039f2:	46c0      	nop			; (mov r8, r8)
c0d039f4:	60002eea 	.word	0x60002eea

c0d039f8 <cx_ecfp_generate_pair>:
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d039f8:	b580      	push	{r7, lr}
c0d039fa:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+4];
  parameters[0] = (unsigned int)curve;
c0d039fc:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)pubkey;
c0d039fe:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)privkey;
c0d03a00:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)keepprivate;
c0d03a02:	9303      	str	r3, [sp, #12]
  SVC_Call(SYSCALL_cx_ecfp_generate_pair_ID_IN, parameters);
c0d03a04:	4803      	ldr	r0, [pc, #12]	; (c0d03a14 <cx_ecfp_generate_pair+0x1c>)
c0d03a06:	4669      	mov	r1, sp
c0d03a08:	f7ff ff7a 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d03a0c:	9801      	ldr	r0, [sp, #4]
c0d03a0e:	b006      	add	sp, #24
c0d03a10:	bd80      	pop	{r7, pc}
c0d03a12:	46c0      	nop			; (mov r8, r8)
c0d03a14:	60002f2e 	.word	0x60002f2e

c0d03a18 <cx_ecdsa_sign>:
  SVC_Call(SYSCALL_cx_ecfp_generate_pair2_ID_IN, parameters);
  return (int)(((volatile unsigned int*)parameters)[1]);
}

int cx_ecdsa_sign ( const cx_ecfp_private_key_t * pvkey, int mode, cx_md_t hashID, const unsigned char * hash, unsigned int hash_len, unsigned char * sig, unsigned int sig_len, unsigned int * info ) 
{
c0d03a18:	b580      	push	{r7, lr}
c0d03a1a:	b08a      	sub	sp, #40	; 0x28
  volatile unsigned int parameters [2+8];
  parameters[0] = (unsigned int)pvkey;
c0d03a1c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)mode;
c0d03a1e:	9101      	str	r1, [sp, #4]
  parameters[2] = (unsigned int)hashID;
c0d03a20:	9202      	str	r2, [sp, #8]
  parameters[3] = (unsigned int)hash;
c0d03a22:	9303      	str	r3, [sp, #12]
c0d03a24:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[4] = (unsigned int)hash_len;
c0d03a26:	9004      	str	r0, [sp, #16]
c0d03a28:	980d      	ldr	r0, [sp, #52]	; 0x34
  parameters[5] = (unsigned int)sig;
c0d03a2a:	9005      	str	r0, [sp, #20]
c0d03a2c:	980e      	ldr	r0, [sp, #56]	; 0x38
  parameters[6] = (unsigned int)sig_len;
c0d03a2e:	9006      	str	r0, [sp, #24]
c0d03a30:	980f      	ldr	r0, [sp, #60]	; 0x3c
  parameters[7] = (unsigned int)info;
c0d03a32:	9007      	str	r0, [sp, #28]
  SVC_Call(SYSCALL_cx_ecdsa_sign_ID_IN, parameters);
c0d03a34:	4803      	ldr	r0, [pc, #12]	; (c0d03a44 <cx_ecdsa_sign+0x2c>)
c0d03a36:	4669      	mov	r1, sp
c0d03a38:	f7ff ff62 	bl	c0d03900 <SVC_Call>
  return (int)(((volatile unsigned int*)parameters)[1]);
c0d03a3c:	9801      	ldr	r0, [sp, #4]
c0d03a3e:	b00a      	add	sp, #40	; 0x28
c0d03a40:	bd80      	pop	{r7, pc}
c0d03a42:	46c0      	nop			; (mov r8, r8)
c0d03a44:	600038f3 	.word	0x600038f3

c0d03a48 <cx_crc16_update>:
  SVC_Call(SYSCALL_cx_crc16_ID_IN, parameters);
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
}

unsigned short cx_crc16_update ( unsigned short crc, const void * buffer, size_t len ) 
{
c0d03a48:	b580      	push	{r7, lr}
c0d03a4a:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)crc;
c0d03a4c:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d03a4e:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)len;
c0d03a50:	9203      	str	r2, [sp, #12]
  SVC_Call(SYSCALL_cx_crc16_update_ID_IN, parameters);
c0d03a52:	4804      	ldr	r0, [pc, #16]	; (c0d03a64 <cx_crc16_update+0x1c>)
c0d03a54:	a901      	add	r1, sp, #4
c0d03a56:	f7ff ff53 	bl	c0d03900 <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d03a5a:	9802      	ldr	r0, [sp, #8]
c0d03a5c:	b280      	uxth	r0, r0
c0d03a5e:	b006      	add	sp, #24
c0d03a60:	bd80      	pop	{r7, pc}
c0d03a62:	46c0      	nop			; (mov r8, r8)
c0d03a64:	6000926e 	.word	0x6000926e

c0d03a68 <os_perso_isonboarded>:
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_os_perso_finalize_ID_IN, parameters);
}

bolos_bool_t os_perso_isonboarded ( void ) 
{
c0d03a68:	b580      	push	{r7, lr}
c0d03a6a:	b082      	sub	sp, #8
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_perso_isonboarded_ID_IN, parameters);
c0d03a6c:	4803      	ldr	r0, [pc, #12]	; (c0d03a7c <os_perso_isonboarded+0x14>)
c0d03a6e:	4669      	mov	r1, sp
c0d03a70:	f7ff ff46 	bl	c0d03900 <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d03a74:	9801      	ldr	r0, [sp, #4]
c0d03a76:	b2c0      	uxtb	r0, r0
c0d03a78:	b002      	add	sp, #8
c0d03a7a:	bd80      	pop	{r7, pc}
c0d03a7c:	60009f4f 	.word	0x60009f4f

c0d03a80 <os_perso_derive_node_bip32>:
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d03a80:	b580      	push	{r7, lr}
c0d03a82:	b088      	sub	sp, #32
  volatile unsigned int parameters [2+5];
  parameters[0] = (unsigned int)curve;
c0d03a84:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)path;
c0d03a86:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)pathLength;
c0d03a88:	9203      	str	r2, [sp, #12]
  parameters[3] = (unsigned int)privateKey;
c0d03a8a:	9304      	str	r3, [sp, #16]
c0d03a8c:	980a      	ldr	r0, [sp, #40]	; 0x28
  parameters[4] = (unsigned int)chain;
c0d03a8e:	9005      	str	r0, [sp, #20]
  SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
c0d03a90:	4802      	ldr	r0, [pc, #8]	; (c0d03a9c <os_perso_derive_node_bip32+0x1c>)
c0d03a92:	a901      	add	r1, sp, #4
c0d03a94:	f7ff ff34 	bl	c0d03900 <SVC_Call>
}
c0d03a98:	b008      	add	sp, #32
c0d03a9a:	bd80      	pop	{r7, pc}
c0d03a9c:	600053ba 	.word	0x600053ba

c0d03aa0 <os_perso_seed_cookie>:
  parameters[7] = (unsigned int)seed_key_length;
  SVC_Call(SYSCALL_os_perso_derive_node_with_seed_key_ID_IN, parameters);
}

unsigned int os_perso_seed_cookie ( unsigned char * seed_cookie, unsigned int seed_cookie_length ) 
{
c0d03aa0:	b580      	push	{r7, lr}
c0d03aa2:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)seed_cookie;
c0d03aa4:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)seed_cookie_length;
c0d03aa6:	9101      	str	r1, [sp, #4]
  SVC_Call(SYSCALL_os_perso_seed_cookie_ID_IN, parameters);
c0d03aa8:	4803      	ldr	r0, [pc, #12]	; (c0d03ab8 <os_perso_seed_cookie+0x18>)
c0d03aaa:	4669      	mov	r1, sp
c0d03aac:	f7ff ff28 	bl	c0d03900 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d03ab0:	9801      	ldr	r0, [sp, #4]
c0d03ab2:	b004      	add	sp, #16
c0d03ab4:	bd80      	pop	{r7, pc}
c0d03ab6:	46c0      	nop			; (mov r8, r8)
c0d03ab8:	6000a8fc 	.word	0x6000a8fc

c0d03abc <os_global_pin_is_validated>:
  SVC_Call(SYSCALL_os_endorsement_key2_derive_sign_data_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_bool_t os_global_pin_is_validated ( void ) 
{
c0d03abc:	b580      	push	{r7, lr}
c0d03abe:	b082      	sub	sp, #8
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_global_pin_is_validated_ID_IN, parameters);
c0d03ac0:	4803      	ldr	r0, [pc, #12]	; (c0d03ad0 <os_global_pin_is_validated+0x14>)
c0d03ac2:	4669      	mov	r1, sp
c0d03ac4:	f7ff ff1c 	bl	c0d03900 <SVC_Call>
  return (bolos_bool_t)(((volatile unsigned int*)parameters)[1]);
c0d03ac8:	9801      	ldr	r0, [sp, #4]
c0d03aca:	b2c0      	uxtb	r0, r0
c0d03acc:	b002      	add	sp, #8
c0d03ace:	bd80      	pop	{r7, pc}
c0d03ad0:	6000a03c 	.word	0x6000a03c

c0d03ad4 <os_ux>:
  parameters[1] = (unsigned int)out_application_entry;
  SVC_Call(SYSCALL_os_registry_get_ID_IN, parameters);
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d03ad4:	b580      	push	{r7, lr}
c0d03ad6:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)params;
c0d03ad8:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d03ada:	4803      	ldr	r0, [pc, #12]	; (c0d03ae8 <os_ux+0x14>)
c0d03adc:	a901      	add	r1, sp, #4
c0d03ade:	f7ff ff0f 	bl	c0d03900 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d03ae2:	9802      	ldr	r0, [sp, #8]
c0d03ae4:	b004      	add	sp, #16
c0d03ae6:	bd80      	pop	{r7, pc}
c0d03ae8:	60006458 	.word	0x60006458

c0d03aec <os_lib_throw>:
  volatile unsigned int parameters [2];
  SVC_Call(SYSCALL_os_lib_end_ID_IN, parameters);
}

void os_lib_throw ( unsigned int exception ) 
{
c0d03aec:	b580      	push	{r7, lr}
c0d03aee:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exception;
c0d03af0:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_os_lib_throw_ID_IN, parameters);
c0d03af2:	4803      	ldr	r0, [pc, #12]	; (c0d03b00 <os_lib_throw+0x14>)
c0d03af4:	a901      	add	r1, sp, #4
c0d03af6:	f7ff ff03 	bl	c0d03900 <SVC_Call>
}
c0d03afa:	b004      	add	sp, #16
c0d03afc:	bd80      	pop	{r7, pc}
c0d03afe:	46c0      	nop			; (mov r8, r8)
c0d03b00:	60006945 	.word	0x60006945

c0d03b04 <os_flags>:

unsigned int os_flags ( void ) 
{
c0d03b04:	b580      	push	{r7, lr}
c0d03b06:	b082      	sub	sp, #8
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d03b08:	4803      	ldr	r0, [pc, #12]	; (c0d03b18 <os_flags+0x14>)
c0d03b0a:	4669      	mov	r1, sp
c0d03b0c:	f7ff fef8 	bl	c0d03900 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d03b10:	9801      	ldr	r0, [sp, #4]
c0d03b12:	b002      	add	sp, #8
c0d03b14:	bd80      	pop	{r7, pc}
c0d03b16:	46c0      	nop			; (mov r8, r8)
c0d03b18:	60006a6e 	.word	0x60006a6e

c0d03b1c <os_registry_get_current_app_tag>:
  SVC_Call(SYSCALL_os_registry_get_tag_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) 
{
c0d03b1c:	b580      	push	{r7, lr}
c0d03b1e:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)tag;
c0d03b20:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)buffer;
c0d03b22:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)maxlen;
c0d03b24:	9203      	str	r2, [sp, #12]
  SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d03b26:	4803      	ldr	r0, [pc, #12]	; (c0d03b34 <os_registry_get_current_app_tag+0x18>)
c0d03b28:	a901      	add	r1, sp, #4
c0d03b2a:	f7ff fee9 	bl	c0d03900 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d03b2e:	9802      	ldr	r0, [sp, #8]
c0d03b30:	b006      	add	sp, #24
c0d03b32:	bd80      	pop	{r7, pc}
c0d03b34:	600074d4 	.word	0x600074d4

c0d03b38 <os_sched_exit>:
  parameters[0] = (unsigned int)application_index;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
}

void os_sched_exit ( bolos_task_status_t exit_code ) 
{
c0d03b38:	b580      	push	{r7, lr}
c0d03b3a:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
c0d03b3c:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d03b3e:	4803      	ldr	r0, [pc, #12]	; (c0d03b4c <os_sched_exit+0x14>)
c0d03b40:	a901      	add	r1, sp, #4
c0d03b42:	f7ff fedd 	bl	c0d03900 <SVC_Call>
}
c0d03b46:	b004      	add	sp, #16
c0d03b48:	bd80      	pop	{r7, pc}
c0d03b4a:	46c0      	nop			; (mov r8, r8)
c0d03b4c:	60009abe 	.word	0x60009abe

c0d03b50 <io_seph_send>:
  parameters[0] = (unsigned int)taskidx;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d03b50:	b580      	push	{r7, lr}
c0d03b52:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
c0d03b54:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)length;
c0d03b56:	9101      	str	r1, [sp, #4]
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d03b58:	4802      	ldr	r0, [pc, #8]	; (c0d03b64 <io_seph_send+0x14>)
c0d03b5a:	4669      	mov	r1, sp
c0d03b5c:	f7ff fed0 	bl	c0d03900 <SVC_Call>
}
c0d03b60:	b004      	add	sp, #16
c0d03b62:	bd80      	pop	{r7, pc}
c0d03b64:	60008381 	.word	0x60008381

c0d03b68 <io_seph_is_status_sent>:

unsigned int io_seph_is_status_sent ( void ) 
{
c0d03b68:	b580      	push	{r7, lr}
c0d03b6a:	b082      	sub	sp, #8
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_io_seph_is_status_sent_ID_IN, parameters);
c0d03b6c:	4803      	ldr	r0, [pc, #12]	; (c0d03b7c <io_seph_is_status_sent+0x14>)
c0d03b6e:	4669      	mov	r1, sp
c0d03b70:	f7ff fec6 	bl	c0d03900 <SVC_Call>
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
c0d03b74:	9801      	ldr	r0, [sp, #4]
c0d03b76:	b002      	add	sp, #8
c0d03b78:	bd80      	pop	{r7, pc}
c0d03b7a:	46c0      	nop			; (mov r8, r8)
c0d03b7c:	600084bb 	.word	0x600084bb

c0d03b80 <io_seph_recv>:
}

unsigned short io_seph_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d03b80:	b580      	push	{r7, lr}
c0d03b82:	b086      	sub	sp, #24
  volatile unsigned int parameters [2+3];
  parameters[0] = (unsigned int)buffer;
c0d03b84:	9001      	str	r0, [sp, #4]
  parameters[1] = (unsigned int)maxlength;
c0d03b86:	9102      	str	r1, [sp, #8]
  parameters[2] = (unsigned int)flags;
c0d03b88:	9203      	str	r2, [sp, #12]
  SVC_Call(SYSCALL_io_seph_recv_ID_IN, parameters);
c0d03b8a:	4804      	ldr	r0, [pc, #16]	; (c0d03b9c <io_seph_recv+0x1c>)
c0d03b8c:	a901      	add	r1, sp, #4
c0d03b8e:	f7ff feb7 	bl	c0d03900 <SVC_Call>
  return (unsigned short)(((volatile unsigned int*)parameters)[1]);
c0d03b92:	9802      	ldr	r0, [sp, #8]
c0d03b94:	b280      	uxth	r0, r0
c0d03b96:	b006      	add	sp, #24
c0d03b98:	bd80      	pop	{r7, pc}
c0d03b9a:	46c0      	nop			; (mov r8, r8)
c0d03b9c:	600085e4 	.word	0x600085e4

c0d03ba0 <try_context_get>:
  parameters[0] = (unsigned int)page_adr;
  SVC_Call(SYSCALL_nvm_write_page_ID_IN, parameters);
}

try_context_t * try_context_get ( void ) 
{
c0d03ba0:	b580      	push	{r7, lr}
c0d03ba2:	b082      	sub	sp, #8
  volatile unsigned int parameters [2];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d03ba4:	4803      	ldr	r0, [pc, #12]	; (c0d03bb4 <try_context_get+0x14>)
c0d03ba6:	4669      	mov	r1, sp
c0d03ba8:	f7ff feaa 	bl	c0d03900 <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d03bac:	9801      	ldr	r0, [sp, #4]
c0d03bae:	b002      	add	sp, #8
c0d03bb0:	bd80      	pop	{r7, pc}
c0d03bb2:	46c0      	nop			; (mov r8, r8)
c0d03bb4:	600087b1 	.word	0x600087b1

c0d03bb8 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t * context ) 
{
c0d03bb8:	b580      	push	{r7, lr}
c0d03bba:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)context;
c0d03bbc:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d03bbe:	4803      	ldr	r0, [pc, #12]	; (c0d03bcc <try_context_set+0x14>)
c0d03bc0:	a901      	add	r1, sp, #4
c0d03bc2:	f7ff fe9d 	bl	c0d03900 <SVC_Call>
  return (try_context_t *)(((volatile unsigned int*)parameters)[1]);
c0d03bc6:	9802      	ldr	r0, [sp, #8]
c0d03bc8:	b004      	add	sp, #16
c0d03bca:	bd80      	pop	{r7, pc}
c0d03bcc:	60008875 	.word	0x60008875

c0d03bd0 <os_sched_last_status>:
  SVC_Call(SYSCALL_cx_rng_u32_ID_IN, parameters);
  return (unsigned int)(((volatile unsigned int*)parameters)[1]);
}

bolos_task_status_t os_sched_last_status ( unsigned int task_idx ) 
{
c0d03bd0:	b580      	push	{r7, lr}
c0d03bd2:	b084      	sub	sp, #16
  volatile unsigned int parameters [2+1];
#ifdef __clang_analyzer__
  parameters[1] = 0;
#endif
  parameters[0] = (unsigned int)task_idx;
c0d03bd4:	9001      	str	r0, [sp, #4]
  SVC_Call(SYSCALL_os_sched_last_status_ID_IN, parameters);
c0d03bd6:	4804      	ldr	r0, [pc, #16]	; (c0d03be8 <os_sched_last_status+0x18>)
c0d03bd8:	a901      	add	r1, sp, #4
c0d03bda:	f7ff fe91 	bl	c0d03900 <SVC_Call>
  return (bolos_task_status_t)(((volatile unsigned int*)parameters)[1]);
c0d03bde:	9802      	ldr	r0, [sp, #8]
c0d03be0:	b2c0      	uxtb	r0, r0
c0d03be2:	b004      	add	sp, #16
c0d03be4:	bd80      	pop	{r7, pc}
c0d03be6:	46c0      	nop			; (mov r8, r8)
c0d03be8:	60009c8b 	.word	0x60009c8b

c0d03bec <find_tx_data>:

uint256_t chain_id;
uint32_t timestamp;
uint32_t expiration;

int find_tx_data(char *value, char *flag, char *input, int length, short key_length, bool write_cache){
c0d03bec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03bee:	b085      	sub	sp, #20
c0d03bf0:	4615      	mov	r5, r2
c0d03bf2:	9104      	str	r1, [sp, #16]
c0d03bf4:	9002      	str	r0, [sp, #8]
c0d03bf6:	2700      	movs	r7, #0
    int info_start = 0;
    int info_delimiter = 0;

    // log[log_p++] = 'f';

    while(i < length){
c0d03bf8:	2b01      	cmp	r3, #1
c0d03bfa:	db2f      	blt.n	c0d03c5c <find_tx_data+0x70>
c0d03bfc:	980b      	ldr	r0, [sp, #44]	; 0x2c
c0d03bfe:	9001      	str	r0, [sp, #4]
c0d03c00:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d03c02:	9003      	str	r0, [sp, #12]
c0d03c04:	2100      	movs	r1, #0
c0d03c06:	4608      	mov	r0, r1
c0d03c08:	460c      	mov	r4, r1

        if(input[i] == '#'){
c0d03c0a:	5d2a      	ldrb	r2, [r5, r4]
c0d03c0c:	2a23      	cmp	r2, #35	; 0x23
c0d03c0e:	4626      	mov	r6, r4
c0d03c10:	d000      	beq.n	c0d03c14 <find_tx_data+0x28>
c0d03c12:	460e      	mov	r6, r1
            info_delimiter = i;
            // log[log_p++] = '#';
            // log[log_p++] = (char)(i + 48);
        }

        if(input[i] == '*'){
c0d03c14:	2a2a      	cmp	r2, #42	; 0x2a
c0d03c16:	d10b      	bne.n	c0d03c30 <find_tx_data+0x44>
c0d03c18:	461f      	mov	r7, r3
            //         log[log_p++] = 'n';
            //     }
            // }
            

            if(strncmp(&(input[info_start]), flag, key_length) == 0){
c0d03c1a:	1828      	adds	r0, r5, r0
c0d03c1c:	9904      	ldr	r1, [sp, #16]
c0d03c1e:	9a03      	ldr	r2, [sp, #12]
c0d03c20:	f003 f9f2 	bl	c0d07008 <strncmp>
c0d03c24:	2800      	cmp	r0, #0
c0d03c26:	d009      	beq.n	c0d03c3c <find_tx_data+0x50>
                    value[1] = (info_delimiter + 1) & 0xFF;
                }

                return value_length;
            }
            info_start = i + 1;
c0d03c28:	1c64      	adds	r4, r4, #1
c0d03c2a:	4620      	mov	r0, r4
c0d03c2c:	463b      	mov	r3, r7
c0d03c2e:	e000      	b.n	c0d03c32 <find_tx_data+0x46>
        }

        i++;
c0d03c30:	1c64      	adds	r4, r4, #1
c0d03c32:	2700      	movs	r7, #0
    int info_start = 0;
    int info_delimiter = 0;

    // log[log_p++] = 'f';

    while(i < length){
c0d03c34:	429c      	cmp	r4, r3
c0d03c36:	4631      	mov	r1, r6
c0d03c38:	dbe7      	blt.n	c0d03c0a <find_tx_data+0x1e>
c0d03c3a:	e00f      	b.n	c0d03c5c <find_tx_data+0x70>

            if(strncmp(&(input[info_start]), flag, key_length) == 0){

                // log[log_p++] = 'c';

                value_length = i - info_delimiter - 1;
c0d03c3c:	1ba0      	subs	r0, r4, r6
c0d03c3e:	1e47      	subs	r7, r0, #1
c0d03c40:	1c70      	adds	r0, r6, #1

                if(write_cache){
c0d03c42:	9901      	ldr	r1, [sp, #4]
c0d03c44:	2901      	cmp	r1, #1
c0d03c46:	d105      	bne.n	c0d03c54 <find_tx_data+0x68>
                    os_memcpy(value, &(input[info_delimiter + 1]), value_length);
c0d03c48:	1829      	adds	r1, r5, r0
c0d03c4a:	9802      	ldr	r0, [sp, #8]
c0d03c4c:	463a      	mov	r2, r7
c0d03c4e:	f7ff f8ad 	bl	c0d02dac <os_memmove>
c0d03c52:	e003      	b.n	c0d03c5c <find_tx_data+0x70>
                } else {
                    value[0] = (((info_delimiter + 1) >> 8) & 0xFF);
c0d03c54:	0a01      	lsrs	r1, r0, #8
c0d03c56:	9a02      	ldr	r2, [sp, #8]
c0d03c58:	7011      	strb	r1, [r2, #0]
                    value[1] = (info_delimiter + 1) & 0xFF;
c0d03c5a:	7050      	strb	r0, [r2, #1]

        i++;
    }

    return value_length;
}
c0d03c5c:	4638      	mov	r0, r7
c0d03c5e:	b005      	add	sp, #20
c0d03c60:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d03c64 <encode_chain_id>:

void encode_chain_id(transaction *tx){
c0d03c64:	b570      	push	{r4, r5, r6, lr}
c0d03c66:	4604      	mov	r4, r0

    // log[log_p++] = '1';
    clear256(&chain_id);
c0d03c68:	4d0d      	ldr	r5, [pc, #52]	; (c0d03ca0 <encode_chain_id+0x3c>)
c0d03c6a:	4628      	mov	r0, r5
c0d03c6c:	f001 fdec 	bl	c0d05848 <clear256>
c0d03c70:	2000      	movs	r0, #0

    // log[log_p++] = '2';
    UPPER(LOWER(chain_id)) = 0;
    LOWER(LOWER(chain_id)) = 1;
c0d03c72:	2101      	movs	r1, #1

    // log[log_p++] = '1';
    clear256(&chain_id);

    // log[log_p++] = '2';
    UPPER(LOWER(chain_id)) = 0;
c0d03c74:	6128      	str	r0, [r5, #16]
c0d03c76:	6168      	str	r0, [r5, #20]
    LOWER(LOWER(chain_id)) = 1;
c0d03c78:	61a9      	str	r1, [r5, #24]
c0d03c7a:	61e8      	str	r0, [r5, #28]

    // log[log_p++] = '3';
    tx->chain_id = &chain_id;
c0d03c7c:	6025      	str	r5, [r4, #0]
    // if(tostring256(tx->chain_id, 16, &(cache[0]), 32)){
    //     log[log_p++] = '6';
    // } else {
    //     log[log_p++] = '7';
    // }
    get_uint_256_bytes(tx->chain_id, &(cache[0]));
c0d03c7e:	4e09      	ldr	r6, [pc, #36]	; (c0d03ca4 <encode_chain_id+0x40>)
c0d03c80:	6831      	ldr	r1, [r6, #0]
c0d03c82:	4628      	mov	r0, r5
c0d03c84:	f7ff f880 	bl	c0d02d88 <get_uint_256_bytes>

    // log[log_p++] = '5';
    os_memcpy(&(tx->encode[encode_p]), &(cache[0]), 32);
c0d03c88:	4d07      	ldr	r5, [pc, #28]	; (c0d03ca8 <encode_chain_id+0x44>)
c0d03c8a:	6828      	ldr	r0, [r5, #0]
c0d03c8c:	6a21      	ldr	r1, [r4, #32]
c0d03c8e:	1808      	adds	r0, r1, r0
c0d03c90:	6831      	ldr	r1, [r6, #0]
c0d03c92:	2220      	movs	r2, #32
c0d03c94:	f7ff f88a 	bl	c0d02dac <os_memmove>
    encode_p += 32; 
c0d03c98:	6828      	ldr	r0, [r5, #0]
c0d03c9a:	3020      	adds	r0, #32
c0d03c9c:	6028      	str	r0, [r5, #0]
}
c0d03c9e:	bd70      	pop	{r4, r5, r6, pc}
c0d03ca0:	200021c8 	.word	0x200021c8
c0d03ca4:	200021e8 	.word	0x200021e8
c0d03ca8:	200021ec 	.word	0x200021ec

c0d03cac <encode_timestamp>:

void encode_timestamp(char *input, int length, transaction *tx){
c0d03cac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03cae:	b083      	sub	sp, #12
c0d03cb0:	4614      	mov	r4, r2
c0d03cb2:	460b      	mov	r3, r1
c0d03cb4:	4602      	mov	r2, r0
    flag = "timestamp";
    int value_length = find_tx_data(cache, flag, input, length, 9, true);
c0d03cb6:	4d14      	ldr	r5, [pc, #80]	; (c0d03d08 <encode_timestamp+0x5c>)
c0d03cb8:	6828      	ldr	r0, [r5, #0]
c0d03cba:	2101      	movs	r1, #1
c0d03cbc:	466e      	mov	r6, sp
c0d03cbe:	2709      	movs	r7, #9
c0d03cc0:	6037      	str	r7, [r6, #0]
c0d03cc2:	6071      	str	r1, [r6, #4]
c0d03cc4:	a111      	add	r1, pc, #68	; (adr r1, c0d03d0c <encode_timestamp+0x60>)
c0d03cc6:	f7ff ff91 	bl	c0d03bec <find_tx_data>
c0d03cca:	4601      	mov	r1, r0

    // log[log_p++] = 't';

    timestamp = 0;
c0d03ccc:	4a12      	ldr	r2, [pc, #72]	; (c0d03d18 <encode_timestamp+0x6c>)
c0d03cce:	2000      	movs	r0, #0
c0d03cd0:	6010      	str	r0, [r2, #0]
    for(int i = 0; i < value_length; i++){
c0d03cd2:	2901      	cmp	r1, #1
c0d03cd4:	db0c      	blt.n	c0d03cf0 <encode_timestamp+0x44>
c0d03cd6:	682b      	ldr	r3, [r5, #0]
c0d03cd8:	2000      	movs	r0, #0
        timestamp = (timestamp * 10);
c0d03cda:	250a      	movs	r5, #10
c0d03cdc:	4345      	muls	r5, r0
c0d03cde:	6015      	str	r5, [r2, #0]
        timestamp += (cache[i] - 48);
c0d03ce0:	7818      	ldrb	r0, [r3, #0]
c0d03ce2:	1828      	adds	r0, r5, r0
c0d03ce4:	3830      	subs	r0, #48	; 0x30
c0d03ce6:	6010      	str	r0, [r2, #0]
    int value_length = find_tx_data(cache, flag, input, length, 9, true);

    // log[log_p++] = 't';

    timestamp = 0;
    for(int i = 0; i < value_length; i++){
c0d03ce8:	1e49      	subs	r1, r1, #1
c0d03cea:	1c5b      	adds	r3, r3, #1
c0d03cec:	2900      	cmp	r1, #0
c0d03cee:	d1f4      	bne.n	c0d03cda <encode_timestamp+0x2e>
        timestamp += (cache[i] - 48);

        // log[log_p++] = cache[i];
    }
    
    tx->timestamp = &timestamp;
c0d03cf0:	6062      	str	r2, [r4, #4]

    encode_p += uint32_to_bytes(*(tx->timestamp), &(tx->encode[encode_p]));
c0d03cf2:	4d0a      	ldr	r5, [pc, #40]	; (c0d03d1c <encode_timestamp+0x70>)
c0d03cf4:	6829      	ldr	r1, [r5, #0]
c0d03cf6:	6a22      	ldr	r2, [r4, #32]
c0d03cf8:	1851      	adds	r1, r2, r1
c0d03cfa:	f7fe ffef 	bl	c0d02cdc <uint32_to_bytes>
c0d03cfe:	6829      	ldr	r1, [r5, #0]
c0d03d00:	1808      	adds	r0, r1, r0
c0d03d02:	6028      	str	r0, [r5, #0]
}
c0d03d04:	b003      	add	sp, #12
c0d03d06:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03d08:	200021e8 	.word	0x200021e8
c0d03d0c:	656d6974 	.word	0x656d6974
c0d03d10:	6d617473 	.word	0x6d617473
c0d03d14:	00000070 	.word	0x00000070
c0d03d18:	200021f0 	.word	0x200021f0
c0d03d1c:	200021ec 	.word	0x200021ec

c0d03d20 <encode_expiration>:


void encode_expiration(char *input, int length, transaction *tx){
c0d03d20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03d22:	b083      	sub	sp, #12
c0d03d24:	4614      	mov	r4, r2
c0d03d26:	460b      	mov	r3, r1
c0d03d28:	4602      	mov	r2, r0
    flag = "expiration";
    int value_length = find_tx_data(cache, flag, input, length, 10, true);
c0d03d2a:	4819      	ldr	r0, [pc, #100]	; (c0d03d90 <encode_expiration+0x70>)
c0d03d2c:	6800      	ldr	r0, [r0, #0]
c0d03d2e:	2701      	movs	r7, #1
c0d03d30:	4669      	mov	r1, sp
c0d03d32:	260a      	movs	r6, #10
c0d03d34:	c1c0      	stmia	r1!, {r6, r7}
c0d03d36:	a117      	add	r1, pc, #92	; (adr r1, c0d03d94 <encode_expiration+0x74>)
c0d03d38:	f7ff ff58 	bl	c0d03bec <find_tx_data>
c0d03d3c:	6a21      	ldr	r1, [r4, #32]
c0d03d3e:	4d18      	ldr	r5, [pc, #96]	; (c0d03da0 <encode_expiration+0x80>)
c0d03d40:	682a      	ldr	r2, [r5, #0]
c0d03d42:	1c53      	adds	r3, r2, #1
c0d03d44:	602b      	str	r3, [r5, #0]
c0d03d46:	1889      	adds	r1, r1, r2

    if(value_length == 0){
c0d03d48:	2800      	cmp	r0, #0
c0d03d4a:	d01d      	beq.n	c0d03d88 <encode_expiration+0x68>
        tx->encode[encode_p++] = 0;
    } else {
        tx->encode[encode_p++] = 1;
c0d03d4c:	700f      	strb	r7, [r1, #0]

        // log[log_p++] = 'e';

        expiration = 0;
c0d03d4e:	4915      	ldr	r1, [pc, #84]	; (c0d03da4 <encode_expiration+0x84>)
c0d03d50:	2200      	movs	r2, #0
c0d03d52:	600a      	str	r2, [r1, #0]
        for(int i = 0; i < value_length; i++){
c0d03d54:	2801      	cmp	r0, #1
c0d03d56:	db0c      	blt.n	c0d03d72 <encode_expiration+0x52>
c0d03d58:	4a0d      	ldr	r2, [pc, #52]	; (c0d03d90 <encode_expiration+0x70>)
c0d03d5a:	6813      	ldr	r3, [r2, #0]
c0d03d5c:	2200      	movs	r2, #0
            expiration = (expiration * 10);
c0d03d5e:	4372      	muls	r2, r6
c0d03d60:	600a      	str	r2, [r1, #0]
            expiration += (cache[i] - 48);
c0d03d62:	781f      	ldrb	r7, [r3, #0]
c0d03d64:	19d2      	adds	r2, r2, r7
c0d03d66:	3a30      	subs	r2, #48	; 0x30
c0d03d68:	600a      	str	r2, [r1, #0]
        tx->encode[encode_p++] = 1;

        // log[log_p++] = 'e';

        expiration = 0;
        for(int i = 0; i < value_length; i++){
c0d03d6a:	1e40      	subs	r0, r0, #1
c0d03d6c:	1c5b      	adds	r3, r3, #1
c0d03d6e:	2800      	cmp	r0, #0
c0d03d70:	d1f5      	bne.n	c0d03d5e <encode_expiration+0x3e>
            expiration += (cache[i] - 48);

            // log[log_p++] = cache[i];
        }
        
        tx->expiration = &expiration;
c0d03d72:	60a1      	str	r1, [r4, #8]

        encode_p += uint32_to_bytes(*(tx->expiration), &(tx->encode[encode_p]));
c0d03d74:	6828      	ldr	r0, [r5, #0]
c0d03d76:	6a21      	ldr	r1, [r4, #32]
c0d03d78:	1809      	adds	r1, r1, r0
c0d03d7a:	4610      	mov	r0, r2
c0d03d7c:	f7fe ffae 	bl	c0d02cdc <uint32_to_bytes>
c0d03d80:	6829      	ldr	r1, [r5, #0]
c0d03d82:	1808      	adds	r0, r1, r0
c0d03d84:	6028      	str	r0, [r5, #0]
c0d03d86:	e001      	b.n	c0d03d8c <encode_expiration+0x6c>
void encode_expiration(char *input, int length, transaction *tx){
    flag = "expiration";
    int value_length = find_tx_data(cache, flag, input, length, 10, true);

    if(value_length == 0){
        tx->encode[encode_p++] = 0;
c0d03d88:	2000      	movs	r0, #0
c0d03d8a:	7008      	strb	r0, [r1, #0]
        tx->expiration = &expiration;

        encode_p += uint32_to_bytes(*(tx->expiration), &(tx->encode[encode_p]));
    }

}
c0d03d8c:	b003      	add	sp, #12
c0d03d8e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03d90:	200021e8 	.word	0x200021e8
c0d03d94:	69707865 	.word	0x69707865
c0d03d98:	69746172 	.word	0x69746172
c0d03d9c:	00006e6f 	.word	0x00006e6f
c0d03da0:	200021ec 	.word	0x200021ec
c0d03da4:	200021f4 	.word	0x200021f4

c0d03da8 <encode_operation>:

void encode_operation(char *input, int length, transaction *tx){
c0d03da8:	b570      	push	{r4, r5, r6, lr}
c0d03daa:	b082      	sub	sp, #8
c0d03dac:	4614      	mov	r4, r2
c0d03dae:	460b      	mov	r3, r1
c0d03db0:	4605      	mov	r5, r0

    flag = "operation";
    int value_length = find_tx_data(cache, flag, input, length, 9, false);
c0d03db2:	4811      	ldr	r0, [pc, #68]	; (c0d03df8 <encode_operation+0x50>)
c0d03db4:	6800      	ldr	r0, [r0, #0]
c0d03db6:	2100      	movs	r1, #0
c0d03db8:	466a      	mov	r2, sp
c0d03dba:	2609      	movs	r6, #9
c0d03dbc:	6016      	str	r6, [r2, #0]
c0d03dbe:	6051      	str	r1, [r2, #4]
c0d03dc0:	a10e      	add	r1, pc, #56	; (adr r1, c0d03dfc <encode_operation+0x54>)
c0d03dc2:	462a      	mov	r2, r5
c0d03dc4:	f7ff ff12 	bl	c0d03bec <find_tx_data>
c0d03dc8:	4601      	mov	r1, r0

    tx->encode[encode_p++] = 1;
c0d03dca:	6a20      	ldr	r0, [r4, #32]
c0d03dcc:	4e0e      	ldr	r6, [pc, #56]	; (c0d03e08 <encode_operation+0x60>)
c0d03dce:	6832      	ldr	r2, [r6, #0]
c0d03dd0:	1c53      	adds	r3, r2, #1
c0d03dd2:	6033      	str	r3, [r6, #0]
c0d03dd4:	2301      	movs	r3, #1
c0d03dd6:	5483      	strb	r3, [r0, r2]
    
    short start = (cache[0] << 8) + cache[1];
c0d03dd8:	480c      	ldr	r0, [pc, #48]	; (c0d03e0c <encode_operation+0x64>)
c0d03dda:	4a0d      	ldr	r2, [pc, #52]	; (c0d03e10 <encode_operation+0x68>)
c0d03ddc:	5c10      	ldrb	r0, [r2, r0]
c0d03dde:	234b      	movs	r3, #75	; 0x4b
c0d03de0:	00db      	lsls	r3, r3, #3
c0d03de2:	5cd2      	ldrb	r2, [r2, r3]
c0d03de4:	0212      	lsls	r2, r2, #8
c0d03de6:	4302      	orrs	r2, r0

    // tx->encode[encode_p++] = (value_length + 48);
    // tx->encode[encode_p++] = (start + 48);

    encode_p = build_operation(&(input[start]), value_length, tx);
c0d03de8:	b210      	sxth	r0, r2
c0d03dea:	1828      	adds	r0, r5, r0
c0d03dec:	4622      	mov	r2, r4
c0d03dee:	f7fe fedb 	bl	c0d02ba8 <build_operation>
c0d03df2:	6030      	str	r0, [r6, #0]
}
c0d03df4:	b002      	add	sp, #8
c0d03df6:	bd70      	pop	{r4, r5, r6, pc}
c0d03df8:	200021e8 	.word	0x200021e8
c0d03dfc:	7265706f 	.word	0x7265706f
c0d03e00:	6f697461 	.word	0x6f697461
c0d03e04:	0000006e 	.word	0x0000006e
c0d03e08:	200021ec 	.word	0x200021ec
c0d03e0c:	00000259 	.word	0x00000259
c0d03e10:	20001800 	.word	0x20001800

c0d03e14 <encode_validate_type>:

void encode_validate_type(char *input, int length, transaction *tx){
c0d03e14:	b570      	push	{r4, r5, r6, lr}
c0d03e16:	b082      	sub	sp, #8
c0d03e18:	4614      	mov	r4, r2
c0d03e1a:	460b      	mov	r3, r1
c0d03e1c:	4602      	mov	r2, r0
    flag = "validate_type";
    int value_length = find_tx_data(cache, flag, input, length, 13, true);
c0d03e1e:	480c      	ldr	r0, [pc, #48]	; (c0d03e50 <encode_validate_type+0x3c>)
c0d03e20:	6800      	ldr	r0, [r0, #0]
c0d03e22:	2101      	movs	r1, #1
c0d03e24:	466d      	mov	r5, sp
c0d03e26:	260d      	movs	r6, #13
c0d03e28:	602e      	str	r6, [r5, #0]
c0d03e2a:	6069      	str	r1, [r5, #4]
c0d03e2c:	a109      	add	r1, pc, #36	; (adr r1, c0d03e54 <encode_validate_type+0x40>)
c0d03e2e:	f7ff fedd 	bl	c0d03bec <find_tx_data>
    if(value_length > 0){
c0d03e32:	2801      	cmp	r0, #1
c0d03e34:	db0a      	blt.n	c0d03e4c <encode_validate_type+0x38>
        tx->encode[encode_p++] = (cache[0] - 48);
c0d03e36:	204b      	movs	r0, #75	; 0x4b
c0d03e38:	00c0      	lsls	r0, r0, #3
c0d03e3a:	490a      	ldr	r1, [pc, #40]	; (c0d03e64 <encode_validate_type+0x50>)
c0d03e3c:	5c08      	ldrb	r0, [r1, r0]
c0d03e3e:	6a21      	ldr	r1, [r4, #32]
c0d03e40:	4a09      	ldr	r2, [pc, #36]	; (c0d03e68 <encode_validate_type+0x54>)
c0d03e42:	6813      	ldr	r3, [r2, #0]
c0d03e44:	1c5c      	adds	r4, r3, #1
c0d03e46:	6014      	str	r4, [r2, #0]
c0d03e48:	30d0      	adds	r0, #208	; 0xd0
c0d03e4a:	54c8      	strb	r0, [r1, r3]
    }
}
c0d03e4c:	b002      	add	sp, #8
c0d03e4e:	bd70      	pop	{r4, r5, r6, pc}
c0d03e50:	200021e8 	.word	0x200021e8
c0d03e54:	696c6176 	.word	0x696c6176
c0d03e58:	65746164 	.word	0x65746164
c0d03e5c:	7079745f 	.word	0x7079745f
c0d03e60:	00000065 	.word	0x00000065
c0d03e64:	20001800 	.word	0x20001800
c0d03e68:	200021ec 	.word	0x200021ec

c0d03e6c <encode_dapp>:

void encode_dapp(char *input, int length, transaction *tx){
c0d03e6c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03e6e:	b083      	sub	sp, #12
c0d03e70:	4614      	mov	r4, r2
c0d03e72:	460b      	mov	r3, r1
c0d03e74:	4602      	mov	r2, r0
    flag = "dapp";
    int value_length = find_tx_data(cache, flag, input, length, 4, true);
c0d03e76:	4814      	ldr	r0, [pc, #80]	; (c0d03ec8 <encode_dapp+0x5c>)
c0d03e78:	6800      	ldr	r0, [r0, #0]
c0d03e7a:	2601      	movs	r6, #1
c0d03e7c:	4669      	mov	r1, sp
c0d03e7e:	2504      	movs	r5, #4
c0d03e80:	c160      	stmia	r1!, {r5, r6}
c0d03e82:	a112      	add	r1, pc, #72	; (adr r1, c0d03ecc <encode_dapp+0x60>)
c0d03e84:	f7ff feb2 	bl	c0d03bec <find_tx_data>
c0d03e88:	4605      	mov	r5, r0
c0d03e8a:	6a20      	ldr	r0, [r4, #32]
c0d03e8c:	4f11      	ldr	r7, [pc, #68]	; (c0d03ed4 <encode_dapp+0x68>)
c0d03e8e:	6839      	ldr	r1, [r7, #0]
c0d03e90:	1c4a      	adds	r2, r1, #1
c0d03e92:	603a      	str	r2, [r7, #0]
c0d03e94:	1840      	adds	r0, r0, r1
    if(value_length > 0){
c0d03e96:	2d01      	cmp	r5, #1
c0d03e98:	db11      	blt.n	c0d03ebe <encode_dapp+0x52>
        tx->encode[encode_p++] = 1;
c0d03e9a:	7006      	strb	r6, [r0, #0]
        tx->encode[encode_p++] = value_length;
c0d03e9c:	6a20      	ldr	r0, [r4, #32]
c0d03e9e:	6839      	ldr	r1, [r7, #0]
c0d03ea0:	1c4a      	adds	r2, r1, #1
c0d03ea2:	603a      	str	r2, [r7, #0]
c0d03ea4:	5445      	strb	r5, [r0, r1]
        os_memcpy(&(tx->encode[encode_p]), cache, value_length);
c0d03ea6:	6838      	ldr	r0, [r7, #0]
c0d03ea8:	6a21      	ldr	r1, [r4, #32]
c0d03eaa:	1808      	adds	r0, r1, r0
c0d03eac:	4906      	ldr	r1, [pc, #24]	; (c0d03ec8 <encode_dapp+0x5c>)
c0d03eae:	6809      	ldr	r1, [r1, #0]
c0d03eb0:	462a      	mov	r2, r5
c0d03eb2:	f7fe ff7b 	bl	c0d02dac <os_memmove>
        encode_p += value_length;
c0d03eb6:	6838      	ldr	r0, [r7, #0]
c0d03eb8:	1940      	adds	r0, r0, r5
c0d03eba:	6038      	str	r0, [r7, #0]
c0d03ebc:	e001      	b.n	c0d03ec2 <encode_dapp+0x56>
    } else {
        tx->encode[encode_p++] = 0;
c0d03ebe:	2100      	movs	r1, #0
c0d03ec0:	7001      	strb	r1, [r0, #0]
    }
}
c0d03ec2:	b003      	add	sp, #12
c0d03ec4:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03ec6:	46c0      	nop			; (mov r8, r8)
c0d03ec8:	200021e8 	.word	0x200021e8
c0d03ecc:	70706164 	.word	0x70706164
c0d03ed0:	00000000 	.word	0x00000000
c0d03ed4:	200021ec 	.word	0x200021ec

c0d03ed8 <encode_proposal_transaction_id>:

void encode_proposal_transaction_id(char *input, int length, transaction *tx){
c0d03ed8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03eda:	b083      	sub	sp, #12
c0d03edc:	4614      	mov	r4, r2
c0d03ede:	460b      	mov	r3, r1
c0d03ee0:	4602      	mov	r2, r0
    flag = "proposal_transaction_id";
    int value_length = find_tx_data(cache, flag, input, length, 23, true);
c0d03ee2:	4814      	ldr	r0, [pc, #80]	; (c0d03f34 <encode_proposal_transaction_id+0x5c>)
c0d03ee4:	6800      	ldr	r0, [r0, #0]
c0d03ee6:	2601      	movs	r6, #1
c0d03ee8:	4669      	mov	r1, sp
c0d03eea:	2517      	movs	r5, #23
c0d03eec:	c160      	stmia	r1!, {r5, r6}
c0d03eee:	a112      	add	r1, pc, #72	; (adr r1, c0d03f38 <encode_proposal_transaction_id+0x60>)
c0d03ef0:	f7ff fe7c 	bl	c0d03bec <find_tx_data>
c0d03ef4:	4605      	mov	r5, r0
c0d03ef6:	6a20      	ldr	r0, [r4, #32]
c0d03ef8:	4f15      	ldr	r7, [pc, #84]	; (c0d03f50 <encode_proposal_transaction_id+0x78>)
c0d03efa:	6839      	ldr	r1, [r7, #0]
c0d03efc:	1c4a      	adds	r2, r1, #1
c0d03efe:	603a      	str	r2, [r7, #0]
c0d03f00:	1840      	adds	r0, r0, r1
    if(value_length > 0){
c0d03f02:	2d01      	cmp	r5, #1
c0d03f04:	db11      	blt.n	c0d03f2a <encode_proposal_transaction_id+0x52>
        tx->encode[encode_p++] = 1;
c0d03f06:	7006      	strb	r6, [r0, #0]
        tx->encode[encode_p++] = value_length;
c0d03f08:	6a20      	ldr	r0, [r4, #32]
c0d03f0a:	6839      	ldr	r1, [r7, #0]
c0d03f0c:	1c4a      	adds	r2, r1, #1
c0d03f0e:	603a      	str	r2, [r7, #0]
c0d03f10:	5445      	strb	r5, [r0, r1]
        os_memcpy(&(tx->encode[encode_p]), cache, value_length);
c0d03f12:	6838      	ldr	r0, [r7, #0]
c0d03f14:	6a21      	ldr	r1, [r4, #32]
c0d03f16:	1808      	adds	r0, r1, r0
c0d03f18:	4906      	ldr	r1, [pc, #24]	; (c0d03f34 <encode_proposal_transaction_id+0x5c>)
c0d03f1a:	6809      	ldr	r1, [r1, #0]
c0d03f1c:	462a      	mov	r2, r5
c0d03f1e:	f7fe ff45 	bl	c0d02dac <os_memmove>
        encode_p += value_length;
c0d03f22:	6838      	ldr	r0, [r7, #0]
c0d03f24:	1940      	adds	r0, r0, r5
c0d03f26:	6038      	str	r0, [r7, #0]
c0d03f28:	e001      	b.n	c0d03f2e <encode_proposal_transaction_id+0x56>
    } else {
        tx->encode[encode_p++] = 0;
c0d03f2a:	2100      	movs	r1, #0
c0d03f2c:	7001      	strb	r1, [r0, #0]
    }
}
c0d03f2e:	b003      	add	sp, #12
c0d03f30:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03f32:	46c0      	nop			; (mov r8, r8)
c0d03f34:	200021e8 	.word	0x200021e8
c0d03f38:	706f7270 	.word	0x706f7270
c0d03f3c:	6c61736f 	.word	0x6c61736f
c0d03f40:	6172745f 	.word	0x6172745f
c0d03f44:	6361736e 	.word	0x6361736e
c0d03f48:	6e6f6974 	.word	0x6e6f6974
c0d03f4c:	0064695f 	.word	0x0064695f
c0d03f50:	200021ec 	.word	0x200021ec

c0d03f54 <build_transaction>:
    } else {
        os_memcpy(tx->encode_hex, tx->encode + 32, encode_p - 32);
    }
}

void build_transaction(char *input, int length, transaction *tx){
c0d03f54:	b570      	push	{r4, r5, r6, lr}
c0d03f56:	4614      	mov	r4, r2
c0d03f58:	460d      	mov	r5, r1
c0d03f5a:	4606      	mov	r6, r0

    // log_p = 0;
    

    cache = &(all_data[cache_data_p]);
c0d03f5c:	204b      	movs	r0, #75	; 0x4b
c0d03f5e:	00c0      	lsls	r0, r0, #3
c0d03f60:	4916      	ldr	r1, [pc, #88]	; (c0d03fbc <build_transaction+0x68>)
c0d03f62:	1808      	adds	r0, r1, r0
c0d03f64:	4a16      	ldr	r2, [pc, #88]	; (c0d03fc0 <build_transaction+0x6c>)
c0d03f66:	6010      	str	r0, [r2, #0]
    encode = &(all_data[message_data_p]);
c0d03f68:	4816      	ldr	r0, [pc, #88]	; (c0d03fc4 <build_transaction+0x70>)
c0d03f6a:	6001      	str	r1, [r0, #0]
    
    encode_p = 0;
c0d03f6c:	4816      	ldr	r0, [pc, #88]	; (c0d03fc8 <build_transaction+0x74>)
c0d03f6e:	2200      	movs	r2, #0
c0d03f70:	6002      	str	r2, [r0, #0]
    tx->encode = encode;
c0d03f72:	6221      	str	r1, [r4, #32]
    tx->encode_p = &encode_p;
c0d03f74:	62a0      	str	r0, [r4, #40]	; 0x28

    encode_chain_id(tx); 
c0d03f76:	4620      	mov	r0, r4
c0d03f78:	f7ff fe74 	bl	c0d03c64 <encode_chain_id>
    
    encode_timestamp(input, length, tx); 
c0d03f7c:	4630      	mov	r0, r6
c0d03f7e:	4629      	mov	r1, r5
c0d03f80:	4622      	mov	r2, r4
c0d03f82:	f7ff fe93 	bl	c0d03cac <encode_timestamp>

    encode_expiration(input, length, tx);
c0d03f86:	4630      	mov	r0, r6
c0d03f88:	4629      	mov	r1, r5
c0d03f8a:	4622      	mov	r2, r4
c0d03f8c:	f7ff fec8 	bl	c0d03d20 <encode_expiration>

    encode_operation(input, length, tx);
c0d03f90:	4630      	mov	r0, r6
c0d03f92:	4629      	mov	r1, r5
c0d03f94:	4622      	mov	r2, r4
c0d03f96:	f7ff ff07 	bl	c0d03da8 <encode_operation>
    
    encode_validate_type(input, length, tx);
c0d03f9a:	4630      	mov	r0, r6
c0d03f9c:	4629      	mov	r1, r5
c0d03f9e:	4622      	mov	r2, r4
c0d03fa0:	f7ff ff38 	bl	c0d03e14 <encode_validate_type>

    encode_dapp(input, length, tx);
c0d03fa4:	4630      	mov	r0, r6
c0d03fa6:	4629      	mov	r1, r5
c0d03fa8:	4622      	mov	r2, r4
c0d03faa:	f7ff ff5f 	bl	c0d03e6c <encode_dapp>

    encode_proposal_transaction_id(input, length, tx);
c0d03fae:	4630      	mov	r0, r6
c0d03fb0:	4629      	mov	r1, r5
c0d03fb2:	4622      	mov	r2, r4
c0d03fb4:	f7ff ff90 	bl	c0d03ed8 <encode_proposal_transaction_id>
    // tx->encode_hex[encode_p + 1] = '\0';


    // os_memcpy(tx->encode_hex, &log, log_p);
    // tx->encode_hex[log_p] = '\0';
};
c0d03fb8:	bd70      	pop	{r4, r5, r6, pc}
c0d03fba:	46c0      	nop			; (mov r8, r8)
c0d03fbc:	20001800 	.word	0x20001800
c0d03fc0:	200021e8 	.word	0x200021e8
c0d03fc4:	200021f8 	.word	0x200021f8
c0d03fc8:	200021ec 	.word	0x200021ec

c0d03fcc <u2f_apdu_sign>:

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
}

void u2f_apdu_sign(u2f_service_t *service, uint8_t p1, uint8_t p2,
                     uint8_t *buffer, uint16_t length) {
c0d03fcc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d03fce:	b085      	sub	sp, #20
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_app.apdu_state != APDU_IDLE) {
c0d03fd0:	4a34      	ldr	r2, [pc, #208]	; (c0d040a4 <u2f_apdu_sign+0xd8>)
c0d03fd2:	7812      	ldrb	r2, [r2, #0]
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03fd4:	2483      	movs	r4, #131	; 0x83
    UNUSED(p2);
    uint8_t keyHandleLength;
    uint8_t i;

    // can't process the apdu if another one is already scheduled in
    if (G_io_app.apdu_state != APDU_IDLE) {
c0d03fd6:	2a00      	cmp	r2, #0
c0d03fd8:	d002      	beq.n	c0d03fe0 <u2f_apdu_sign+0x14>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03fda:	4a39      	ldr	r2, [pc, #228]	; (c0d040c0 <u2f_apdu_sign+0xf4>)
c0d03fdc:	447a      	add	r2, pc
c0d03fde:	e009      	b.n	c0d03ff4 <u2f_apdu_sign+0x28>
c0d03fe0:	9a0a      	ldr	r2, [sp, #40]	; 0x28
                  (uint8_t *)SW_BUSY,
                  sizeof(SW_BUSY));
        return;        
    }

    if (length < U2F_HANDLE_SIGN_HEADER_SIZE + 5 /*at least an apdu header*/) {
c0d03fe2:	2a45      	cmp	r2, #69	; 0x45
c0d03fe4:	d802      	bhi.n	c0d03fec <u2f_apdu_sign+0x20>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03fe6:	4a37      	ldr	r2, [pc, #220]	; (c0d040c4 <u2f_apdu_sign+0xf8>)
c0d03fe8:	447a      	add	r2, pc
c0d03fea:	e003      	b.n	c0d03ff4 <u2f_apdu_sign+0x28>
                  sizeof(SW_WRONG_LENGTH));
        return;
    }

    // Confirm immediately if it's just a validation call
    if (p1 == P1_SIGN_CHECK_ONLY) {
c0d03fec:	2907      	cmp	r1, #7
c0d03fee:	d107      	bne.n	c0d04000 <u2f_apdu_sign+0x34>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d03ff0:	4a35      	ldr	r2, [pc, #212]	; (c0d040c8 <u2f_apdu_sign+0xfc>)
c0d03ff2:	447a      	add	r2, pc
c0d03ff4:	2302      	movs	r3, #2
c0d03ff6:	4621      	mov	r1, r4
c0d03ff8:	f000 fcce 	bl	c0d04998 <u2f_message_reply>
    app_dispatch();
    if ((btchip_context_D.io_flags & IO_ASYNCH_REPLY) == 0) {
        u2f_proxy_response(service, btchip_context_D.outLength);
    }
    */
}
c0d03ffc:	b005      	add	sp, #20
c0d03ffe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d04000:	9202      	str	r2, [sp, #8]
c0d04002:	9401      	str	r4, [sp, #4]
c0d04004:	9003      	str	r0, [sp, #12]
                  sizeof(SW_PROOF_OF_PRESENCE_REQUIRED));
        return;
    }

    // Unwrap magic
    keyHandleLength = buffer[U2F_HANDLE_SIGN_HEADER_SIZE-1];
c0d04006:	2040      	movs	r0, #64	; 0x40
c0d04008:	9304      	str	r3, [sp, #16]
c0d0400a:	5c1f      	ldrb	r7, [r3, r0]
    
    // reply to the "get magic" question of the host
    if (keyHandleLength == 5) {
c0d0400c:	2f00      	cmp	r7, #0
c0d0400e:	d018      	beq.n	c0d04042 <u2f_apdu_sign+0x76>
c0d04010:	2f05      	cmp	r7, #5
c0d04012:	9e04      	ldr	r6, [sp, #16]
c0d04014:	d107      	bne.n	c0d04026 <u2f_apdu_sign+0x5a>
        // GET U2F PROXY PARAMETERS
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
c0d04016:	4630      	mov	r0, r6
c0d04018:	3041      	adds	r0, #65	; 0x41
c0d0401a:	a123      	add	r1, pc, #140	; (adr r1, c0d040a8 <u2f_apdu_sign+0xdc>)
c0d0401c:	2205      	movs	r2, #5
c0d0401e:	f7fe fee9 	bl	c0d02df4 <os_memcmp>
c0d04022:	2800      	cmp	r0, #0
c0d04024:	d02b      	beq.n	c0d0407e <u2f_apdu_sign+0xb2>
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
c0d04026:	3641      	adds	r6, #65	; 0x41
c0d04028:	2400      	movs	r4, #0
c0d0402a:	a522      	add	r5, pc, #136	; (adr r5, c0d040b4 <u2f_apdu_sign+0xe8>)
c0d0402c:	b2e0      	uxtb	r0, r4
c0d0402e:	2103      	movs	r1, #3
c0d04030:	f002 fddc 	bl	c0d06bec <__aeabi_uidivmod>
c0d04034:	5d30      	ldrb	r0, [r6, r4]
c0d04036:	5c69      	ldrb	r1, [r5, r1]
c0d04038:	4041      	eors	r1, r0
c0d0403a:	5531      	strb	r1, [r6, r4]
            return;
        }
    }
    

    for (i = 0; i < keyHandleLength; i++) {
c0d0403c:	1c64      	adds	r4, r4, #1
c0d0403e:	42a7      	cmp	r7, r4
c0d04040:	d1f4      	bne.n	c0d0402c <u2f_apdu_sign+0x60>
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
c0d04042:	2045      	movs	r0, #69	; 0x45
c0d04044:	9904      	ldr	r1, [sp, #16]
c0d04046:	5c08      	ldrb	r0, [r1, r0]
c0d04048:	3046      	adds	r0, #70	; 0x46
c0d0404a:	9a02      	ldr	r2, [sp, #8]
c0d0404c:	4282      	cmp	r2, r0
c0d0404e:	d110      	bne.n	c0d04072 <u2f_apdu_sign+0xa6>
                  sizeof(SW_BAD_KEY_HANDLE));
        return;
    }

    // make the apdu available to higher layers
    os_memmove(G_io_apdu_buffer, buffer + U2F_HANDLE_SIGN_HEADER_SIZE, keyHandleLength);
c0d04050:	3141      	adds	r1, #65	; 0x41
c0d04052:	4817      	ldr	r0, [pc, #92]	; (c0d040b0 <u2f_apdu_sign+0xe4>)
c0d04054:	463a      	mov	r2, r7
c0d04056:	f7fe fea9 	bl	c0d02dac <os_memmove>
c0d0405a:	4812      	ldr	r0, [pc, #72]	; (c0d040a4 <u2f_apdu_sign+0xd8>)
c0d0405c:	4601      	mov	r1, r0
    G_io_app.apdu_length = keyHandleLength;
c0d0405e:	804f      	strh	r7, [r1, #2]
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
c0d04060:	2007      	movs	r0, #7
c0d04062:	7188      	strb	r0, [r1, #6]
    G_io_app.apdu_state = APDU_U2F;
c0d04064:	2009      	movs	r0, #9
c0d04066:	7008      	strb	r0, [r1, #0]

    // prepare for asynch reply
    u2f_message_set_autoreply_wait_user_presence(service, true);
c0d04068:	2101      	movs	r1, #1
c0d0406a:	9803      	ldr	r0, [sp, #12]
c0d0406c:	f000 fc80 	bl	c0d04970 <u2f_message_set_autoreply_wait_user_presence>
c0d04070:	e7c4      	b.n	c0d03ffc <u2f_apdu_sign+0x30>
    for (i = 0; i < keyHandleLength; i++) {
        buffer[U2F_HANDLE_SIGN_HEADER_SIZE + i] ^= U2F_PROXY_MAGIC[i % (sizeof(U2F_PROXY_MAGIC)-1)];
    }
    // Check that it looks like an APDU
    if (length != U2F_HANDLE_SIGN_HEADER_SIZE + 5 + buffer[U2F_HANDLE_SIGN_HEADER_SIZE + 4]) {
        u2f_message_reply(service, U2F_CMD_MSG,
c0d04072:	4a16      	ldr	r2, [pc, #88]	; (c0d040cc <u2f_apdu_sign+0x100>)
c0d04074:	447a      	add	r2, pc
c0d04076:	2302      	movs	r3, #2
c0d04078:	9803      	ldr	r0, [sp, #12]
c0d0407a:	9901      	ldr	r1, [sp, #4]
c0d0407c:	e7bc      	b.n	c0d03ff8 <u2f_apdu_sign+0x2c>
        // this apdu is not subject to proxy magic masking
        // APDU is F1 D0 00 00 00 to get the magic proxy
        // RAPDU: <>
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
c0d0407e:	4e0c      	ldr	r6, [pc, #48]	; (c0d040b0 <u2f_apdu_sign+0xe4>)
c0d04080:	2203      	movs	r2, #3
c0d04082:	7032      	strb	r2, [r6, #0]
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
c0d04084:	1c70      	adds	r0, r6, #1
c0d04086:	a10b      	add	r1, pc, #44	; (adr r1, c0d040b4 <u2f_apdu_sign+0xe8>)
c0d04088:	f7fe fe90 	bl	c0d02dac <os_memmove>
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
c0d0408c:	1d30      	adds	r0, r6, #4
c0d0408e:	a10a      	add	r1, pc, #40	; (adr r1, c0d040b8 <u2f_apdu_sign+0xec>)
c0d04090:	2204      	movs	r2, #4
c0d04092:	f7fe fe8b 	bl	c0d02dac <os_memmove>
            u2f_message_reply(service, U2F_CMD_MSG,
                              (uint8_t *)G_io_apdu_buffer,
                              G_io_apdu_buffer[0]+1+2+2);
c0d04096:	7830      	ldrb	r0, [r6, #0]
c0d04098:	1d43      	adds	r3, r0, #5
        if (os_memcmp(buffer+U2F_HANDLE_SIGN_HEADER_SIZE, "\xF1\xD0\x00\x00\x00", 5) == 0 ) {
            // U2F_PROXY_MAGIC is given as a 0 terminated string
            G_io_apdu_buffer[0] = sizeof(U2F_PROXY_MAGIC)-1;
            os_memmove(G_io_apdu_buffer+1, U2F_PROXY_MAGIC, sizeof(U2F_PROXY_MAGIC)-1);
            os_memmove(G_io_apdu_buffer+1+sizeof(U2F_PROXY_MAGIC)-1, "\x90\x00\x90\x00", 4);
            u2f_message_reply(service, U2F_CMD_MSG,
c0d0409a:	9803      	ldr	r0, [sp, #12]
c0d0409c:	9901      	ldr	r1, [sp, #4]
c0d0409e:	4632      	mov	r2, r6
c0d040a0:	e7aa      	b.n	c0d03ff8 <u2f_apdu_sign+0x2c>
c0d040a2:	46c0      	nop			; (mov r8, r8)
c0d040a4:	20002110 	.word	0x20002110
c0d040a8:	0000d0f1 	.word	0x0000d0f1
c0d040ac:	00000000 	.word	0x00000000
c0d040b0:	20001fbc 	.word	0x20001fbc
c0d040b4:	00773077 	.word	0x00773077
c0d040b8:	00900090 	.word	0x00900090
c0d040bc:	00000000 	.word	0x00000000
c0d040c0:	00003185 	.word	0x00003185
c0d040c4:	0000317b 	.word	0x0000317b
c0d040c8:	00003173 	.word	0x00003173
c0d040cc:	000030f3 	.word	0x000030f3

c0d040d0 <u2f_handle_cmd_init>:
}

#endif // U2F_PROXY_MAGIC

void u2f_handle_cmd_init(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length, uint8_t *channelInit) {
c0d040d0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d040d2:	b081      	sub	sp, #4
c0d040d4:	461d      	mov	r5, r3
c0d040d6:	460e      	mov	r6, r1
c0d040d8:	4604      	mov	r4, r0
    // screen_printf("U2F init\n");
    uint8_t channel[4];
    (void)length;
    if (u2f_is_channel_broadcast(channelInit)) {
c0d040da:	4628      	mov	r0, r5
c0d040dc:	f000 fc38 	bl	c0d04950 <u2f_is_channel_broadcast>
c0d040e0:	2801      	cmp	r0, #1
c0d040e2:	d10e      	bne.n	c0d04102 <u2f_handle_cmd_init+0x32>
        // cx_rng(channel, 4); // not available within the IO task
        U4BE_ENCODE(channel, 0, ++service->next_channel);
c0d040e4:	6820      	ldr	r0, [r4, #0]
c0d040e6:	1c41      	adds	r1, r0, #1
c0d040e8:	0e09      	lsrs	r1, r1, #24
c0d040ea:	466a      	mov	r2, sp
c0d040ec:	7011      	strb	r1, [r2, #0]
c0d040ee:	1c81      	adds	r1, r0, #2
c0d040f0:	0c09      	lsrs	r1, r1, #16
c0d040f2:	7051      	strb	r1, [r2, #1]
c0d040f4:	1cc1      	adds	r1, r0, #3
c0d040f6:	0a09      	lsrs	r1, r1, #8
c0d040f8:	7091      	strb	r1, [r2, #2]
c0d040fa:	1d00      	adds	r0, r0, #4
c0d040fc:	6020      	str	r0, [r4, #0]
c0d040fe:	70d0      	strb	r0, [r2, #3]
c0d04100:	e004      	b.n	c0d0410c <u2f_handle_cmd_init+0x3c>
c0d04102:	4668      	mov	r0, sp
    } else {
        os_memmove(channel, channelInit, 4);
c0d04104:	2204      	movs	r2, #4
c0d04106:	4629      	mov	r1, r5
c0d04108:	f7fe fe50 	bl	c0d02dac <os_memmove>
    }
    os_memmove(G_io_apdu_buffer, buffer, 8);
c0d0410c:	4f17      	ldr	r7, [pc, #92]	; (c0d0416c <u2f_handle_cmd_init+0x9c>)
c0d0410e:	2208      	movs	r2, #8
c0d04110:	4638      	mov	r0, r7
c0d04112:	4631      	mov	r1, r6
c0d04114:	f7fe fe4a 	bl	c0d02dac <os_memmove>
    os_memmove(G_io_apdu_buffer + 8, channel, 4);
c0d04118:	4638      	mov	r0, r7
c0d0411a:	3008      	adds	r0, #8
c0d0411c:	4669      	mov	r1, sp
c0d0411e:	2204      	movs	r2, #4
c0d04120:	f7fe fe44 	bl	c0d02dac <os_memmove>
    G_io_apdu_buffer[12] = INIT_U2F_VERSION;
c0d04124:	2002      	movs	r0, #2
c0d04126:	7338      	strb	r0, [r7, #12]
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
c0d04128:	2000      	movs	r0, #0
c0d0412a:	7378      	strb	r0, [r7, #13]
c0d0412c:	2101      	movs	r1, #1
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
c0d0412e:	73b9      	strb	r1, [r7, #14]
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
c0d04130:	73f8      	strb	r0, [r7, #15]
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;
c0d04132:	7438      	strb	r0, [r7, #16]

    if (u2f_is_channel_broadcast(channelInit)) {
c0d04134:	4628      	mov	r0, r5
c0d04136:	f000 fc0b 	bl	c0d04950 <u2f_is_channel_broadcast>
c0d0413a:	4601      	mov	r1, r0
c0d0413c:	1d20      	adds	r0, r4, #4
        os_memset(service->channel, 0xff, 4);
c0d0413e:	2586      	movs	r5, #134	; 0x86
    G_io_apdu_buffer[13] = INIT_DEVICE_VERSION_MAJOR;
    G_io_apdu_buffer[14] = INIT_DEVICE_VERSION_MINOR;
    G_io_apdu_buffer[15] = INIT_BUILD_VERSION;
    G_io_apdu_buffer[16] = INIT_CAPABILITIES;

    if (u2f_is_channel_broadcast(channelInit)) {
c0d04140:	2901      	cmp	r1, #1
c0d04142:	d106      	bne.n	c0d04152 <u2f_handle_cmd_init+0x82>
        os_memset(service->channel, 0xff, 4);
c0d04144:	4629      	mov	r1, r5
c0d04146:	3179      	adds	r1, #121	; 0x79
c0d04148:	b2c9      	uxtb	r1, r1
c0d0414a:	2204      	movs	r2, #4
c0d0414c:	f7fe fe49 	bl	c0d02de2 <os_memset>
c0d04150:	e003      	b.n	c0d0415a <u2f_handle_cmd_init+0x8a>
c0d04152:	4669      	mov	r1, sp
    } else {
        os_memmove(service->channel, channel, 4);
c0d04154:	2204      	movs	r2, #4
c0d04156:	f7fe fe29 	bl	c0d02dac <os_memmove>
    }
    u2f_message_reply(service, U2F_CMD_INIT, G_io_apdu_buffer, 17);
c0d0415a:	4a04      	ldr	r2, [pc, #16]	; (c0d0416c <u2f_handle_cmd_init+0x9c>)
c0d0415c:	2311      	movs	r3, #17
c0d0415e:	4620      	mov	r0, r4
c0d04160:	4629      	mov	r1, r5
c0d04162:	f000 fc19 	bl	c0d04998 <u2f_message_reply>
}
c0d04166:	b001      	add	sp, #4
c0d04168:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0416a:	46c0      	nop			; (mov r8, r8)
c0d0416c:	20001fbc 	.word	0x20001fbc

c0d04170 <u2f_handle_cmd_msg>:
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
c0d04170:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04172:	b085      	sub	sp, #20
c0d04174:	4615      	mov	r5, r2
c0d04176:	460c      	mov	r4, r1
c0d04178:	9004      	str	r0, [sp, #16]
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
c0d0417a:	79a0      	ldrb	r0, [r4, #6]
c0d0417c:	7961      	ldrb	r1, [r4, #5]
c0d0417e:	020e      	lsls	r6, r1, #8
c0d04180:	4306      	orrs	r6, r0
void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
c0d04182:	78a0      	ldrb	r0, [r4, #2]

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
    uint8_t ins = buffer[1];
c0d04184:	9002      	str	r0, [sp, #8]
c0d04186:	7861      	ldrb	r1, [r4, #1]
}

void u2f_handle_cmd_msg(u2f_service_t *service, uint8_t *buffer,
                        uint16_t length) {
    // screen_printf("U2F msg\n");
    uint8_t cla = buffer[0];
c0d04188:	7827      	ldrb	r7, [r4, #0]
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d0418a:	3a09      	subs	r2, #9
c0d0418c:	b290      	uxth	r0, r2
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d0418e:	2383      	movs	r3, #131	; 0x83
c0d04190:	9303      	str	r3, [sp, #12]
c0d04192:	4b1f      	ldr	r3, [pc, #124]	; (c0d04210 <u2f_handle_cmd_msg+0xa0>)
    uint8_t ins = buffer[1];
    uint8_t p1 = buffer[2];
    uint8_t p2 = buffer[3];
    // in extended length buffer[4] must be 0
    uint32_t dataLength = /*(buffer[4] << 16) |*/ (buffer[5] << 8) | (buffer[6]);
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
c0d04194:	4286      	cmp	r6, r0
c0d04196:	d003      	beq.n	c0d041a0 <u2f_handle_cmd_msg+0x30>
c0d04198:	1fed      	subs	r5, r5, #7
c0d0419a:	402b      	ands	r3, r5
c0d0419c:	429e      	cmp	r6, r3
c0d0419e:	d11b      	bne.n	c0d041d8 <u2f_handle_cmd_msg+0x68>
c0d041a0:	4632      	mov	r2, r6
    G_io_app.apdu_media = IO_APDU_MEDIA_U2F; // the effective transport is managed by the U2F layer
    G_io_app.apdu_state = APDU_U2F;

#else // U2F_PROXY_MAGIC

    if (cla != FIDO_CLA) {
c0d041a2:	2f00      	cmp	r7, #0
c0d041a4:	d008      	beq.n	c0d041b8 <u2f_handle_cmd_msg+0x48>
        u2f_message_reply(service, U2F_CMD_MSG,
c0d041a6:	4a1b      	ldr	r2, [pc, #108]	; (c0d04214 <u2f_handle_cmd_msg+0xa4>)
c0d041a8:	447a      	add	r2, pc
c0d041aa:	2302      	movs	r3, #2
c0d041ac:	9804      	ldr	r0, [sp, #16]
c0d041ae:	9903      	ldr	r1, [sp, #12]
c0d041b0:	f000 fbf2 	bl	c0d04998 <u2f_message_reply>
                 sizeof(SW_UNKNOWN_INSTRUCTION));
        return;
    }

#endif // U2F_PROXY_MAGIC
}
c0d041b4:	b005      	add	sp, #20
c0d041b6:	bdf0      	pop	{r4, r5, r6, r7, pc}
        u2f_message_reply(service, U2F_CMD_MSG,
                  (uint8_t *)SW_UNKNOWN_CLASS,
                  sizeof(SW_UNKNOWN_CLASS));
        return;
    }
    switch (ins) {
c0d041b8:	2902      	cmp	r1, #2
c0d041ba:	dc17      	bgt.n	c0d041ec <u2f_handle_cmd_msg+0x7c>
c0d041bc:	2901      	cmp	r1, #1
c0d041be:	d020      	beq.n	c0d04202 <u2f_handle_cmd_msg+0x92>
c0d041c0:	2902      	cmp	r1, #2
c0d041c2:	d11b      	bne.n	c0d041fc <u2f_handle_cmd_msg+0x8c>
        // screen_printf("enroll\n");
        u2f_apdu_enroll(service, p1, p2, buffer + 7, dataLength);
        break;
    case FIDO_INS_SIGN:
        // screen_printf("sign\n");
        u2f_apdu_sign(service, p1, p2, buffer + 7, dataLength);
c0d041c4:	b290      	uxth	r0, r2
c0d041c6:	4669      	mov	r1, sp
c0d041c8:	6008      	str	r0, [r1, #0]
c0d041ca:	1de3      	adds	r3, r4, #7
c0d041cc:	2200      	movs	r2, #0
c0d041ce:	9804      	ldr	r0, [sp, #16]
c0d041d0:	9902      	ldr	r1, [sp, #8]
c0d041d2:	f7ff fefb 	bl	c0d03fcc <u2f_apdu_sign>
c0d041d6:	e7ed      	b.n	c0d041b4 <u2f_handle_cmd_msg+0x44>
    if (dataLength == (uint16_t)(length - 9) || dataLength == (uint16_t)(length - 7)) {
        // Le is optional
        // nominal case from the specification
    }
    // circumvent google chrome extended length encoding done on the last byte only (module 256) but all data being transferred
    else if (dataLength == (uint16_t)(length - 9)%256) {
c0d041d8:	b2d0      	uxtb	r0, r2
c0d041da:	4286      	cmp	r6, r0
c0d041dc:	d0e1      	beq.n	c0d041a2 <u2f_handle_cmd_msg+0x32>
        dataLength = length - 9;
    }
    else if (dataLength == (uint16_t)(length - 7)%256) {
c0d041de:	b2e8      	uxtb	r0, r5
c0d041e0:	4286      	cmp	r6, r0
c0d041e2:	462a      	mov	r2, r5
c0d041e4:	d0dd      	beq.n	c0d041a2 <u2f_handle_cmd_msg+0x32>
        dataLength = length - 7;
    }    
    else { 
        // invalid size
        u2f_message_reply(service, U2F_CMD_MSG,
c0d041e6:	4a0c      	ldr	r2, [pc, #48]	; (c0d04218 <u2f_handle_cmd_msg+0xa8>)
c0d041e8:	447a      	add	r2, pc
c0d041ea:	e7de      	b.n	c0d041aa <u2f_handle_cmd_msg+0x3a>
c0d041ec:	2903      	cmp	r1, #3
c0d041ee:	d00b      	beq.n	c0d04208 <u2f_handle_cmd_msg+0x98>
c0d041f0:	29c1      	cmp	r1, #193	; 0xc1
c0d041f2:	d103      	bne.n	c0d041fc <u2f_handle_cmd_msg+0x8c>
                            uint8_t *buffer, uint16_t length) {
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)INFO, sizeof(INFO));
c0d041f4:	4a09      	ldr	r2, [pc, #36]	; (c0d0421c <u2f_handle_cmd_msg+0xac>)
c0d041f6:	447a      	add	r2, pc
c0d041f8:	2304      	movs	r3, #4
c0d041fa:	e7d7      	b.n	c0d041ac <u2f_handle_cmd_msg+0x3c>
        u2f_apdu_get_info(service, p1, p2, buffer + 7, dataLength);
        break;

    default:
        // screen_printf("unsupported\n");
        u2f_message_reply(service, U2F_CMD_MSG,
c0d041fc:	4a0a      	ldr	r2, [pc, #40]	; (c0d04228 <u2f_handle_cmd_msg+0xb8>)
c0d041fe:	447a      	add	r2, pc
c0d04200:	e7d3      	b.n	c0d041aa <u2f_handle_cmd_msg+0x3a>
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);

    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)SW_INTERNAL, sizeof(SW_INTERNAL));
c0d04202:	4a07      	ldr	r2, [pc, #28]	; (c0d04220 <u2f_handle_cmd_msg+0xb0>)
c0d04204:	447a      	add	r2, pc
c0d04206:	e7d0      	b.n	c0d041aa <u2f_handle_cmd_msg+0x3a>
    // screen_printf("U2F version\n");
    UNUSED(p1);
    UNUSED(p2);
    UNUSED(buffer);
    UNUSED(length);
    u2f_message_reply(service, U2F_CMD_MSG, (uint8_t *)U2F_VERSION, sizeof(U2F_VERSION));
c0d04208:	4a06      	ldr	r2, [pc, #24]	; (c0d04224 <u2f_handle_cmd_msg+0xb4>)
c0d0420a:	447a      	add	r2, pc
c0d0420c:	2308      	movs	r3, #8
c0d0420e:	e7cd      	b.n	c0d041ac <u2f_handle_cmd_msg+0x3c>
c0d04210:	0000ffff 	.word	0x0000ffff
c0d04214:	00002fcd 	.word	0x00002fcd
c0d04218:	00002f7b 	.word	0x00002f7b
c0d0421c:	00002f7b 	.word	0x00002f7b
c0d04220:	00002f5b 	.word	0x00002f5b
c0d04224:	00002f5f 	.word	0x00002f5f
c0d04228:	00002f79 	.word	0x00002f79

c0d0422c <u2f_message_complete>:
    }

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
c0d0422c:	b580      	push	{r7, lr}
    uint8_t cmd = service->transportBuffer[0];
c0d0422e:	69c1      	ldr	r1, [r0, #28]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
c0d04230:	788a      	ldrb	r2, [r1, #2]
c0d04232:	784b      	ldrb	r3, [r1, #1]
c0d04234:	021b      	lsls	r3, r3, #8
c0d04236:	4313      	orrs	r3, r2

#endif // U2F_PROXY_MAGIC
}

void u2f_message_complete(u2f_service_t *service) {
    uint8_t cmd = service->transportBuffer[0];
c0d04238:	780a      	ldrb	r2, [r1, #0]
    uint16_t length = (service->transportBuffer[1] << 8) | (service->transportBuffer[2]);
    switch (cmd) {
c0d0423a:	2a81      	cmp	r2, #129	; 0x81
c0d0423c:	d009      	beq.n	c0d04252 <u2f_message_complete+0x26>
c0d0423e:	2a83      	cmp	r2, #131	; 0x83
c0d04240:	d00c      	beq.n	c0d0425c <u2f_message_complete+0x30>
c0d04242:	2a86      	cmp	r2, #134	; 0x86
c0d04244:	d10e      	bne.n	c0d04264 <u2f_message_complete+0x38>
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
c0d04246:	1cc9      	adds	r1, r1, #3
c0d04248:	1d03      	adds	r3, r0, #4
c0d0424a:	2200      	movs	r2, #0
c0d0424c:	f7ff ff40 	bl	c0d040d0 <u2f_handle_cmd_init>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d04250:	bd80      	pop	{r7, pc}
    switch (cmd) {
    case U2F_CMD_INIT:
        u2f_handle_cmd_init(service, service->transportBuffer + 3, length, service->channel);
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
c0d04252:	1cca      	adds	r2, r1, #3
}

void u2f_handle_cmd_ping(u2f_service_t *service, uint8_t *buffer,
                         uint16_t length) {
    // screen_printf("U2F ping\n");
    u2f_message_reply(service, U2F_CMD_PING, buffer, length);
c0d04254:	2181      	movs	r1, #129	; 0x81
c0d04256:	f000 fb9f 	bl	c0d04998 <u2f_message_reply>
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
        break;
    }
}
c0d0425a:	bd80      	pop	{r7, pc}
        break;
    case U2F_CMD_PING:
        u2f_handle_cmd_ping(service, service->transportBuffer + 3, length);
        break;
    case U2F_CMD_MSG:
        u2f_handle_cmd_msg(service, service->transportBuffer + 3, length);
c0d0425c:	1cc9      	adds	r1, r1, #3
c0d0425e:	461a      	mov	r2, r3
c0d04260:	f7ff ff86 	bl	c0d04170 <u2f_handle_cmd_msg>
        break;
    }
}
c0d04264:	bd80      	pop	{r7, pc}
	...

c0d04268 <u2f_io_send>:
#include "u2f_processing.h"
#include "u2f_impl.h"

#include "os_io_seproxyhal.h"

void u2f_io_send(uint8_t *buffer, uint16_t length, u2f_transport_media_t media) {
c0d04268:	b570      	push	{r4, r5, r6, lr}
c0d0426a:	460d      	mov	r5, r1
c0d0426c:	4601      	mov	r1, r0
    if (media == U2F_MEDIA_USB) {
c0d0426e:	2a01      	cmp	r2, #1
c0d04270:	d111      	bne.n	c0d04296 <u2f_io_send+0x2e>
        os_memmove(G_io_usb_ep_buffer, buffer, length);
c0d04272:	4c09      	ldr	r4, [pc, #36]	; (c0d04298 <u2f_io_send+0x30>)
c0d04274:	4620      	mov	r0, r4
c0d04276:	462a      	mov	r2, r5
c0d04278:	f7fe fd98 	bl	c0d02dac <os_memmove>
        // wipe the remaining to avoid :
        // 1/ data leaks
        // 2/ invalid junk
        os_memset(G_io_usb_ep_buffer+length, 0, sizeof(G_io_usb_ep_buffer)-length);
c0d0427c:	1960      	adds	r0, r4, r5
c0d0427e:	2640      	movs	r6, #64	; 0x40
c0d04280:	1b72      	subs	r2, r6, r5
c0d04282:	2500      	movs	r5, #0
c0d04284:	4629      	mov	r1, r5
c0d04286:	f7fe fdac 	bl	c0d02de2 <os_memset>
    }
    switch (media) {
    case U2F_MEDIA_USB:
        io_usb_send_ep(U2F_EPIN_ADDR, G_io_usb_ep_buffer, USB_SEGMENT_SIZE, 0);
c0d0428a:	2081      	movs	r0, #129	; 0x81
c0d0428c:	4621      	mov	r1, r4
c0d0428e:	4632      	mov	r2, r6
c0d04290:	462b      	mov	r3, r5
c0d04292:	f7fe fe5d 	bl	c0d02f50 <io_usb_send_ep>
#endif
    default:
        PRINTF("Request to send on unsupported media %d\n", media);
        break;
    }
}
c0d04296:	bd70      	pop	{r4, r5, r6, pc}
c0d04298:	20002174 	.word	0x20002174

c0d0429c <u2f_transport_init>:

/**
 * Initialize the u2f transport and provide the buffer into which to store incoming message
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
c0d0429c:	60c1      	str	r1, [r0, #12]
    service->transportReceiveBufferLength = message_buffer_length;
c0d0429e:	8202      	strh	r2, [r0, #16]
c0d042a0:	2200      	movs	r2, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d042a2:	82c2      	strh	r2, [r0, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d042a4:	7682      	strb	r2, [r0, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d042a6:	232b      	movs	r3, #43	; 0x2b
c0d042a8:	54c2      	strb	r2, [r0, r3]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d042aa:	232a      	movs	r3, #42	; 0x2a
c0d042ac:	54c2      	strb	r2, [r0, r3]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d042ae:	8482      	strh	r2, [r0, #36]	; 0x24
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d042b0:	61c1      	str	r1, [r0, #28]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d042b2:	6202      	str	r2, [r0, #32]
 */
void u2f_transport_init(u2f_service_t *service, uint8_t* message_buffer, uint16_t message_buffer_length) {
    service->transportReceiveBuffer = message_buffer;
    service->transportReceiveBufferLength = message_buffer_length;
    u2f_transport_reset(service);
}
c0d042b4:	4770      	bx	lr
	...

c0d042b8 <u2f_transport_sent>:

/**
 * Function called when the previously scheduled message to be sent on the media is effectively sent.
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {
c0d042b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d042ba:	b083      	sub	sp, #12
c0d042bc:	460d      	mov	r5, r1
c0d042be:	4604      	mov	r4, r0

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d042c0:	202a      	movs	r0, #42	; 0x2a
c0d042c2:	5c21      	ldrb	r1, [r4, r0]
c0d042c4:	4620      	mov	r0, r4
c0d042c6:	302a      	adds	r0, #42	; 0x2a
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d042c8:	2901      	cmp	r1, #1
c0d042ca:	d049      	beq.n	c0d04360 <u2f_transport_sent+0xa8>
c0d042cc:	2900      	cmp	r1, #0
c0d042ce:	d13a      	bne.n	c0d04346 <u2f_transport_sent+0x8e>
c0d042d0:	212b      	movs	r1, #43	; 0x2b
c0d042d2:	2200      	movs	r2, #0
c0d042d4:	5462      	strb	r2, [r4, r1]
c0d042d6:	4626      	mov	r6, r4
c0d042d8:	362b      	adds	r6, #43	; 0x2b

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d042da:	2120      	movs	r1, #32
c0d042dc:	5c62      	ldrb	r2, [r4, r1]
        && service->transportState != U2F_SENDING_ERROR) {
c0d042de:	1ed2      	subs	r2, r2, #3
c0d042e0:	b2d2      	uxtb	r2, r2

    // previous mark packet as sent
    service->sending = false;

    // if idle (possibly after an error), then only await for a transmission 
    if (service->transportState != U2F_SENDING_RESPONSE 
c0d042e2:	4627      	mov	r7, r4
c0d042e4:	3720      	adds	r7, #32
        && service->transportState != U2F_SENDING_ERROR) {
c0d042e6:	2a01      	cmp	r2, #1
c0d042e8:	d83d      	bhi.n	c0d04366 <u2f_transport_sent+0xae>
        // absorb the error, transport is erroneous but that won't hurt in the end.
        // also absorb the fake channel user presence check reply ack
        //THROW(INVALID_STATE);
        return;
    }
    if (service->transportOffset < service->transportLength) {
c0d042ea:	8b22      	ldrh	r2, [r4, #24]
c0d042ec:	8ae3      	ldrh	r3, [r4, #22]
c0d042ee:	429a      	cmp	r2, r3
c0d042f0:	d93b      	bls.n	c0d0436a <u2f_transport_sent+0xb2>
        uint16_t mtu = (media == U2F_MEDIA_USB) ? USB_SEGMENT_SIZE : BLE_SEGMENT_SIZE;
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
c0d042f2:	2604      	movs	r6, #4
c0d042f4:	2000      	movs	r0, #0
c0d042f6:	2d01      	cmp	r5, #1
c0d042f8:	d000      	beq.n	c0d042fc <u2f_transport_sent+0x44>
c0d042fa:	4606      	mov	r6, r0
c0d042fc:	9601      	str	r6, [sp, #4]
c0d042fe:	9002      	str	r0, [sp, #8]
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
c0d04300:	7ea0      	ldrb	r0, [r4, #26]
c0d04302:	2603      	movs	r6, #3
c0d04304:	2701      	movs	r7, #1
c0d04306:	9700      	str	r7, [sp, #0]
c0d04308:	4637      	mov	r7, r6
c0d0430a:	2800      	cmp	r0, #0
c0d0430c:	d000      	beq.n	c0d04310 <u2f_transport_sent+0x58>
c0d0430e:	9f00      	ldr	r7, [sp, #0]
c0d04310:	9e01      	ldr	r6, [sp, #4]
c0d04312:	4337      	orrs	r7, r6
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
c0d04314:	2640      	movs	r6, #64	; 0x40
c0d04316:	2d01      	cmp	r5, #1
c0d04318:	d000      	beq.n	c0d0431c <u2f_transport_sent+0x64>
c0d0431a:	460e      	mov	r6, r1
c0d0431c:	1bf6      	subs	r6, r6, r7
        uint16_t channelHeader =
            (media == U2F_MEDIA_USB ? 4 : 0);
        uint8_t headerSize =
            (service->transportPacketIndex == 0 ? (channelHeader + 3)
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
c0d0431e:	1ad1      	subs	r1, r2, r3
c0d04320:	42b1      	cmp	r1, r6
c0d04322:	dc00      	bgt.n	c0d04326 <u2f_transport_sent+0x6e>
c0d04324:	460e      	mov	r6, r1
                                      (mtu - headerSize)
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
c0d04326:	19f1      	adds	r1, r6, r7
        uint16_t offset = 0;
        // Fragment
        if (media == U2F_MEDIA_USB) {
c0d04328:	9101      	str	r1, [sp, #4]
c0d0432a:	2d01      	cmp	r5, #1
c0d0432c:	d106      	bne.n	c0d0433c <u2f_transport_sent+0x84>
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d0432e:	1d21      	adds	r1, r4, #4
c0d04330:	4828      	ldr	r0, [pc, #160]	; (c0d043d4 <u2f_transport_sent+0x11c>)
c0d04332:	2204      	movs	r2, #4
c0d04334:	9202      	str	r2, [sp, #8]
c0d04336:	f7fe fd39 	bl	c0d02dac <os_memmove>
c0d0433a:	7ea0      	ldrb	r0, [r4, #26]
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
c0d0433c:	2800      	cmp	r0, #0
c0d0433e:	d021      	beq.n	c0d04384 <u2f_transport_sent+0xcc>
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
c0d04340:	30ff      	adds	r0, #255	; 0xff
c0d04342:	9902      	ldr	r1, [sp, #8]
c0d04344:	e02b      	b.n	c0d0439e <u2f_transport_sent+0xe6>
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d04346:	2125      	movs	r1, #37	; 0x25
c0d04348:	5c61      	ldrb	r1, [r4, r1]
            && service->sending == false)
c0d0434a:	2906      	cmp	r1, #6
c0d0434c:	d108      	bne.n	c0d04360 <u2f_transport_sent+0xa8>
c0d0434e:	212b      	movs	r1, #43	; 0x2b
c0d04350:	5c62      	ldrb	r2, [r4, r1]
c0d04352:	2300      	movs	r3, #0
c0d04354:	5463      	strb	r3, [r4, r1]
c0d04356:	4626      	mov	r6, r4
c0d04358:	362b      	adds	r6, #43	; 0x2b
 * And a new message can be scheduled.
 */
void u2f_transport_sent(u2f_service_t* service, u2f_transport_media_t media) {

    // don't process when replying to anti timeout requests
    if (!u2f_message_repliable(service)) {
c0d0435a:	2a00      	cmp	r2, #0
c0d0435c:	d103      	bne.n	c0d04366 <u2f_transport_sent+0xae>
c0d0435e:	e7bc      	b.n	c0d042da <u2f_transport_sent+0x22>
c0d04360:	202b      	movs	r0, #43	; 0x2b
c0d04362:	2100      	movs	r1, #0
c0d04364:	5421      	strb	r1, [r4, r0]
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}
c0d04366:	b003      	add	sp, #12
c0d04368:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0436a:	d1fc      	bne.n	c0d04366 <u2f_transport_sent+0xae>
c0d0436c:	2100      	movs	r1, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0436e:	82e1      	strh	r1, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d04370:	76a1      	strb	r1, [r4, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d04372:	7031      	strb	r1, [r6, #0]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d04374:	7001      	strb	r1, [r0, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d04376:	80b9      	strh	r1, [r7, #4]
c0d04378:	6039      	str	r1, [r7, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d0437a:	68e0      	ldr	r0, [r4, #12]
c0d0437c:	61e0      	str	r0, [r4, #28]
    }
    // last part sent
    else if (service->transportOffset == service->transportLength) {
        u2f_transport_reset(service);
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
c0d0437e:	4814      	ldr	r0, [pc, #80]	; (c0d043d0 <u2f_transport_sent+0x118>)
c0d04380:	7001      	strb	r1, [r0, #0]
c0d04382:	e7f0      	b.n	c0d04366 <u2f_transport_sent+0xae>
        if (media == U2F_MEDIA_USB) {
            os_memmove(G_io_usb_ep_buffer, service->channel, 4);
            offset += 4;
        }
        if (service->transportPacketIndex == 0) {
            G_io_usb_ep_buffer[offset++] = service->sendCmd;
c0d04384:	2040      	movs	r0, #64	; 0x40
c0d04386:	5c20      	ldrb	r0, [r4, r0]
c0d04388:	9b02      	ldr	r3, [sp, #8]
c0d0438a:	b299      	uxth	r1, r3
c0d0438c:	4a11      	ldr	r2, [pc, #68]	; (c0d043d4 <u2f_transport_sent+0x11c>)
c0d0438e:	5450      	strb	r0, [r2, r1]
c0d04390:	2001      	movs	r0, #1
c0d04392:	4318      	orrs	r0, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength >> 8);
c0d04394:	b281      	uxth	r1, r0
c0d04396:	7e63      	ldrb	r3, [r4, #25]
c0d04398:	5453      	strb	r3, [r2, r1]
c0d0439a:	1c41      	adds	r1, r0, #1
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
c0d0439c:	7e20      	ldrb	r0, [r4, #24]
c0d0439e:	b289      	uxth	r1, r1
c0d043a0:	4b0c      	ldr	r3, [pc, #48]	; (c0d043d4 <u2f_transport_sent+0x11c>)
c0d043a2:	5458      	strb	r0, [r3, r1]
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
c0d043a4:	69e1      	ldr	r1, [r4, #28]
c0d043a6:	2900      	cmp	r1, #0
c0d043a8:	d005      	beq.n	c0d043b6 <u2f_transport_sent+0xfe>
                                                : (channelHeader + 1));
        uint16_t blockSize = ((service->transportLength - service->transportOffset) >
                                      (mtu - headerSize)
                                  ? (mtu - headerSize)
                                  : service->transportLength - service->transportOffset);
        uint16_t dataSize = blockSize + headerSize;
c0d043aa:	b2b2      	uxth	r2, r6
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d043ac:	19d8      	adds	r0, r3, r7
                       service->transportBuffer + service->transportOffset, blockSize);
c0d043ae:	8ae3      	ldrh	r3, [r4, #22]
c0d043b0:	18c9      	adds	r1, r1, r3
            G_io_usb_ep_buffer[offset++] = (service->transportLength & 0xff);
        } else {
            G_io_usb_ep_buffer[offset++] = (service->transportPacketIndex - 1);
        }
        if (service->transportBuffer != NULL) {
            os_memmove(G_io_usb_ep_buffer + headerSize,
c0d043b2:	f7fe fcfb 	bl	c0d02dac <os_memmove>
                       service->transportBuffer + service->transportOffset, blockSize);
        }
        service->transportOffset += blockSize;
c0d043b6:	8ae0      	ldrh	r0, [r4, #22]
c0d043b8:	1980      	adds	r0, r0, r6
c0d043ba:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d043bc:	7ea0      	ldrb	r0, [r4, #26]
c0d043be:	1c40      	adds	r0, r0, #1
c0d043c0:	76a0      	strb	r0, [r4, #26]
        u2f_io_send(G_io_usb_ep_buffer, dataSize, media);
c0d043c2:	9801      	ldr	r0, [sp, #4]
c0d043c4:	b281      	uxth	r1, r0
c0d043c6:	4803      	ldr	r0, [pc, #12]	; (c0d043d4 <u2f_transport_sent+0x11c>)
c0d043c8:	462a      	mov	r2, r5
c0d043ca:	f7ff ff4d 	bl	c0d04268 <u2f_io_send>
c0d043ce:	e7ca      	b.n	c0d04366 <u2f_transport_sent+0xae>
c0d043d0:	20002110 	.word	0x20002110
c0d043d4:	20002174 	.word	0x20002174

c0d043d8 <u2f_message_repliable>:
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}

bool u2f_message_repliable(u2f_service_t* service) {
c0d043d8:	4601      	mov	r1, r0
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d043da:	202a      	movs	r0, #42	; 0x2a
c0d043dc:	5c0a      	ldrb	r2, [r1, r0]
c0d043de:	2001      	movs	r0, #1
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d043e0:	2a00      	cmp	r2, #0
c0d043e2:	d010      	beq.n	c0d04406 <u2f_message_repliable+0x2e>
c0d043e4:	2a01      	cmp	r2, #1
c0d043e6:	d101      	bne.n	c0d043ec <u2f_message_repliable+0x14>
c0d043e8:	2000      	movs	r0, #0

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d043ea:	4770      	bx	lr
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d043ec:	2025      	movs	r0, #37	; 0x25
c0d043ee:	5c0a      	ldrb	r2, [r1, r0]
c0d043f0:	2000      	movs	r0, #0
            && service->sending == false)
c0d043f2:	2a06      	cmp	r2, #6
c0d043f4:	d107      	bne.n	c0d04406 <u2f_message_repliable+0x2e>
c0d043f6:	202b      	movs	r0, #43	; 0x2b
c0d043f8:	5c0a      	ldrb	r2, [r1, r0]
c0d043fa:	2001      	movs	r0, #1
c0d043fc:	2100      	movs	r1, #0
c0d043fe:	2a00      	cmp	r2, #0
c0d04400:	d001      	beq.n	c0d04406 <u2f_message_repliable+0x2e>
c0d04402:	4608      	mov	r0, r1

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d04404:	4770      	bx	lr
c0d04406:	4770      	bx	lr

c0d04408 <u2f_transport_send_usb_user_presence_required>:
        // we sent the whole response (even if we haven't yet received the ack for the last sent usb in packet)
        G_io_app.apdu_state = APDU_IDLE;
    }
}

void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
c0d04408:	b5b0      	push	{r4, r5, r7, lr}
    uint16_t offset = 0;
    service->sending = true;
c0d0440a:	212b      	movs	r1, #43	; 0x2b
c0d0440c:	2401      	movs	r4, #1
c0d0440e:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d04410:	1d01      	adds	r1, r0, #4
c0d04412:	4d0b      	ldr	r5, [pc, #44]	; (c0d04440 <u2f_transport_send_usb_user_presence_required+0x38>)
c0d04414:	2204      	movs	r2, #4
c0d04416:	4628      	mov	r0, r5
c0d04418:	f7fe fcc8 	bl	c0d02dac <os_memmove>
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
    G_io_usb_ep_buffer[offset++] = 0;
    G_io_usb_ep_buffer[offset++] = 2;
    G_io_usb_ep_buffer[offset++] = 0x69;
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d0441c:	2083      	movs	r0, #131	; 0x83
void u2f_transport_send_usb_user_presence_required(u2f_service_t *service) {
    uint16_t offset = 0;
    service->sending = true;
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_MSG;
c0d0441e:	7128      	strb	r0, [r5, #4]
    G_io_usb_ep_buffer[offset++] = 0;
c0d04420:	2000      	movs	r0, #0
c0d04422:	7168      	strb	r0, [r5, #5]
    G_io_usb_ep_buffer[offset++] = 2;
c0d04424:	2002      	movs	r0, #2
c0d04426:	71a8      	strb	r0, [r5, #6]
    G_io_usb_ep_buffer[offset++] = 0x69;
c0d04428:	2069      	movs	r0, #105	; 0x69
c0d0442a:	71e8      	strb	r0, [r5, #7]
    G_io_usb_ep_buffer[offset++] = 0x85;
c0d0442c:	207c      	movs	r0, #124	; 0x7c
c0d0442e:	43c0      	mvns	r0, r0
c0d04430:	1c80      	adds	r0, r0, #2
c0d04432:	7228      	strb	r0, [r5, #8]
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d04434:	2109      	movs	r1, #9
c0d04436:	4628      	mov	r0, r5
c0d04438:	4622      	mov	r2, r4
c0d0443a:	f7ff ff15 	bl	c0d04268 <u2f_io_send>
}
c0d0443e:	bdb0      	pop	{r4, r5, r7, pc}
c0d04440:	20002174 	.word	0x20002174

c0d04444 <u2f_transport_send_wink>:

void u2f_transport_send_wink(u2f_service_t *service) {
c0d04444:	b5b0      	push	{r4, r5, r7, lr}
    uint16_t offset = 0;
    service->sending = true;
c0d04446:	212b      	movs	r1, #43	; 0x2b
c0d04448:	2401      	movs	r4, #1
c0d0444a:	5444      	strb	r4, [r0, r1]
    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d0444c:	1d01      	adds	r1, r0, #4
c0d0444e:	4d08      	ldr	r5, [pc, #32]	; (c0d04470 <u2f_transport_send_wink+0x2c>)
c0d04450:	2204      	movs	r2, #4
c0d04452:	4628      	mov	r0, r5
c0d04454:	f7fe fcaa 	bl	c0d02dac <os_memmove>
    offset += 4;
    G_io_usb_ep_buffer[offset++] = U2F_CMD_WINK;
c0d04458:	2088      	movs	r0, #136	; 0x88
c0d0445a:	7128      	strb	r0, [r5, #4]
    G_io_usb_ep_buffer[offset++] = 0;
c0d0445c:	2000      	movs	r0, #0
c0d0445e:	7168      	strb	r0, [r5, #5]
    G_io_usb_ep_buffer[offset++] = 0;
c0d04460:	71a8      	strb	r0, [r5, #6]
    u2f_io_send(G_io_usb_ep_buffer, offset, U2F_MEDIA_USB);
c0d04462:	2107      	movs	r1, #7
c0d04464:	4628      	mov	r0, r5
c0d04466:	4622      	mov	r2, r4
c0d04468:	f7ff fefe 	bl	c0d04268 <u2f_io_send>
}
c0d0446c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0446e:	46c0      	nop			; (mov r8, r8)
c0d04470:	20002174 	.word	0x20002174

c0d04474 <u2f_transport_receive_fakeChannel>:

bool u2f_transport_receive_fakeChannel(u2f_service_t *service, uint8_t *buffer, uint16_t size) {
c0d04474:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04476:	b083      	sub	sp, #12
c0d04478:	4604      	mov	r4, r0
    if (service->fakeChannelTransportState == U2F_INTERNAL_ERROR) {
c0d0447a:	2025      	movs	r0, #37	; 0x25
c0d0447c:	5c23      	ldrb	r3, [r4, r0]
c0d0447e:	4627      	mov	r7, r4
c0d04480:	3725      	adds	r7, #37	; 0x25
c0d04482:	2000      	movs	r0, #0
c0d04484:	2b05      	cmp	r3, #5
c0d04486:	d075      	beq.n	c0d04574 <u2f_transport_receive_fakeChannel+0x100>
c0d04488:	9202      	str	r2, [sp, #8]
        return false;
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
c0d0448a:	7808      	ldrb	r0, [r1, #0]
c0d0448c:	784a      	ldrb	r2, [r1, #1]
c0d0448e:	0212      	lsls	r2, r2, #8
c0d04490:	4302      	orrs	r2, r0
c0d04492:	7888      	ldrb	r0, [r1, #2]
c0d04494:	78cb      	ldrb	r3, [r1, #3]
c0d04496:	021b      	lsls	r3, r3, #8
c0d04498:	4303      	orrs	r3, r0
c0d0449a:	0418      	lsls	r0, r3, #16
c0d0449c:	4310      	orrs	r0, r2
c0d0449e:	7922      	ldrb	r2, [r4, #4]
c0d044a0:	7963      	ldrb	r3, [r4, #5]
c0d044a2:	021b      	lsls	r3, r3, #8
c0d044a4:	4313      	orrs	r3, r2
c0d044a6:	79a2      	ldrb	r2, [r4, #6]
c0d044a8:	79e5      	ldrb	r5, [r4, #7]
c0d044aa:	022d      	lsls	r5, r5, #8
c0d044ac:	4315      	orrs	r5, r2
c0d044ae:	042a      	lsls	r2, r5, #16
c0d044b0:	431a      	orrs	r2, r3
c0d044b2:	4282      	cmp	r2, r0
c0d044b4:	d160      	bne.n	c0d04578 <u2f_transport_receive_fakeChannel+0x104>
c0d044b6:	790e      	ldrb	r6, [r1, #4]
c0d044b8:	1d0d      	adds	r5, r1, #4
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
c0d044ba:	8c60      	ldrh	r0, [r4, #34]	; 0x22
c0d044bc:	2301      	movs	r3, #1
c0d044be:	4a31      	ldr	r2, [pc, #196]	; (c0d04584 <u2f_transport_receive_fakeChannel+0x110>)
c0d044c0:	2800      	cmp	r0, #0
c0d044c2:	9301      	str	r3, [sp, #4]
c0d044c4:	d01c      	beq.n	c0d04500 <u2f_transport_receive_fakeChannel+0x8c>
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
        service->fakeChannelTransportPacketIndex = 0;
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
c0d044c6:	2324      	movs	r3, #36	; 0x24
c0d044c8:	5ce5      	ldrb	r5, [r4, r3]
c0d044ca:	4623      	mov	r3, r4
c0d044cc:	3324      	adds	r3, #36	; 0x24
c0d044ce:	42ae      	cmp	r6, r5
c0d044d0:	d152      	bne.n	c0d04578 <u2f_transport_receive_fakeChannel+0x104>
c0d044d2:	9200      	str	r2, [sp, #0]
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d044d4:	8b22      	ldrh	r2, [r4, #24]
        service->fakeChannelTransportPacketIndex++;
c0d044d6:	1c75      	adds	r5, r6, #1
c0d044d8:	701d      	strb	r5, [r3, #0]
    }
    else {
        if (buffer[4] != service->fakeChannelTransportPacketIndex) {
            goto error;
        }
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
c0d044da:	1a15      	subs	r5, r2, r0
c0d044dc:	9b02      	ldr	r3, [sp, #8]
c0d044de:	1f5b      	subs	r3, r3, #5
c0d044e0:	2605      	movs	r6, #5
c0d044e2:	42ab      	cmp	r3, r5
c0d044e4:	db00      	blt.n	c0d044e8 <u2f_transport_receive_fakeChannel+0x74>
c0d044e6:	4606      	mov	r6, r0
c0d044e8:	42ab      	cmp	r3, r5
c0d044ea:	9b02      	ldr	r3, [sp, #8]
c0d044ec:	db00      	blt.n	c0d044f0 <u2f_transport_receive_fakeChannel+0x7c>
c0d044ee:	4613      	mov	r3, r2
c0d044f0:	1b9b      	subs	r3, r3, r6
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
c0d044f2:	1818      	adds	r0, r3, r0
c0d044f4:	8460      	strh	r0, [r4, #34]	; 0x22
c0d044f6:	9a00      	ldr	r2, [sp, #0]
c0d044f8:	401a      	ands	r2, r3
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
c0d044fa:	8d20      	ldrh	r0, [r4, #40]	; 0x28
c0d044fc:	1d49      	adds	r1, r1, #5
c0d044fe:	e022      	b.n	c0d04546 <u2f_transport_receive_fakeChannel+0xd2>
c0d04500:	207c      	movs	r0, #124	; 0x7c
c0d04502:	43c0      	mvns	r0, r0
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
        // Some buggy implementations can send a WINK here, reply it gently
        if (buffer[4] == U2F_CMD_WINK) {
c0d04504:	1d40      	adds	r0, r0, #5
c0d04506:	b2c0      	uxtb	r0, r0
c0d04508:	2383      	movs	r3, #131	; 0x83
c0d0450a:	4286      	cmp	r6, r0
c0d0450c:	d103      	bne.n	c0d04516 <u2f_transport_receive_fakeChannel+0xa2>
            u2f_transport_send_wink(service);
c0d0450e:	4620      	mov	r0, r4
c0d04510:	f7ff ff98 	bl	c0d04444 <u2f_transport_send_wink>
c0d04514:	e02d      	b.n	c0d04572 <u2f_transport_receive_fakeChannel+0xfe>
    }
    if (memcmp(service->channel, buffer, 4) != 0) {
        goto error;
    }
    if (service->fakeChannelTransportOffset == 0) {        
        uint16_t commandLength = U2BE(buffer, 4+1) + U2F_COMMAND_HEADER_SIZE;
c0d04516:	7988      	ldrb	r0, [r1, #6]
c0d04518:	7949      	ldrb	r1, [r1, #5]
c0d0451a:	0209      	lsls	r1, r1, #8
c0d0451c:	4301      	orrs	r1, r0
c0d0451e:	1cc9      	adds	r1, r1, #3
        if (buffer[4] == U2F_CMD_WINK) {
            u2f_transport_send_wink(service);
            return true;
        }

        if (commandLength != service->transportLength) {
c0d04520:	4608      	mov	r0, r1
c0d04522:	4010      	ands	r0, r2
c0d04524:	429e      	cmp	r6, r3
c0d04526:	d127      	bne.n	c0d04578 <u2f_transport_receive_fakeChannel+0x104>
c0d04528:	8b23      	ldrh	r3, [r4, #24]
c0d0452a:	b289      	uxth	r1, r1
c0d0452c:	428b      	cmp	r3, r1
c0d0452e:	d123      	bne.n	c0d04578 <u2f_transport_receive_fakeChannel+0x104>
            goto error;
        }
        if (buffer[4] != U2F_CMD_MSG) {
            goto error;
        }
        service->fakeChannelTransportOffset = MIN(size - 4, service->transportLength);
c0d04530:	9902      	ldr	r1, [sp, #8]
c0d04532:	1f09      	subs	r1, r1, #4
c0d04534:	4281      	cmp	r1, r0
c0d04536:	db00      	blt.n	c0d0453a <u2f_transport_receive_fakeChannel+0xc6>
c0d04538:	4601      	mov	r1, r0
c0d0453a:	8461      	strh	r1, [r4, #34]	; 0x22
        service->fakeChannelTransportPacketIndex = 0;
c0d0453c:	2324      	movs	r3, #36	; 0x24
c0d0453e:	2000      	movs	r0, #0
c0d04540:	54e0      	strb	r0, [r4, r3]
        service->fakeChannelCrc = cx_crc16_update(0, buffer + 4, service->fakeChannelTransportOffset);
c0d04542:	400a      	ands	r2, r1
c0d04544:	4629      	mov	r1, r5
c0d04546:	f7ff fa7f 	bl	c0d03a48 <cx_crc16_update>
c0d0454a:	8520      	strh	r0, [r4, #40]	; 0x28
        uint16_t xfer_len = MIN(size - 5, service->transportLength - service->fakeChannelTransportOffset);
        service->fakeChannelTransportPacketIndex++;
        service->fakeChannelTransportOffset += xfer_len;
        service->fakeChannelCrc = cx_crc16_update(service->fakeChannelCrc, buffer + 5, xfer_len);   
    }
    if (service->fakeChannelTransportOffset >= service->transportLength) {
c0d0454c:	8b21      	ldrh	r1, [r4, #24]
c0d0454e:	8c62      	ldrh	r2, [r4, #34]	; 0x22
c0d04550:	428a      	cmp	r2, r1
c0d04552:	d30e      	bcc.n	c0d04572 <u2f_transport_receive_fakeChannel+0xfe>
        if (service->fakeChannelCrc != service->commandCrc) {
c0d04554:	8ce1      	ldrh	r1, [r4, #38]	; 0x26
c0d04556:	4288      	cmp	r0, r1
c0d04558:	d10e      	bne.n	c0d04578 <u2f_transport_receive_fakeChannel+0x104>
            goto error;
        }
        service->fakeChannelTransportState = U2F_FAKE_RECEIVED;
c0d0455a:	2006      	movs	r0, #6
c0d0455c:	7038      	strb	r0, [r7, #0]
        service->fakeChannelTransportOffset = 0;
c0d0455e:	2500      	movs	r5, #0
c0d04560:	8465      	strh	r5, [r4, #34]	; 0x22
        // reply immediately when the asynch response is not yet ready
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d04562:	202a      	movs	r0, #42	; 0x2a
c0d04564:	5c20      	ldrb	r0, [r4, r0]
c0d04566:	2801      	cmp	r0, #1
c0d04568:	d103      	bne.n	c0d04572 <u2f_transport_receive_fakeChannel+0xfe>
            u2f_transport_send_usb_user_presence_required(service);
c0d0456a:	4620      	mov	r0, r4
c0d0456c:	f7ff ff4c 	bl	c0d04408 <u2f_transport_send_usb_user_presence_required>
            // response sent
            service->fakeChannelTransportState = U2F_IDLE;
c0d04570:	703d      	strb	r5, [r7, #0]
c0d04572:	9801      	ldr	r0, [sp, #4]
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
    return false;    
}
c0d04574:	b003      	add	sp, #12
c0d04576:	bdf0      	pop	{r4, r5, r6, r7, pc}
            service->fakeChannelTransportState = U2F_IDLE;
        }
    }
    return true;
error:
    service->fakeChannelTransportState = U2F_INTERNAL_ERROR;
c0d04578:	2005      	movs	r0, #5
c0d0457a:	7038      	strb	r0, [r7, #0]
    // don't hesitate here, the user will have to exit/rerun the app otherwise.
    THROW(EXCEPTION_IO_RESET);
c0d0457c:	2010      	movs	r0, #16
c0d0457e:	f7fe fc50 	bl	c0d02e22 <os_longjmp>
c0d04582:	46c0      	nop			; (mov r8, r8)
c0d04584:	0000ffff 	.word	0x0000ffff

c0d04588 <u2f_transport_received>:
/** 
 * Function that process every message received on a media.
 * Performs message concatenation when message is splitted.
 */
void u2f_transport_received(u2f_service_t *service, uint8_t *buffer,
                          uint16_t size, u2f_transport_media_t media) {
c0d04588:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0458a:	b08b      	sub	sp, #44	; 0x2c
c0d0458c:	4604      	mov	r4, r0
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;
c0d0458e:	7223      	strb	r3, [r4, #8]

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d04590:	2020      	movs	r0, #32
c0d04592:	5c20      	ldrb	r0, [r4, r0]
c0d04594:	4627      	mov	r7, r4
c0d04596:	3720      	adds	r7, #32
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d04598:	2585      	movs	r5, #133	; 0x85
    uint16_t channelHeader = (media == U2F_MEDIA_USB ? 4 : 0);
    uint16_t xfer_len;
    service->media = media;

    // Handle a busy channel and avoid reentry
    if (service->transportState == U2F_SENDING_RESPONSE) {
c0d0459a:	2803      	cmp	r0, #3
c0d0459c:	d00e      	beq.n	c0d045bc <u2f_transport_received+0x34>
c0d0459e:	9109      	str	r1, [sp, #36]	; 0x24
c0d045a0:	920a      	str	r2, [sp, #40]	; 0x28
        u2f_transport_error(service, ERROR_CHANNEL_BUSY);
        goto error;
    }
    if (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_IDLE) {
c0d045a2:	212a      	movs	r1, #42	; 0x2a
c0d045a4:	5c61      	ldrb	r1, [r4, r1]
c0d045a6:	4626      	mov	r6, r4
c0d045a8:	362a      	adds	r6, #42	; 0x2a
c0d045aa:	2900      	cmp	r1, #0
c0d045ac:	d013      	beq.n	c0d045d6 <u2f_transport_received+0x4e>
        if (!u2f_transport_receive_fakeChannel(service, buffer, size)) {
c0d045ae:	4620      	mov	r0, r4
c0d045b0:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d045b2:	9a0a      	ldr	r2, [sp, #40]	; 0x28
c0d045b4:	f7ff ff5e 	bl	c0d04474 <u2f_transport_receive_fakeChannel>
c0d045b8:	2800      	cmp	r0, #0
c0d045ba:	d173      	bne.n	c0d046a4 <u2f_transport_received+0x11c>
c0d045bc:	48df      	ldr	r0, [pc, #892]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d045be:	2106      	movs	r1, #6
c0d045c0:	7201      	strb	r1, [r0, #8]
c0d045c2:	2104      	movs	r1, #4
c0d045c4:	7039      	strb	r1, [r7, #0]
c0d045c6:	2100      	movs	r1, #0
c0d045c8:	76a1      	strb	r1, [r4, #26]
c0d045ca:	3008      	adds	r0, #8
c0d045cc:	61e0      	str	r0, [r4, #28]
c0d045ce:	82e1      	strh	r1, [r4, #22]
c0d045d0:	2001      	movs	r0, #1
c0d045d2:	8320      	strh	r0, [r4, #24]
c0d045d4:	e05f      	b.n	c0d04696 <u2f_transport_received+0x10e>
        }
        return;
    }
    
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
c0d045d6:	2804      	cmp	r0, #4
c0d045d8:	d109      	bne.n	c0d045ee <u2f_transport_received+0x66>
c0d045da:	2000      	movs	r0, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d045dc:	82e0      	strh	r0, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d045de:	76a0      	strb	r0, [r4, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d045e0:	212b      	movs	r1, #43	; 0x2b
c0d045e2:	5460      	strb	r0, [r4, r1]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d045e4:	7030      	strb	r0, [r6, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d045e6:	80b8      	strh	r0, [r7, #4]
c0d045e8:	6038      	str	r0, [r7, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d045ea:	68e0      	ldr	r0, [r4, #12]
c0d045ec:	61e0      	str	r0, [r4, #28]
    // SENDING_ERROR is accepted, and triggers a reset => means the host hasn't consumed the error.
    if (service->transportState == U2F_SENDING_ERROR) {
        u2f_transport_reset(service);
    }

    if (size < (1 + channelHeader)) {
c0d045ee:	2104      	movs	r1, #4
c0d045f0:	2000      	movs	r0, #0
c0d045f2:	9308      	str	r3, [sp, #32]
c0d045f4:	2b01      	cmp	r3, #1
c0d045f6:	d000      	beq.n	c0d045fa <u2f_transport_received+0x72>
c0d045f8:	4601      	mov	r1, r0
c0d045fa:	2301      	movs	r3, #1
c0d045fc:	460a      	mov	r2, r1
c0d045fe:	431a      	orrs	r2, r3
c0d04600:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d04602:	4290      	cmp	r0, r2
c0d04604:	d33d      	bcc.n	c0d04682 <u2f_transport_received+0xfa>
c0d04606:	9204      	str	r2, [sp, #16]
        // Message to short, abort
        u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
        goto error;
    }
    if (media == U2F_MEDIA_USB) {
c0d04608:	9808      	ldr	r0, [sp, #32]
c0d0460a:	2801      	cmp	r0, #1
c0d0460c:	9105      	str	r1, [sp, #20]
c0d0460e:	9506      	str	r5, [sp, #24]
c0d04610:	9307      	str	r3, [sp, #28]
c0d04612:	d107      	bne.n	c0d04624 <u2f_transport_received+0x9c>
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
c0d04614:	1d20      	adds	r0, r4, #4
c0d04616:	2204      	movs	r2, #4
c0d04618:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d0461a:	f7fe fbc7 	bl	c0d02dac <os_memmove>
c0d0461e:	9905      	ldr	r1, [sp, #20]
c0d04620:	9b07      	ldr	r3, [sp, #28]
c0d04622:	9d06      	ldr	r5, [sp, #24]
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d04624:	8ae0      	ldrh	r0, [r4, #22]
c0d04626:	4ac6      	ldr	r2, [pc, #792]	; (c0d04940 <u2f_transport_received+0x3b8>)
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
c0d04628:	2800      	cmp	r0, #0
c0d0462a:	d00f      	beq.n	c0d0464c <u2f_transport_received+0xc4>
c0d0462c:	9808      	ldr	r0, [sp, #32]
c0d0462e:	2801      	cmp	r0, #1
c0d04630:	d122      	bne.n	c0d04678 <u2f_transport_received+0xf0>
c0d04632:	4620      	mov	r0, r4
c0d04634:	3012      	adds	r0, #18
c0d04636:	1d21      	adds	r1, r4, #4
c0d04638:	4615      	mov	r5, r2
c0d0463a:	2204      	movs	r2, #4
c0d0463c:	f7fe fbda 	bl	c0d02df4 <os_memcmp>
c0d04640:	9905      	ldr	r1, [sp, #20]
c0d04642:	462a      	mov	r2, r5
c0d04644:	9b07      	ldr	r3, [sp, #28]
c0d04646:	9d06      	ldr	r5, [sp, #24]
        // hold the current channel value to reply to, for example, INIT commands within flow of segments.
        os_memmove(service->channel, buffer, 4);
    }

    // no previous chunk processed for the current message
    if (service->transportOffset == 0
c0d04648:	2800      	cmp	r0, #0
c0d0464a:	d015      	beq.n	c0d04678 <u2f_transport_received+0xf0>
        // on USB we could get an INIT within a flow of segments.
        || (media == U2F_MEDIA_USB && os_memcmp(service->transportChannel, service->channel, 4) != 0) ) {
        if (size < (channelHeader + 3)) {
c0d0464c:	2603      	movs	r6, #3
c0d0464e:	4608      	mov	r0, r1
c0d04650:	9603      	str	r6, [sp, #12]
c0d04652:	4330      	orrs	r0, r6
c0d04654:	460e      	mov	r6, r1
c0d04656:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d04658:	4281      	cmp	r1, r0
c0d0465a:	d312      	bcc.n	c0d04682 <u2f_transport_received+0xfa>
c0d0465c:	9909      	ldr	r1, [sp, #36]	; 0x24
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        // check this is a command, cannot accept continuation without previous command
        if ((buffer[channelHeader+0]&U2F_MASK_COMMAND) == 0) {
c0d0465e:	1988      	adds	r0, r1, r6
c0d04660:	9002      	str	r0, [sp, #8]
c0d04662:	5788      	ldrsb	r0, [r1, r6]
c0d04664:	460e      	mov	r6, r1
c0d04666:	4629      	mov	r1, r5
c0d04668:	317a      	adds	r1, #122	; 0x7a
c0d0466a:	b249      	sxtb	r1, r1
c0d0466c:	4288      	cmp	r0, r1
c0d0466e:	dd37      	ble.n	c0d046e0 <u2f_transport_received+0x158>
c0d04670:	48b2      	ldr	r0, [pc, #712]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04672:	2104      	movs	r1, #4
c0d04674:	7201      	strb	r1, [r0, #8]
c0d04676:	e007      	b.n	c0d04688 <u2f_transport_received+0x100>
c0d04678:	2002      	movs	r0, #2
            service->transportPacketIndex = 0;
            os_memmove(service->transportChannel, service->channel, 4);
        }
    } else {
        // Continuation
        if (size < (channelHeader + 2)) {
c0d0467a:	4308      	orrs	r0, r1
c0d0467c:	990a      	ldr	r1, [sp, #40]	; 0x28
c0d0467e:	4281      	cmp	r1, r0
c0d04680:	d212      	bcs.n	c0d046a8 <u2f_transport_received+0x120>
c0d04682:	48ae      	ldr	r0, [pc, #696]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04684:	7205      	strb	r5, [r0, #8]
c0d04686:	2104      	movs	r1, #4
c0d04688:	7039      	strb	r1, [r7, #0]
c0d0468a:	2100      	movs	r1, #0
c0d0468c:	76a1      	strb	r1, [r4, #26]
c0d0468e:	3008      	adds	r0, #8
c0d04690:	61e0      	str	r0, [r4, #28]
c0d04692:	82e1      	strh	r1, [r4, #22]
c0d04694:	8323      	strh	r3, [r4, #24]
c0d04696:	353a      	adds	r5, #58	; 0x3a
c0d04698:	2040      	movs	r0, #64	; 0x40
c0d0469a:	5425      	strb	r5, [r4, r0]
c0d0469c:	7a21      	ldrb	r1, [r4, #8]
c0d0469e:	4620      	mov	r0, r4
c0d046a0:	f7ff fe0a 	bl	c0d042b8 <u2f_transport_sent>
        service->seqTimeout = 0;
        service->transportState = U2F_HANDLE_SEGMENTED;
    }
error:
    return;
}
c0d046a4:	b00b      	add	sp, #44	; 0x2c
c0d046a6:	bdf0      	pop	{r4, r5, r6, r7, pc}
        if (size < (channelHeader + 2)) {
            // Message to short, abort
            u2f_transport_error(service, ERROR_PROP_MESSAGE_TOO_SHORT);
            goto error;
        }
        if (media != service->transportMedia) {
c0d046a8:	2021      	movs	r0, #33	; 0x21
c0d046aa:	5c20      	ldrb	r0, [r4, r0]
c0d046ac:	9908      	ldr	r1, [sp, #32]
c0d046ae:	4288      	cmp	r0, r1
c0d046b0:	d14b      	bne.n	c0d0474a <u2f_transport_received+0x1c2>
            // Mixed medias
            u2f_transport_error(service, ERROR_PROP_MEDIA_MIXED);
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
c0d046b2:	7838      	ldrb	r0, [r7, #0]
c0d046b4:	2801      	cmp	r0, #1
c0d046b6:	d154      	bne.n	c0d04762 <u2f_transport_received+0x1da>
c0d046b8:	9203      	str	r2, [sp, #12]
            } else {
                u2f_transport_error(service, ERROR_INVALID_SEQ);
                goto error;
            }
        }
        if (media == U2F_MEDIA_USB) {
c0d046ba:	9808      	ldr	r0, [sp, #32]
c0d046bc:	2801      	cmp	r0, #1
c0d046be:	d000      	beq.n	c0d046c2 <u2f_transport_received+0x13a>
c0d046c0:	e083      	b.n	c0d047ca <u2f_transport_received+0x242>
            // Check the channel
            if (os_memcmp(buffer, service->channel, 4) != 0) {
c0d046c2:	1d21      	adds	r1, r4, #4
c0d046c4:	2504      	movs	r5, #4
c0d046c6:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d046c8:	462a      	mov	r2, r5
c0d046ca:	461e      	mov	r6, r3
c0d046cc:	f7fe fb92 	bl	c0d02df4 <os_memcmp>
c0d046d0:	4633      	mov	r3, r6
c0d046d2:	2800      	cmp	r0, #0
c0d046d4:	d079      	beq.n	c0d047ca <u2f_transport_received+0x242>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d046d6:	4899      	ldr	r0, [pc, #612]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d046d8:	2106      	movs	r1, #6
c0d046da:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d046dc:	703d      	strb	r5, [r7, #0]
c0d046de:	e0f4      	b.n	c0d048ca <u2f_transport_received+0x342>
c0d046e0:	9b08      	ldr	r3, [sp, #32]
            goto error;
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
c0d046e2:	2b01      	cmp	r3, #1
c0d046e4:	d116      	bne.n	c0d04714 <u2f_transport_received+0x18c>
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d046e6:	7838      	ldrb	r0, [r7, #0]
c0d046e8:	2801      	cmp	r0, #1
c0d046ea:	d11f      	bne.n	c0d0472c <u2f_transport_received+0x1a4>
                (os_memcmp(service->channel, service->transportChannel, 4) !=
c0d046ec:	1d20      	adds	r0, r4, #4
c0d046ee:	4621      	mov	r1, r4
c0d046f0:	3112      	adds	r1, #18
c0d046f2:	4615      	mov	r5, r2
c0d046f4:	2204      	movs	r2, #4
c0d046f6:	9001      	str	r0, [sp, #4]
c0d046f8:	f7fe fb7c 	bl	c0d02df4 <os_memcmp>
c0d046fc:	462a      	mov	r2, r5
c0d046fe:	9b08      	ldr	r3, [sp, #32]
c0d04700:	9d06      	ldr	r5, [sp, #24]
                 0) &&
c0d04702:	2800      	cmp	r0, #0
c0d04704:	d006      	beq.n	c0d04714 <u2f_transport_received+0x18c>
                (buffer[channelHeader] != U2F_CMD_INIT)) {
c0d04706:	9802      	ldr	r0, [sp, #8]
c0d04708:	7800      	ldrb	r0, [r0, #0]
c0d0470a:	1c69      	adds	r1, r5, #1
c0d0470c:	b2c9      	uxtb	r1, r1
        }

        // If waiting for a continuation on a different channel, reply BUSY
        // immediately
        if (media == U2F_MEDIA_USB) {
            if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d0470e:	4288      	cmp	r0, r1
c0d04710:	d000      	beq.n	c0d04714 <u2f_transport_received+0x18c>
c0d04712:	e0f4      	b.n	c0d048fe <u2f_transport_received+0x376>
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d04714:	7838      	ldrb	r0, [r7, #0]
c0d04716:	2801      	cmp	r0, #1
c0d04718:	d108      	bne.n	c0d0472c <u2f_transport_received+0x1a4>
            !((media == U2F_MEDIA_USB) &&
c0d0471a:	2b01      	cmp	r3, #1
c0d0471c:	d000      	beq.n	c0d04720 <u2f_transport_received+0x198>
c0d0471e:	e080      	b.n	c0d04822 <u2f_transport_received+0x29a>
              (buffer[channelHeader] == U2F_CMD_INIT))) {
c0d04720:	9802      	ldr	r0, [sp, #8]
c0d04722:	7800      	ldrb	r0, [r0, #0]
c0d04724:	1c69      	adds	r1, r5, #1
c0d04726:	b2c9      	uxtb	r1, r1
                goto error;
            }
        }
        // If a command was already sent, and we are not processing a INIT
        // command, abort
        if ((service->transportState == U2F_HANDLE_SEGMENTED) &&
c0d04728:	4288      	cmp	r0, r1
c0d0472a:	d17a      	bne.n	c0d04822 <u2f_transport_received+0x29a>
c0d0472c:	9904      	ldr	r1, [sp, #16]
            // Unexpected continuation at this stage, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        // Check the length
        uint16_t commandLength = U2BE(buffer, channelHeader + 1);
c0d0472e:	1870      	adds	r0, r6, r1
c0d04730:	7840      	ldrb	r0, [r0, #1]
c0d04732:	5c71      	ldrb	r1, [r6, r1]
c0d04734:	0209      	lsls	r1, r1, #8
c0d04736:	4301      	orrs	r1, r0
        if (commandLength > (service->transportReceiveBufferLength - 3)) {
c0d04738:	8a20      	ldrh	r0, [r4, #16]
c0d0473a:	1ec0      	subs	r0, r0, #3
c0d0473c:	4281      	cmp	r1, r0
c0d0473e:	dd1e      	ble.n	c0d0477e <u2f_transport_received+0x1f6>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04740:	487e      	ldr	r0, [pc, #504]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04742:	9903      	ldr	r1, [sp, #12]
c0d04744:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d04746:	2104      	movs	r1, #4
c0d04748:	e06e      	b.n	c0d04828 <u2f_transport_received+0x2a0>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0474a:	4628      	mov	r0, r5
c0d0474c:	3008      	adds	r0, #8
c0d0474e:	497b      	ldr	r1, [pc, #492]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04750:	7208      	strb	r0, [r1, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d04752:	2004      	movs	r0, #4
c0d04754:	7038      	strb	r0, [r7, #0]
c0d04756:	2000      	movs	r0, #0
    service->transportPacketIndex = 0;
c0d04758:	76a0      	strb	r0, [r4, #26]
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d0475a:	3108      	adds	r1, #8

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
    service->transportPacketIndex = 0;
    service->transportBuffer = G_io_usb_ep_buffer + 8;
c0d0475c:	61e1      	str	r1, [r4, #28]
    service->transportOffset = 0;
c0d0475e:	82e0      	strh	r0, [r4, #22]
c0d04760:	e798      	b.n	c0d04694 <u2f_transport_received+0x10c>
            goto error;
        }
        if (service->transportState != U2F_HANDLE_SEGMENTED) {
            // Unexpected continuation at this stage, abort
            // TODO : review the behavior is HID only
            if (media == U2F_MEDIA_USB) {
c0d04762:	9808      	ldr	r0, [sp, #32]
c0d04764:	2801      	cmp	r0, #1
c0d04766:	d183      	bne.n	c0d04670 <u2f_transport_received+0xe8>
c0d04768:	2000      	movs	r0, #0
#warning TODO take into account the INIT during SEGMENTED message correctly (avoid erasing the first part of the apdu buffer when doing so)

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
c0d0476a:	82e0      	strh	r0, [r4, #22]
    service->transportMedia = 0;
    service->transportPacketIndex = 0;
c0d0476c:	76a0      	strb	r0, [r4, #26]
    service->fakeChannelTransportState = U2F_IDLE;
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
c0d0476e:	212b      	movs	r1, #43	; 0x2b
c0d04770:	5460      	strb	r0, [r4, r1]
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
c0d04772:	7030      	strb	r0, [r6, #0]

// init
void u2f_transport_reset(u2f_service_t* service) {
    service->transportState = U2F_IDLE;
    service->transportOffset = 0;
    service->transportMedia = 0;
c0d04774:	80b8      	strh	r0, [r7, #4]
c0d04776:	6038      	str	r0, [r7, #0]
    service->fakeChannelTransportOffset = 0;
    service->fakeChannelTransportPacketIndex = 0;    
    service->sending = false;
    service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_IDLE;
    // reset the receive buffer to allow for a new message to be received again (in case transmission of a CODE buffer the previous reply)
    service->transportBuffer = service->transportReceiveBuffer;
c0d04778:	68e0      	ldr	r0, [r4, #12]
c0d0477a:	61e0      	str	r0, [r4, #28]
c0d0477c:	e792      	b.n	c0d046a4 <u2f_transport_received+0x11c>
            // Overflow in message size, abort
            u2f_transport_error(service, ERROR_INVALID_LEN);
            goto error;
        }
        // Check if the command is supported
        switch (buffer[channelHeader]) {
c0d0477e:	9802      	ldr	r0, [sp, #8]
c0d04780:	7800      	ldrb	r0, [r0, #0]
c0d04782:	2881      	cmp	r0, #129	; 0x81
c0d04784:	9b07      	ldr	r3, [sp, #28]
c0d04786:	d004      	beq.n	c0d04792 <u2f_transport_received+0x20a>
c0d04788:	2886      	cmp	r0, #134	; 0x86
c0d0478a:	d059      	beq.n	c0d04840 <u2f_transport_received+0x2b8>
c0d0478c:	2883      	cmp	r0, #131	; 0x83
c0d0478e:	d000      	beq.n	c0d04792 <u2f_transport_received+0x20a>
c0d04790:	e0ac      	b.n	c0d048ec <u2f_transport_received+0x364>
c0d04792:	9109      	str	r1, [sp, #36]	; 0x24
c0d04794:	9203      	str	r2, [sp, #12]
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
c0d04796:	9808      	ldr	r0, [sp, #32]
c0d04798:	2801      	cmp	r0, #1
c0d0479a:	d15f      	bne.n	c0d0485c <u2f_transport_received+0x2d4>
                if (u2f_is_channel_broadcast(service->channel) ||
c0d0479c:	1d26      	adds	r6, r4, #4
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d0479e:	4969      	ldr	r1, [pc, #420]	; (c0d04944 <u2f_transport_received+0x3bc>)
c0d047a0:	4479      	add	r1, pc
c0d047a2:	2504      	movs	r5, #4
c0d047a4:	4630      	mov	r0, r6
c0d047a6:	462a      	mov	r2, r5
c0d047a8:	f7fe fb24 	bl	c0d02df4 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d047ac:	2800      	cmp	r0, #0
c0d047ae:	d007      	beq.n	c0d047c0 <u2f_transport_received+0x238>
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d047b0:	4965      	ldr	r1, [pc, #404]	; (c0d04948 <u2f_transport_received+0x3c0>)
c0d047b2:	4479      	add	r1, pc
c0d047b4:	2204      	movs	r2, #4
c0d047b6:	4630      	mov	r0, r6
c0d047b8:	f7fe fb1c 	bl	c0d02df4 <os_memcmp>
        // Check if the command is supported
        switch (buffer[channelHeader]) {
        case U2F_CMD_PING:
        case U2F_CMD_MSG:
            if (media == U2F_MEDIA_USB) {
                if (u2f_is_channel_broadcast(service->channel) ||
c0d047bc:	2800      	cmp	r0, #0
c0d047be:	d14d      	bne.n	c0d0485c <u2f_transport_received+0x2d4>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d047c0:	485e      	ldr	r0, [pc, #376]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d047c2:	210b      	movs	r1, #11
c0d047c4:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d047c6:	703d      	strb	r5, [r7, #0]
c0d047c8:	e0b0      	b.n	c0d0492c <u2f_transport_received+0x3a4>
c0d047ca:	9805      	ldr	r0, [sp, #20]
c0d047cc:	9a09      	ldr	r2, [sp, #36]	; 0x24
                u2f_transport_error(service, ERROR_CHANNEL_BUSY);
                goto error;
            }
        }
        // also discriminate invalid command sent instead of a continuation
        if (buffer[channelHeader] != service->transportPacketIndex) {
c0d047ce:	1811      	adds	r1, r2, r0
c0d047d0:	5c10      	ldrb	r0, [r2, r0]
c0d047d2:	7ea2      	ldrb	r2, [r4, #26]
c0d047d4:	4290      	cmp	r0, r2
c0d047d6:	d12f      	bne.n	c0d04838 <u2f_transport_received+0x2b0>
            // Bad continuation packet, abort
            u2f_transport_error(service, ERROR_INVALID_SEQ);
            goto error;
        }
        xfer_len = MIN(size - (channelHeader + 1), service->transportLength - service->transportOffset);
c0d047d8:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d047da:	9a04      	ldr	r2, [sp, #16]
c0d047dc:	1a85      	subs	r5, r0, r2
c0d047de:	8ae0      	ldrh	r0, [r4, #22]
c0d047e0:	8b22      	ldrh	r2, [r4, #24]
c0d047e2:	1a12      	subs	r2, r2, r0
c0d047e4:	4295      	cmp	r5, r2
c0d047e6:	db00      	blt.n	c0d047ea <u2f_transport_received+0x262>
c0d047e8:	4615      	mov	r5, r2
c0d047ea:	9e03      	ldr	r6, [sp, #12]
        os_memmove(service->transportBuffer + service->transportOffset, buffer + channelHeader + 1, xfer_len);
c0d047ec:	402e      	ands	r6, r5
c0d047ee:	69e2      	ldr	r2, [r4, #28]
c0d047f0:	1810      	adds	r0, r2, r0
c0d047f2:	1c49      	adds	r1, r1, #1
c0d047f4:	4632      	mov	r2, r6
c0d047f6:	f7fe fad9 	bl	c0d02dac <os_memmove>
        if (media == U2F_MEDIA_USB) {
c0d047fa:	9808      	ldr	r0, [sp, #32]
c0d047fc:	2801      	cmp	r0, #1
c0d047fe:	d107      	bne.n	c0d04810 <u2f_transport_received+0x288>
            service->commandCrc = cx_crc16_update(service->commandCrc, service->transportBuffer + service->transportOffset, xfer_len);
c0d04800:	8ae0      	ldrh	r0, [r4, #22]
c0d04802:	69e1      	ldr	r1, [r4, #28]
c0d04804:	1809      	adds	r1, r1, r0
c0d04806:	8ce0      	ldrh	r0, [r4, #38]	; 0x26
c0d04808:	4632      	mov	r2, r6
c0d0480a:	f7ff f91d 	bl	c0d03a48 <cx_crc16_update>
c0d0480e:	84e0      	strh	r0, [r4, #38]	; 0x26
        }        
        service->transportOffset += xfer_len;
c0d04810:	8ae0      	ldrh	r0, [r4, #22]
c0d04812:	1940      	adds	r0, r0, r5
c0d04814:	82e0      	strh	r0, [r4, #22]
        service->transportPacketIndex++;
c0d04816:	7ea0      	ldrb	r0, [r4, #26]
c0d04818:	1c40      	adds	r0, r0, #1
c0d0481a:	76a0      	strb	r0, [r4, #26]
c0d0481c:	9b07      	ldr	r3, [sp, #28]
c0d0481e:	9d08      	ldr	r5, [sp, #32]
c0d04820:	e045      	b.n	c0d048ae <u2f_transport_received+0x326>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04822:	4846      	ldr	r0, [pc, #280]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04824:	2104      	movs	r1, #4
c0d04826:	7201      	strb	r1, [r0, #8]
c0d04828:	7039      	strb	r1, [r7, #0]
c0d0482a:	2100      	movs	r1, #0
c0d0482c:	76a1      	strb	r1, [r4, #26]
c0d0482e:	3008      	adds	r0, #8
c0d04830:	61e0      	str	r0, [r4, #28]
c0d04832:	82e1      	strh	r1, [r4, #22]
c0d04834:	9807      	ldr	r0, [sp, #28]
c0d04836:	e6cc      	b.n	c0d045d2 <u2f_transport_received+0x4a>
c0d04838:	4840      	ldr	r0, [pc, #256]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d0483a:	2104      	movs	r1, #4
c0d0483c:	7201      	strb	r1, [r0, #8]
c0d0483e:	e043      	b.n	c0d048c8 <u2f_transport_received+0x340>
                }
            }
            // no channel for BLE
            break;
        case U2F_CMD_INIT:
            if (media != U2F_MEDIA_USB) {
c0d04840:	9808      	ldr	r0, [sp, #32]
c0d04842:	2801      	cmp	r0, #1
c0d04844:	d152      	bne.n	c0d048ec <u2f_transport_received+0x364>
c0d04846:	9109      	str	r1, [sp, #36]	; 0x24
c0d04848:	9203      	str	r2, [sp, #12]
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d0484a:	1d20      	adds	r0, r4, #4
bool u2f_is_channel_broadcast(uint8_t *channel) {
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
}

bool u2f_is_channel_forbidden(uint8_t *channel) {
    return (os_memcmp(channel, FORBIDDEN_CHANNEL, 4) == 0);
c0d0484c:	493f      	ldr	r1, [pc, #252]	; (c0d0494c <u2f_transport_received+0x3c4>)
c0d0484e:	4479      	add	r1, pc
c0d04850:	2604      	movs	r6, #4
c0d04852:	4632      	mov	r2, r6
c0d04854:	f7fe face 	bl	c0d02df4 <os_memcmp>
                // Unknown command, abort
                u2f_transport_error(service, ERROR_INVALID_CMD);
                goto error;
            }

            if (u2f_is_channel_forbidden(service->channel)) {
c0d04858:	2800      	cmp	r0, #0
c0d0485a:	d063      	beq.n	c0d04924 <u2f_transport_received+0x39c>
        }

        // Ok, initialize the buffer
        //if (buffer[channelHeader] != U2F_CMD_INIT) 
        {
            xfer_len = MIN(size - (channelHeader), U2F_COMMAND_HEADER_SIZE+commandLength);
c0d0485c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0485e:	9905      	ldr	r1, [sp, #20]
c0d04860:	1a46      	subs	r6, r0, r1
c0d04862:	9809      	ldr	r0, [sp, #36]	; 0x24
c0d04864:	1cc0      	adds	r0, r0, #3
c0d04866:	4286      	cmp	r6, r0
c0d04868:	9d03      	ldr	r5, [sp, #12]
c0d0486a:	db00      	blt.n	c0d0486e <u2f_transport_received+0x2e6>
c0d0486c:	4606      	mov	r6, r0
c0d0486e:	900a      	str	r0, [sp, #40]	; 0x28
            os_memmove(service->transportBuffer, buffer + channelHeader, xfer_len);
c0d04870:	4035      	ands	r5, r6
c0d04872:	69e0      	ldr	r0, [r4, #28]
c0d04874:	9902      	ldr	r1, [sp, #8]
c0d04876:	462a      	mov	r2, r5
c0d04878:	f7fe fa98 	bl	c0d02dac <os_memmove>
c0d0487c:	9b08      	ldr	r3, [sp, #32]
            if (media == U2F_MEDIA_USB) {
c0d0487e:	2b01      	cmp	r3, #1
c0d04880:	d106      	bne.n	c0d04890 <u2f_transport_received+0x308>
                service->commandCrc = cx_crc16_update(0, service->transportBuffer, xfer_len);
c0d04882:	69e1      	ldr	r1, [r4, #28]
c0d04884:	2000      	movs	r0, #0
c0d04886:	462a      	mov	r2, r5
c0d04888:	f7ff f8de 	bl	c0d03a48 <cx_crc16_update>
c0d0488c:	9b08      	ldr	r3, [sp, #32]
c0d0488e:	84e0      	strh	r0, [r4, #38]	; 0x26
            }
            service->transportOffset = xfer_len;
c0d04890:	82e6      	strh	r6, [r4, #22]
            service->transportLength = U2F_COMMAND_HEADER_SIZE+commandLength;
c0d04892:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d04894:	8320      	strh	r0, [r4, #24]
            service->transportMedia = media;
c0d04896:	2021      	movs	r0, #33	; 0x21
c0d04898:	5423      	strb	r3, [r4, r0]
            // initialize the response
            service->transportPacketIndex = 0;
c0d0489a:	2000      	movs	r0, #0
c0d0489c:	76a0      	strb	r0, [r4, #26]
            os_memmove(service->transportChannel, service->channel, 4);
c0d0489e:	4620      	mov	r0, r4
c0d048a0:	3012      	adds	r0, #18
c0d048a2:	1d21      	adds	r1, r4, #4
c0d048a4:	2204      	movs	r2, #4
c0d048a6:	461d      	mov	r5, r3
c0d048a8:	f7fe fa80 	bl	c0d02dac <os_memmove>
c0d048ac:	9b07      	ldr	r3, [sp, #28]
c0d048ae:	8ae0      	ldrh	r0, [r4, #22]
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d048b0:	2d01      	cmp	r5, #1
c0d048b2:	d101      	bne.n	c0d048b8 <u2f_transport_received+0x330>
c0d048b4:	8b21      	ldrh	r1, [r4, #24]
c0d048b6:	e013      	b.n	c0d048e0 <u2f_transport_received+0x358>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
c0d048b8:	8b21      	ldrh	r1, [r4, #24]
c0d048ba:	1cca      	adds	r2, r1, #3
        }        
        service->transportOffset += xfer_len;
        service->transportPacketIndex++;
    }
    // See if we can process the command
    if ((media != U2F_MEDIA_USB) &&
c0d048bc:	4290      	cmp	r0, r2
c0d048be:	d90f      	bls.n	c0d048e0 <u2f_transport_received+0x358>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d048c0:	481e      	ldr	r0, [pc, #120]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d048c2:	2103      	movs	r1, #3
c0d048c4:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d048c6:	2104      	movs	r1, #4
c0d048c8:	7039      	strb	r1, [r7, #0]
c0d048ca:	2100      	movs	r1, #0
c0d048cc:	76a1      	strb	r1, [r4, #26]
c0d048ce:	3008      	adds	r0, #8
c0d048d0:	61e0      	str	r0, [r4, #28]
c0d048d2:	82e1      	strh	r1, [r4, #22]
c0d048d4:	8323      	strh	r3, [r4, #24]
c0d048d6:	9906      	ldr	r1, [sp, #24]
c0d048d8:	313a      	adds	r1, #58	; 0x3a
c0d048da:	2040      	movs	r0, #64	; 0x40
c0d048dc:	5421      	strb	r1, [r4, r0]
c0d048de:	e6dd      	b.n	c0d0469c <u2f_transport_received+0x114>
        (service->transportOffset >
         (service->transportLength + U2F_COMMAND_HEADER_SIZE))) {
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
c0d048e0:	4288      	cmp	r0, r1
c0d048e2:	d206      	bcs.n	c0d048f2 <u2f_transport_received+0x36a>
c0d048e4:	2000      	movs	r0, #0
        service->transportState = U2F_PROCESSING_COMMAND;
        // internal notification of a complete message received
        u2f_message_complete(service);
    } else {
        // new segment received, reset the timeout for the current piece
        service->seqTimeout = 0;
c0d048e6:	6360      	str	r0, [r4, #52]	; 0x34
        service->transportState = U2F_HANDLE_SEGMENTED;
c0d048e8:	703b      	strb	r3, [r7, #0]
c0d048ea:	e6db      	b.n	c0d046a4 <u2f_transport_received+0x11c>
c0d048ec:	4813      	ldr	r0, [pc, #76]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d048ee:	7203      	strb	r3, [r0, #8]
c0d048f0:	e6c9      	b.n	c0d04686 <u2f_transport_received+0xfe>
        // Overflow, abort
        u2f_transport_error(service, ERROR_INVALID_LEN);
        goto error;
    } else if (service->transportOffset >= service->transportLength) {
        // switch before the handler gets the opportunity to change it again
        service->transportState = U2F_PROCESSING_COMMAND;
c0d048f2:	2002      	movs	r0, #2
c0d048f4:	7038      	strb	r0, [r7, #0]
        // internal notification of a complete message received
        u2f_message_complete(service);
c0d048f6:	4620      	mov	r0, r4
c0d048f8:	f7ff fc98 	bl	c0d0422c <u2f_message_complete>
c0d048fc:	e6d2      	b.n	c0d046a4 <u2f_transport_received+0x11c>
                // special error case, we reply but don't change the current state of the transport (ongoing message for example)
                //u2f_transport_error_no_reset(service, ERROR_CHANNEL_BUSY);
                uint16_t offset = 0;
                // Fragment
                if (media == U2F_MEDIA_USB) {
                    os_memmove(G_io_usb_ep_buffer, service->channel, 4);
c0d048fe:	4c0f      	ldr	r4, [pc, #60]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04900:	2204      	movs	r2, #4
c0d04902:	4620      	mov	r0, r4
c0d04904:	9901      	ldr	r1, [sp, #4]
c0d04906:	f7fe fa51 	bl	c0d02dac <os_memmove>
                    offset += 4;
                }
                G_io_usb_ep_buffer[offset++] = U2F_STATUS_ERROR;
c0d0490a:	353a      	adds	r5, #58	; 0x3a
c0d0490c:	7125      	strb	r5, [r4, #4]
                G_io_usb_ep_buffer[offset++] = 0;
c0d0490e:	2000      	movs	r0, #0
c0d04910:	7160      	strb	r0, [r4, #5]
c0d04912:	9a07      	ldr	r2, [sp, #28]
                G_io_usb_ep_buffer[offset++] = 1;
c0d04914:	71a2      	strb	r2, [r4, #6]
c0d04916:	2006      	movs	r0, #6
                G_io_usb_ep_buffer[offset++] = ERROR_CHANNEL_BUSY;
c0d04918:	71e0      	strb	r0, [r4, #7]
                u2f_io_send(G_io_usb_ep_buffer, offset, media);
c0d0491a:	2108      	movs	r1, #8
c0d0491c:	4620      	mov	r0, r4
c0d0491e:	f7ff fca3 	bl	c0d04268 <u2f_io_send>
c0d04922:	e6bf      	b.n	c0d046a4 <u2f_transport_received+0x11c>
/**
 * Reply an error at the U2F transport level (take into account the FIDO U2F framing)
 */
static void u2f_transport_error(u2f_service_t *service, char errorCode) {
    //u2f_transport_reset(service); // warning reset first to allow for U2F_io sent call to u2f_transport_sent internally on eventless platforms
    G_io_usb_ep_buffer[8] = errorCode;
c0d04924:	4805      	ldr	r0, [pc, #20]	; (c0d0493c <u2f_transport_received+0x3b4>)
c0d04926:	210b      	movs	r1, #11
c0d04928:	7201      	strb	r1, [r0, #8]

    // ensure the state is set to error sending to allow for special treatment in case reply is not read by the receiver
    service->transportState = U2F_SENDING_ERROR;
c0d0492a:	703e      	strb	r6, [r7, #0]
c0d0492c:	2100      	movs	r1, #0
c0d0492e:	76a1      	strb	r1, [r4, #26]
c0d04930:	3008      	adds	r0, #8
c0d04932:	61e0      	str	r0, [r4, #28]
c0d04934:	82e1      	strh	r1, [r4, #22]
c0d04936:	9807      	ldr	r0, [sp, #28]
c0d04938:	8320      	strh	r0, [r4, #24]
c0d0493a:	e7cc      	b.n	c0d048d6 <u2f_transport_received+0x34e>
c0d0493c:	20002174 	.word	0x20002174
c0d04940:	0000ffff 	.word	0x0000ffff
c0d04944:	000029d9 	.word	0x000029d9
c0d04948:	000029cb 	.word	0x000029cb
c0d0494c:	0000292f 	.word	0x0000292f

c0d04950 <u2f_is_channel_broadcast>:
    }
error:
    return;
}

bool u2f_is_channel_broadcast(uint8_t *channel) {
c0d04950:	b580      	push	{r7, lr}
    return (os_memcmp(channel, BROADCAST_CHANNEL, 4) == 0);
c0d04952:	4906      	ldr	r1, [pc, #24]	; (c0d0496c <u2f_is_channel_broadcast+0x1c>)
c0d04954:	4479      	add	r1, pc
c0d04956:	2204      	movs	r2, #4
c0d04958:	f7fe fa4c 	bl	c0d02df4 <os_memcmp>
c0d0495c:	4601      	mov	r1, r0
c0d0495e:	2001      	movs	r0, #1
c0d04960:	2200      	movs	r2, #0
c0d04962:	2900      	cmp	r1, #0
c0d04964:	d000      	beq.n	c0d04968 <u2f_is_channel_broadcast+0x18>
c0d04966:	4610      	mov	r0, r2
c0d04968:	bd80      	pop	{r7, pc}
c0d0496a:	46c0      	nop			; (mov r8, r8)
c0d0496c:	00002825 	.word	0x00002825

c0d04970 <u2f_message_set_autoreply_wait_user_presence>:
}

/**
 * Auto reply hodl until the real reply is prepared and sent
 */
void u2f_message_set_autoreply_wait_user_presence(u2f_service_t* service, bool enabled) {
c0d04970:	b580      	push	{r7, lr}
c0d04972:	222a      	movs	r2, #42	; 0x2a
c0d04974:	5c83      	ldrb	r3, [r0, r2]
c0d04976:	4602      	mov	r2, r0
c0d04978:	322a      	adds	r2, #42	; 0x2a

    if (enabled) {
c0d0497a:	2901      	cmp	r1, #1
c0d0497c:	d106      	bne.n	c0d0498c <u2f_message_set_autoreply_wait_user_presence+0x1c>
        // start replying placeholder until user presence validated
        if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE) {
c0d0497e:	2b00      	cmp	r3, #0
c0d04980:	d108      	bne.n	c0d04994 <u2f_message_set_autoreply_wait_user_presence+0x24>
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
c0d04982:	2101      	movs	r1, #1
c0d04984:	7011      	strb	r1, [r2, #0]
            u2f_transport_send_usb_user_presence_required(service);
c0d04986:	f7ff fd3f 	bl	c0d04408 <u2f_transport_send_usb_user_presence_required>
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
    }
}
c0d0498a:	bd80      	pop	{r7, pc}
            service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_ON;
            u2f_transport_send_usb_user_presence_required(service);
        }
    }
    // don't set to REPLY_READY when it has not been enabled beforehand
    else if (service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_ON) {
c0d0498c:	2b01      	cmp	r3, #1
c0d0498e:	d101      	bne.n	c0d04994 <u2f_message_set_autoreply_wait_user_presence+0x24>
        service->waitAsynchronousResponse = U2F_WAIT_ASYNCH_REPLY_READY;
c0d04990:	2002      	movs	r0, #2
c0d04992:	7010      	strb	r0, [r2, #0]
    }
}
c0d04994:	bd80      	pop	{r7, pc}
	...

c0d04998 <u2f_message_reply>:
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
            && service->sending == false)
        ;
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {
c0d04998:	b570      	push	{r4, r5, r6, lr}
c0d0499a:	4604      	mov	r4, r0

bool u2f_message_repliable(u2f_service_t* service) {
    // no more asynch replies
    // finished receiving the command
    // and not sending a user presence required status
    return service->waitAsynchronousResponse == U2F_WAIT_ASYNCH_IDLE
c0d0499c:	202a      	movs	r0, #42	; 0x2a
c0d0499e:	5c20      	ldrb	r0, [r4, r0]
        || (service->waitAsynchronousResponse != U2F_WAIT_ASYNCH_ON 
c0d049a0:	2800      	cmp	r0, #0
c0d049a2:	d009      	beq.n	c0d049b8 <u2f_message_reply+0x20>
c0d049a4:	2801      	cmp	r0, #1
c0d049a6:	d024      	beq.n	c0d049f2 <u2f_message_reply+0x5a>
            && service->fakeChannelTransportState == U2F_FAKE_RECEIVED 
c0d049a8:	2025      	movs	r0, #37	; 0x25
c0d049aa:	5c20      	ldrb	r0, [r4, r0]
            && service->sending == false)
c0d049ac:	2806      	cmp	r0, #6
c0d049ae:	d120      	bne.n	c0d049f2 <u2f_message_reply+0x5a>
c0d049b0:	202b      	movs	r0, #43	; 0x2b
c0d049b2:	5c20      	ldrb	r0, [r4, r0]
}

void u2f_message_reply(u2f_service_t *service, uint8_t cmd, uint8_t *buffer, uint16_t len) {

    // if U2F is not ready to reply, then gently avoid replying
    if (u2f_message_repliable(service)) 
c0d049b4:	2800      	cmp	r0, #0
c0d049b6:	d11c      	bne.n	c0d049f2 <u2f_message_reply+0x5a>
    {
        service->transportState = U2F_SENDING_RESPONSE;
c0d049b8:	2020      	movs	r0, #32
c0d049ba:	2503      	movs	r5, #3
c0d049bc:	5425      	strb	r5, [r4, r0]
c0d049be:	2000      	movs	r0, #0
        service->transportPacketIndex = 0;
c0d049c0:	76a0      	strb	r0, [r4, #26]
        service->transportBuffer = buffer;
c0d049c2:	61e2      	str	r2, [r4, #28]
        service->transportOffset = 0;
c0d049c4:	82e0      	strh	r0, [r4, #22]
        service->transportLength = len;
c0d049c6:	8323      	strh	r3, [r4, #24]
        service->sendCmd = cmd;
c0d049c8:	2040      	movs	r0, #64	; 0x40
c0d049ca:	5421      	strb	r1, [r4, r0]
        if (service->transportMedia != U2F_MEDIA_BLE) {
c0d049cc:	2021      	movs	r0, #33	; 0x21
c0d049ce:	5c21      	ldrb	r1, [r4, r0]
c0d049d0:	4625      	mov	r5, r4
c0d049d2:	3521      	adds	r5, #33	; 0x21
c0d049d4:	2903      	cmp	r1, #3
c0d049d6:	d10d      	bne.n	c0d049f4 <u2f_message_reply+0x5c>
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
        }
        else {
            while (G_io_app.apdu_state != APDU_IDLE) {
c0d049d8:	4e08      	ldr	r6, [pc, #32]	; (c0d049fc <u2f_message_reply+0x64>)
c0d049da:	7830      	ldrb	r0, [r6, #0]
c0d049dc:	2800      	cmp	r0, #0
c0d049de:	d008      	beq.n	c0d049f2 <u2f_message_reply+0x5a>
                u2f_transport_sent(service, service->transportMedia);       
c0d049e0:	2103      	movs	r1, #3
c0d049e2:	e000      	b.n	c0d049e6 <u2f_message_reply+0x4e>
c0d049e4:	7829      	ldrb	r1, [r5, #0]
c0d049e6:	4620      	mov	r0, r4
c0d049e8:	f7ff fc66 	bl	c0d042b8 <u2f_transport_sent>
c0d049ec:	7830      	ldrb	r0, [r6, #0]
c0d049ee:	2800      	cmp	r0, #0
c0d049f0:	d1f8      	bne.n	c0d049e4 <u2f_message_reply+0x4c>
            }
        }
    }
}
c0d049f2:	bd70      	pop	{r4, r5, r6, pc}
        service->transportOffset = 0;
        service->transportLength = len;
        service->sendCmd = cmd;
        if (service->transportMedia != U2F_MEDIA_BLE) {
            // pump the first message
            u2f_transport_sent(service, service->transportMedia);
c0d049f4:	4620      	mov	r0, r4
c0d049f6:	f7ff fc5f 	bl	c0d042b8 <u2f_transport_sent>
            while (G_io_app.apdu_state != APDU_IDLE) {
                u2f_transport_sent(service, service->transportMedia);       
            }
        }
    }
}
c0d049fa:	bd70      	pop	{r4, r5, r6, pc}
c0d049fc:	20002110 	.word	0x20002110

c0d04a00 <show>:
#include "context.h"

enum ui_state_e ui_state_now;

void show(enum ui_state_e state){
c0d04a00:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d04a02:	b081      	sub	sp, #4

    ui_state_now = state;
c0d04a04:	49fd      	ldr	r1, [pc, #1012]	; (c0d04dfc <show+0x3fc>)
c0d04a06:	7008      	strb	r0, [r1, #0]
        case UI_SIGN_TX:
            display_tx_part();
            UX_DISPLAY(ui_sign_tx_nanos, ui_sign_tx_nanos_prepro);
            break;
        case UI_APPROVAL_TX:
            UX_DISPLAY(ui_approval_tx_nanos, ui_sign_tx_nanos_prepro);
c0d04a08:	21aa      	movs	r1, #170	; 0xaa
        default:
            break;
    }
    
#else
    switch(state){
c0d04a0a:	9100      	str	r1, [sp, #0]
c0d04a0c:	2804      	cmp	r0, #4
c0d04a0e:	dc6f      	bgt.n	c0d04af0 <show+0xf0>
c0d04a10:	2801      	cmp	r0, #1
c0d04a12:	dc00      	bgt.n	c0d04a16 <show+0x16>
c0d04a14:	e0d3      	b.n	c0d04bbe <show+0x1be>
c0d04a16:	2802      	cmp	r0, #2
c0d04a18:	d100      	bne.n	c0d04a1c <show+0x1c>
c0d04a1a:	e193      	b.n	c0d04d44 <show+0x344>
c0d04a1c:	2803      	cmp	r0, #3
c0d04a1e:	d100      	bne.n	c0d04a22 <show+0x22>
c0d04a20:	e210      	b.n	c0d04e44 <show+0x444>
c0d04a22:	2804      	cmp	r0, #4
c0d04a24:	d001      	beq.n	c0d04a2a <show+0x2a>
c0d04a26:	f000 fc32 	bl	c0d0528e <show+0x88e>
        case UI_MAIN_CREATE_ACCOUNT:
            UX_DISPLAY(ui_main_create_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_CHOOSE_ACCOUNT:

            if(selected_account == 0){
c0d04a2a:	48f5      	ldr	r0, [pc, #980]	; (c0d04e00 <show+0x400>)
c0d04a2c:	6800      	ldr	r0, [r0, #0]
                UX_DISPLAY(ui_choose_account_zero_nanos, ui_main_nanos_prepro);
            } else {
                UX_DISPLAY(ui_choose_account_nanos, ui_main_nanos_prepro);
c0d04a2e:	4ef5      	ldr	r6, [pc, #980]	; (c0d04e04 <show+0x404>)
        case UI_MAIN_CREATE_ACCOUNT:
            UX_DISPLAY(ui_main_create_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_CHOOSE_ACCOUNT:

            if(selected_account == 0){
c0d04a30:	2800      	cmp	r0, #0
c0d04a32:	d100      	bne.n	c0d04a36 <show+0x36>
c0d04a34:	e3d8      	b.n	c0d051e8 <show+0x7e8>
                UX_DISPLAY(ui_choose_account_zero_nanos, ui_main_nanos_prepro);
            } else {
                UX_DISPLAY(ui_choose_account_nanos, ui_main_nanos_prepro);
c0d04a36:	48f4      	ldr	r0, [pc, #976]	; (c0d04e08 <show+0x408>)
c0d04a38:	4478      	add	r0, pc
c0d04a3a:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04a3c:	272c      	movs	r7, #44	; 0x2c
c0d04a3e:	2005      	movs	r0, #5
c0d04a40:	55f0      	strb	r0, [r6, r7]
c0d04a42:	48f2      	ldr	r0, [pc, #968]	; (c0d04e0c <show+0x40c>)
c0d04a44:	4478      	add	r0, pc
c0d04a46:	6370      	str	r0, [r6, #52]	; 0x34
c0d04a48:	48f1      	ldr	r0, [pc, #964]	; (c0d04e10 <show+0x410>)
c0d04a4a:	4478      	add	r0, pc
c0d04a4c:	6330      	str	r0, [r6, #48]	; 0x30
c0d04a4e:	2064      	movs	r0, #100	; 0x64
c0d04a50:	2103      	movs	r1, #3
c0d04a52:	5431      	strb	r1, [r6, r0]
c0d04a54:	2500      	movs	r5, #0
c0d04a56:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04a58:	4630      	mov	r0, r6
c0d04a5a:	3064      	adds	r0, #100	; 0x64
c0d04a5c:	f7ff f83a 	bl	c0d03ad4 <os_ux>
c0d04a60:	2404      	movs	r4, #4
c0d04a62:	4620      	mov	r0, r4
c0d04a64:	f7ff f8b4 	bl	c0d03bd0 <os_sched_last_status>
c0d04a68:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04a6a:	f7fe fb27 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04a6e:	f7fe fb27 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04a72:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04a74:	4620      	mov	r0, r4
c0d04a76:	f7ff f8ab 	bl	c0d03bd0 <os_sched_last_status>
c0d04a7a:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04a7c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04a7e:	2900      	cmp	r1, #0
c0d04a80:	9c00      	ldr	r4, [sp, #0]
c0d04a82:	d101      	bne.n	c0d04a88 <show+0x88>
c0d04a84:	f000 fc03 	bl	c0d0528e <show+0x88e>
c0d04a88:	2800      	cmp	r0, #0
c0d04a8a:	d101      	bne.n	c0d04a90 <show+0x90>
c0d04a8c:	f000 fbff 	bl	c0d0528e <show+0x88e>
c0d04a90:	2897      	cmp	r0, #151	; 0x97
c0d04a92:	d100      	bne.n	c0d04a96 <show+0x96>
c0d04a94:	e3fb      	b.n	c0d0528e <show+0x88e>
c0d04a96:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04a98:	5df1      	ldrb	r1, [r6, r7]
c0d04a9a:	b280      	uxth	r0, r0
c0d04a9c:	4288      	cmp	r0, r1
c0d04a9e:	d300      	bcc.n	c0d04aa2 <show+0xa2>
c0d04aa0:	e3f5      	b.n	c0d0528e <show+0x88e>
c0d04aa2:	f7ff f861 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04aa6:	2800      	cmp	r0, #0
c0d04aa8:	d000      	beq.n	c0d04aac <show+0xac>
c0d04aaa:	e3f0      	b.n	c0d0528e <show+0x88e>
c0d04aac:	f7fe ffdc 	bl	c0d03a68 <os_perso_isonboarded>
c0d04ab0:	42a0      	cmp	r0, r4
c0d04ab2:	d104      	bne.n	c0d04abe <show+0xbe>
c0d04ab4:	f7ff f802 	bl	c0d03abc <os_global_pin_is_validated>
c0d04ab8:	42a0      	cmp	r0, r4
c0d04aba:	d000      	beq.n	c0d04abe <show+0xbe>
c0d04abc:	e3e7      	b.n	c0d0528e <show+0x88e>
c0d04abe:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04ac0:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04ac2:	0149      	lsls	r1, r1, #5
c0d04ac4:	1840      	adds	r0, r0, r1
c0d04ac6:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04ac8:	2900      	cmp	r1, #0
c0d04aca:	d002      	beq.n	c0d04ad2 <show+0xd2>
c0d04acc:	4788      	blx	r1
c0d04ace:	2800      	cmp	r0, #0
c0d04ad0:	d007      	beq.n	c0d04ae2 <show+0xe2>
c0d04ad2:	2801      	cmp	r0, #1
c0d04ad4:	d103      	bne.n	c0d04ade <show+0xde>
c0d04ad6:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04ad8:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04ada:	0149      	lsls	r1, r1, #5
c0d04adc:	1840      	adds	r0, r0, r1
c0d04ade:	f7fb fe61 	bl	c0d007a4 <io_seproxyhal_display>
c0d04ae2:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04ae4:	1c40      	adds	r0, r0, #1
c0d04ae6:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04ae8:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04aea:	2900      	cmp	r1, #0
c0d04aec:	d1d4      	bne.n	c0d04a98 <show+0x98>
c0d04aee:	e3ce      	b.n	c0d0528e <show+0x88e>
c0d04af0:	2806      	cmp	r0, #6
c0d04af2:	dc00      	bgt.n	c0d04af6 <show+0xf6>
c0d04af4:	e0c5      	b.n	c0d04c82 <show+0x282>
c0d04af6:	2807      	cmp	r0, #7
c0d04af8:	d100      	bne.n	c0d04afc <show+0xfc>
c0d04afa:	e1fe      	b.n	c0d04efa <show+0x4fa>
c0d04afc:	2808      	cmp	r0, #8
c0d04afe:	d100      	bne.n	c0d04b02 <show+0x102>
c0d04b00:	e257      	b.n	c0d04fb2 <show+0x5b2>
c0d04b02:	2809      	cmp	r0, #9
c0d04b04:	d000      	beq.n	c0d04b08 <show+0x108>
c0d04b06:	e3c2      	b.n	c0d0528e <show+0x88e>
        case UI_SIGN_TX:
            display_tx_part();
            UX_DISPLAY(ui_sign_tx_nanos, ui_sign_tx_nanos_prepro);
            break;
        case UI_APPROVAL_TX:
            UX_DISPLAY(ui_approval_tx_nanos, ui_sign_tx_nanos_prepro);
c0d04b08:	4ebe      	ldr	r6, [pc, #760]	; (c0d04e04 <show+0x404>)
c0d04b0a:	48c2      	ldr	r0, [pc, #776]	; (c0d04e14 <show+0x414>)
c0d04b0c:	4478      	add	r0, pc
c0d04b0e:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04b10:	272c      	movs	r7, #44	; 0x2c
c0d04b12:	2404      	movs	r4, #4
c0d04b14:	55f4      	strb	r4, [r6, r7]
c0d04b16:	48c0      	ldr	r0, [pc, #768]	; (c0d04e18 <show+0x418>)
c0d04b18:	4478      	add	r0, pc
c0d04b1a:	6370      	str	r0, [r6, #52]	; 0x34
c0d04b1c:	48bf      	ldr	r0, [pc, #764]	; (c0d04e1c <show+0x41c>)
c0d04b1e:	4478      	add	r0, pc
c0d04b20:	6330      	str	r0, [r6, #48]	; 0x30
c0d04b22:	2064      	movs	r0, #100	; 0x64
c0d04b24:	2103      	movs	r1, #3
c0d04b26:	5431      	strb	r1, [r6, r0]
c0d04b28:	2500      	movs	r5, #0
c0d04b2a:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04b2c:	4630      	mov	r0, r6
c0d04b2e:	3064      	adds	r0, #100	; 0x64
c0d04b30:	f7fe ffd0 	bl	c0d03ad4 <os_ux>
c0d04b34:	4620      	mov	r0, r4
c0d04b36:	f7ff f84b 	bl	c0d03bd0 <os_sched_last_status>
c0d04b3a:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04b3c:	f7fe fabe 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04b40:	f7fe fabe 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04b44:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04b46:	4620      	mov	r0, r4
c0d04b48:	9c00      	ldr	r4, [sp, #0]
c0d04b4a:	f7ff f841 	bl	c0d03bd0 <os_sched_last_status>
c0d04b4e:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04b50:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04b52:	2900      	cmp	r1, #0
c0d04b54:	d100      	bne.n	c0d04b58 <show+0x158>
c0d04b56:	e39a      	b.n	c0d0528e <show+0x88e>
c0d04b58:	2800      	cmp	r0, #0
c0d04b5a:	d100      	bne.n	c0d04b5e <show+0x15e>
c0d04b5c:	e397      	b.n	c0d0528e <show+0x88e>
c0d04b5e:	2897      	cmp	r0, #151	; 0x97
c0d04b60:	d100      	bne.n	c0d04b64 <show+0x164>
c0d04b62:	e394      	b.n	c0d0528e <show+0x88e>
c0d04b64:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04b66:	5df1      	ldrb	r1, [r6, r7]
c0d04b68:	b280      	uxth	r0, r0
c0d04b6a:	4288      	cmp	r0, r1
c0d04b6c:	d300      	bcc.n	c0d04b70 <show+0x170>
c0d04b6e:	e38e      	b.n	c0d0528e <show+0x88e>
c0d04b70:	f7fe fffa 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04b74:	2800      	cmp	r0, #0
c0d04b76:	d000      	beq.n	c0d04b7a <show+0x17a>
c0d04b78:	e389      	b.n	c0d0528e <show+0x88e>
c0d04b7a:	f7fe ff75 	bl	c0d03a68 <os_perso_isonboarded>
c0d04b7e:	42a0      	cmp	r0, r4
c0d04b80:	d104      	bne.n	c0d04b8c <show+0x18c>
c0d04b82:	f7fe ff9b 	bl	c0d03abc <os_global_pin_is_validated>
c0d04b86:	42a0      	cmp	r0, r4
c0d04b88:	d000      	beq.n	c0d04b8c <show+0x18c>
c0d04b8a:	e380      	b.n	c0d0528e <show+0x88e>
c0d04b8c:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04b8e:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04b90:	0149      	lsls	r1, r1, #5
c0d04b92:	1840      	adds	r0, r0, r1
c0d04b94:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04b96:	2900      	cmp	r1, #0
c0d04b98:	d002      	beq.n	c0d04ba0 <show+0x1a0>
c0d04b9a:	4788      	blx	r1
c0d04b9c:	2800      	cmp	r0, #0
c0d04b9e:	d007      	beq.n	c0d04bb0 <show+0x1b0>
c0d04ba0:	2801      	cmp	r0, #1
c0d04ba2:	d103      	bne.n	c0d04bac <show+0x1ac>
c0d04ba4:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04ba6:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04ba8:	0149      	lsls	r1, r1, #5
c0d04baa:	1840      	adds	r0, r0, r1
c0d04bac:	f7fb fdfa 	bl	c0d007a4 <io_seproxyhal_display>
c0d04bb0:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04bb2:	1c40      	adds	r0, r0, #1
c0d04bb4:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04bb6:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04bb8:	2900      	cmp	r1, #0
c0d04bba:	d1d4      	bne.n	c0d04b66 <show+0x166>
c0d04bbc:	e367      	b.n	c0d0528e <show+0x88e>
c0d04bbe:	2800      	cmp	r0, #0
c0d04bc0:	d100      	bne.n	c0d04bc4 <show+0x1c4>
c0d04bc2:	e254      	b.n	c0d0506e <show+0x66e>
c0d04bc4:	2801      	cmp	r0, #1
c0d04bc6:	d000      	beq.n	c0d04bca <show+0x1ca>
c0d04bc8:	e361      	b.n	c0d0528e <show+0x88e>
    switch(state){
        case UI_MAIN:
            UX_DISPLAY(ui_main_nanos, ui_main_nanos_prepro);
            break;
        case UI_MAIN_CHOOSE_ACCOUNT:
            UX_DISPLAY(ui_main_choose_account_nanos, ui_main_nanos_prepro);
c0d04bca:	4e8e      	ldr	r6, [pc, #568]	; (c0d04e04 <show+0x404>)
c0d04bcc:	4894      	ldr	r0, [pc, #592]	; (c0d04e20 <show+0x420>)
c0d04bce:	4478      	add	r0, pc
c0d04bd0:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04bd2:	272c      	movs	r7, #44	; 0x2c
c0d04bd4:	2005      	movs	r0, #5
c0d04bd6:	55f0      	strb	r0, [r6, r7]
c0d04bd8:	4892      	ldr	r0, [pc, #584]	; (c0d04e24 <show+0x424>)
c0d04bda:	4478      	add	r0, pc
c0d04bdc:	6370      	str	r0, [r6, #52]	; 0x34
c0d04bde:	4892      	ldr	r0, [pc, #584]	; (c0d04e28 <show+0x428>)
c0d04be0:	4478      	add	r0, pc
c0d04be2:	6330      	str	r0, [r6, #48]	; 0x30
c0d04be4:	2064      	movs	r0, #100	; 0x64
c0d04be6:	2103      	movs	r1, #3
c0d04be8:	5431      	strb	r1, [r6, r0]
c0d04bea:	2500      	movs	r5, #0
c0d04bec:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04bee:	4630      	mov	r0, r6
c0d04bf0:	3064      	adds	r0, #100	; 0x64
c0d04bf2:	f7fe ff6f 	bl	c0d03ad4 <os_ux>
c0d04bf6:	2404      	movs	r4, #4
c0d04bf8:	4620      	mov	r0, r4
c0d04bfa:	f7fe ffe9 	bl	c0d03bd0 <os_sched_last_status>
c0d04bfe:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04c00:	f7fe fa5c 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04c04:	f7fe fa5c 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04c08:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04c0a:	4620      	mov	r0, r4
c0d04c0c:	9c00      	ldr	r4, [sp, #0]
c0d04c0e:	f7fe ffdf 	bl	c0d03bd0 <os_sched_last_status>
c0d04c12:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04c14:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04c16:	2900      	cmp	r1, #0
c0d04c18:	d100      	bne.n	c0d04c1c <show+0x21c>
c0d04c1a:	e338      	b.n	c0d0528e <show+0x88e>
c0d04c1c:	2800      	cmp	r0, #0
c0d04c1e:	d100      	bne.n	c0d04c22 <show+0x222>
c0d04c20:	e335      	b.n	c0d0528e <show+0x88e>
c0d04c22:	2897      	cmp	r0, #151	; 0x97
c0d04c24:	d100      	bne.n	c0d04c28 <show+0x228>
c0d04c26:	e332      	b.n	c0d0528e <show+0x88e>
c0d04c28:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04c2a:	5df1      	ldrb	r1, [r6, r7]
c0d04c2c:	b280      	uxth	r0, r0
c0d04c2e:	4288      	cmp	r0, r1
c0d04c30:	d300      	bcc.n	c0d04c34 <show+0x234>
c0d04c32:	e32c      	b.n	c0d0528e <show+0x88e>
c0d04c34:	f7fe ff98 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04c38:	2800      	cmp	r0, #0
c0d04c3a:	d000      	beq.n	c0d04c3e <show+0x23e>
c0d04c3c:	e327      	b.n	c0d0528e <show+0x88e>
c0d04c3e:	f7fe ff13 	bl	c0d03a68 <os_perso_isonboarded>
c0d04c42:	42a0      	cmp	r0, r4
c0d04c44:	d104      	bne.n	c0d04c50 <show+0x250>
c0d04c46:	f7fe ff39 	bl	c0d03abc <os_global_pin_is_validated>
c0d04c4a:	42a0      	cmp	r0, r4
c0d04c4c:	d000      	beq.n	c0d04c50 <show+0x250>
c0d04c4e:	e31e      	b.n	c0d0528e <show+0x88e>
c0d04c50:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04c52:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04c54:	0149      	lsls	r1, r1, #5
c0d04c56:	1840      	adds	r0, r0, r1
c0d04c58:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04c5a:	2900      	cmp	r1, #0
c0d04c5c:	d002      	beq.n	c0d04c64 <show+0x264>
c0d04c5e:	4788      	blx	r1
c0d04c60:	2800      	cmp	r0, #0
c0d04c62:	d007      	beq.n	c0d04c74 <show+0x274>
c0d04c64:	2801      	cmp	r0, #1
c0d04c66:	d103      	bne.n	c0d04c70 <show+0x270>
c0d04c68:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04c6a:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04c6c:	0149      	lsls	r1, r1, #5
c0d04c6e:	1840      	adds	r0, r0, r1
c0d04c70:	f7fb fd98 	bl	c0d007a4 <io_seproxyhal_display>
c0d04c74:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04c76:	1c40      	adds	r0, r0, #1
c0d04c78:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04c7a:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04c7c:	2900      	cmp	r1, #0
c0d04c7e:	d1d4      	bne.n	c0d04c2a <show+0x22a>
c0d04c80:	e305      	b.n	c0d0528e <show+0x88e>
c0d04c82:	2805      	cmp	r0, #5
c0d04c84:	d100      	bne.n	c0d04c88 <show+0x288>
c0d04c86:	e24d      	b.n	c0d05124 <show+0x724>
c0d04c88:	2806      	cmp	r0, #6
c0d04c8a:	d000      	beq.n	c0d04c8e <show+0x28e>
c0d04c8c:	e2ff      	b.n	c0d0528e <show+0x88e>
            break;
        case UI_CREATE_ACCOUNT:
            UX_DISPLAY(ui_create_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_ACCOUNT_BACK:
            UX_DISPLAY(ui_account_back_nanos, ui_main_nanos_prepro);
c0d04c8e:	4e5d      	ldr	r6, [pc, #372]	; (c0d04e04 <show+0x404>)
c0d04c90:	4866      	ldr	r0, [pc, #408]	; (c0d04e2c <show+0x42c>)
c0d04c92:	4478      	add	r0, pc
c0d04c94:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04c96:	272c      	movs	r7, #44	; 0x2c
c0d04c98:	2404      	movs	r4, #4
c0d04c9a:	55f4      	strb	r4, [r6, r7]
c0d04c9c:	4864      	ldr	r0, [pc, #400]	; (c0d04e30 <show+0x430>)
c0d04c9e:	4478      	add	r0, pc
c0d04ca0:	6370      	str	r0, [r6, #52]	; 0x34
c0d04ca2:	4864      	ldr	r0, [pc, #400]	; (c0d04e34 <show+0x434>)
c0d04ca4:	4478      	add	r0, pc
c0d04ca6:	6330      	str	r0, [r6, #48]	; 0x30
c0d04ca8:	2064      	movs	r0, #100	; 0x64
c0d04caa:	2103      	movs	r1, #3
c0d04cac:	5431      	strb	r1, [r6, r0]
c0d04cae:	2500      	movs	r5, #0
c0d04cb0:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04cb2:	4630      	mov	r0, r6
c0d04cb4:	3064      	adds	r0, #100	; 0x64
c0d04cb6:	f7fe ff0d 	bl	c0d03ad4 <os_ux>
c0d04cba:	4620      	mov	r0, r4
c0d04cbc:	f7fe ff88 	bl	c0d03bd0 <os_sched_last_status>
c0d04cc0:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04cc2:	f7fe f9fb 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04cc6:	f7fe f9fb 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04cca:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04ccc:	4620      	mov	r0, r4
c0d04cce:	9c00      	ldr	r4, [sp, #0]
c0d04cd0:	f7fe ff7e 	bl	c0d03bd0 <os_sched_last_status>
c0d04cd4:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04cd6:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04cd8:	2900      	cmp	r1, #0
c0d04cda:	d100      	bne.n	c0d04cde <show+0x2de>
c0d04cdc:	e2d7      	b.n	c0d0528e <show+0x88e>
c0d04cde:	2800      	cmp	r0, #0
c0d04ce0:	d100      	bne.n	c0d04ce4 <show+0x2e4>
c0d04ce2:	e2d4      	b.n	c0d0528e <show+0x88e>
c0d04ce4:	2897      	cmp	r0, #151	; 0x97
c0d04ce6:	d100      	bne.n	c0d04cea <show+0x2ea>
c0d04ce8:	e2d1      	b.n	c0d0528e <show+0x88e>
c0d04cea:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04cec:	5df1      	ldrb	r1, [r6, r7]
c0d04cee:	b280      	uxth	r0, r0
c0d04cf0:	4288      	cmp	r0, r1
c0d04cf2:	d300      	bcc.n	c0d04cf6 <show+0x2f6>
c0d04cf4:	e2cb      	b.n	c0d0528e <show+0x88e>
c0d04cf6:	f7fe ff37 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04cfa:	2800      	cmp	r0, #0
c0d04cfc:	d000      	beq.n	c0d04d00 <show+0x300>
c0d04cfe:	e2c6      	b.n	c0d0528e <show+0x88e>
c0d04d00:	f7fe feb2 	bl	c0d03a68 <os_perso_isonboarded>
c0d04d04:	42a0      	cmp	r0, r4
c0d04d06:	d104      	bne.n	c0d04d12 <show+0x312>
c0d04d08:	f7fe fed8 	bl	c0d03abc <os_global_pin_is_validated>
c0d04d0c:	42a0      	cmp	r0, r4
c0d04d0e:	d000      	beq.n	c0d04d12 <show+0x312>
c0d04d10:	e2bd      	b.n	c0d0528e <show+0x88e>
c0d04d12:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04d14:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04d16:	0149      	lsls	r1, r1, #5
c0d04d18:	1840      	adds	r0, r0, r1
c0d04d1a:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04d1c:	2900      	cmp	r1, #0
c0d04d1e:	d002      	beq.n	c0d04d26 <show+0x326>
c0d04d20:	4788      	blx	r1
c0d04d22:	2800      	cmp	r0, #0
c0d04d24:	d007      	beq.n	c0d04d36 <show+0x336>
c0d04d26:	2801      	cmp	r0, #1
c0d04d28:	d103      	bne.n	c0d04d32 <show+0x332>
c0d04d2a:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04d2c:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04d2e:	0149      	lsls	r1, r1, #5
c0d04d30:	1840      	adds	r0, r0, r1
c0d04d32:	f7fb fd37 	bl	c0d007a4 <io_seproxyhal_display>
c0d04d36:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04d38:	1c40      	adds	r0, r0, #1
c0d04d3a:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04d3c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04d3e:	2900      	cmp	r1, #0
c0d04d40:	d1d4      	bne.n	c0d04cec <show+0x2ec>
c0d04d42:	e2a4      	b.n	c0d0528e <show+0x88e>
            break;
        case UI_MAIN_CHOOSE_ACCOUNT:
            UX_DISPLAY(ui_main_choose_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_MAIN_CREATE_ACCOUNT:
            UX_DISPLAY(ui_main_create_account_nanos, ui_main_nanos_prepro);
c0d04d44:	4e2f      	ldr	r6, [pc, #188]	; (c0d04e04 <show+0x404>)
c0d04d46:	483c      	ldr	r0, [pc, #240]	; (c0d04e38 <show+0x438>)
c0d04d48:	4478      	add	r0, pc
c0d04d4a:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04d4c:	272c      	movs	r7, #44	; 0x2c
c0d04d4e:	2005      	movs	r0, #5
c0d04d50:	55f0      	strb	r0, [r6, r7]
c0d04d52:	483a      	ldr	r0, [pc, #232]	; (c0d04e3c <show+0x43c>)
c0d04d54:	4478      	add	r0, pc
c0d04d56:	6370      	str	r0, [r6, #52]	; 0x34
c0d04d58:	4839      	ldr	r0, [pc, #228]	; (c0d04e40 <show+0x440>)
c0d04d5a:	4478      	add	r0, pc
c0d04d5c:	6330      	str	r0, [r6, #48]	; 0x30
c0d04d5e:	2064      	movs	r0, #100	; 0x64
c0d04d60:	2103      	movs	r1, #3
c0d04d62:	5431      	strb	r1, [r6, r0]
c0d04d64:	2500      	movs	r5, #0
c0d04d66:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04d68:	4630      	mov	r0, r6
c0d04d6a:	3064      	adds	r0, #100	; 0x64
c0d04d6c:	f7fe feb2 	bl	c0d03ad4 <os_ux>
c0d04d70:	2404      	movs	r4, #4
c0d04d72:	4620      	mov	r0, r4
c0d04d74:	f7fe ff2c 	bl	c0d03bd0 <os_sched_last_status>
c0d04d78:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04d7a:	f7fe f99f 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04d7e:	f7fe f99f 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04d82:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04d84:	4620      	mov	r0, r4
c0d04d86:	f7fe ff23 	bl	c0d03bd0 <os_sched_last_status>
c0d04d8a:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04d8c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04d8e:	2900      	cmp	r1, #0
c0d04d90:	9c00      	ldr	r4, [sp, #0]
c0d04d92:	d100      	bne.n	c0d04d96 <show+0x396>
c0d04d94:	e27b      	b.n	c0d0528e <show+0x88e>
c0d04d96:	2800      	cmp	r0, #0
c0d04d98:	d100      	bne.n	c0d04d9c <show+0x39c>
c0d04d9a:	e278      	b.n	c0d0528e <show+0x88e>
c0d04d9c:	2897      	cmp	r0, #151	; 0x97
c0d04d9e:	d100      	bne.n	c0d04da2 <show+0x3a2>
c0d04da0:	e275      	b.n	c0d0528e <show+0x88e>
c0d04da2:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04da4:	5df1      	ldrb	r1, [r6, r7]
c0d04da6:	b280      	uxth	r0, r0
c0d04da8:	4288      	cmp	r0, r1
c0d04daa:	d300      	bcc.n	c0d04dae <show+0x3ae>
c0d04dac:	e26f      	b.n	c0d0528e <show+0x88e>
c0d04dae:	f7fe fedb 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04db2:	2800      	cmp	r0, #0
c0d04db4:	d000      	beq.n	c0d04db8 <show+0x3b8>
c0d04db6:	e26a      	b.n	c0d0528e <show+0x88e>
c0d04db8:	f7fe fe56 	bl	c0d03a68 <os_perso_isonboarded>
c0d04dbc:	42a0      	cmp	r0, r4
c0d04dbe:	d104      	bne.n	c0d04dca <show+0x3ca>
c0d04dc0:	f7fe fe7c 	bl	c0d03abc <os_global_pin_is_validated>
c0d04dc4:	42a0      	cmp	r0, r4
c0d04dc6:	d000      	beq.n	c0d04dca <show+0x3ca>
c0d04dc8:	e261      	b.n	c0d0528e <show+0x88e>
c0d04dca:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04dcc:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04dce:	0149      	lsls	r1, r1, #5
c0d04dd0:	1840      	adds	r0, r0, r1
c0d04dd2:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04dd4:	2900      	cmp	r1, #0
c0d04dd6:	d002      	beq.n	c0d04dde <show+0x3de>
c0d04dd8:	4788      	blx	r1
c0d04dda:	2800      	cmp	r0, #0
c0d04ddc:	d007      	beq.n	c0d04dee <show+0x3ee>
c0d04dde:	2801      	cmp	r0, #1
c0d04de0:	d103      	bne.n	c0d04dea <show+0x3ea>
c0d04de2:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04de4:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04de6:	0149      	lsls	r1, r1, #5
c0d04de8:	1840      	adds	r0, r0, r1
c0d04dea:	f7fb fcdb 	bl	c0d007a4 <io_seproxyhal_display>
c0d04dee:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04df0:	1c40      	adds	r0, r0, #1
c0d04df2:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04df4:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04df6:	2900      	cmp	r1, #0
c0d04df8:	d1d4      	bne.n	c0d04da4 <show+0x3a4>
c0d04dfa:	e248      	b.n	c0d0528e <show+0x88e>
c0d04dfc:	200021fc 	.word	0x200021fc
c0d04e00:	20001d20 	.word	0x20001d20
c0d04e04:	20001e70 	.word	0x20001e70
c0d04e08:	0000298c 	.word	0x0000298c
c0d04e0c:	000008f5 	.word	0x000008f5
c0d04e10:	00000a77 	.word	0x00000a77
c0d04e14:	00002c38 	.word	0x00002c38
c0d04e18:	00000cc5 	.word	0x00000cc5
c0d04e1c:	00000ce7 	.word	0x00000ce7
c0d04e20:	00002636 	.word	0x00002636
c0d04e24:	0000091b 	.word	0x0000091b
c0d04e28:	000008e1 	.word	0x000008e1
c0d04e2c:	00002872 	.word	0x00002872
c0d04e30:	00000787 	.word	0x00000787
c0d04e34:	0000081d 	.word	0x0000081d
c0d04e38:	0000255c 	.word	0x0000255c
c0d04e3c:	000007d5 	.word	0x000007d5
c0d04e40:	00000767 	.word	0x00000767

            
            UX_DISPLAY(ui_confirm_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_MAIN_EXIT:
            UX_DISPLAY(ui_main_exit_nanos, ui_main_nanos_prepro);
c0d04e44:	4ee4      	ldr	r6, [pc, #912]	; (c0d051d8 <show+0x7d8>)
c0d04e46:	48e5      	ldr	r0, [pc, #916]	; (c0d051dc <show+0x7dc>)
c0d04e48:	4478      	add	r0, pc
c0d04e4a:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04e4c:	272c      	movs	r7, #44	; 0x2c
c0d04e4e:	2404      	movs	r4, #4
c0d04e50:	55f4      	strb	r4, [r6, r7]
c0d04e52:	48e3      	ldr	r0, [pc, #908]	; (c0d051e0 <show+0x7e0>)
c0d04e54:	4478      	add	r0, pc
c0d04e56:	6370      	str	r0, [r6, #52]	; 0x34
c0d04e58:	48e2      	ldr	r0, [pc, #904]	; (c0d051e4 <show+0x7e4>)
c0d04e5a:	4478      	add	r0, pc
c0d04e5c:	6330      	str	r0, [r6, #48]	; 0x30
c0d04e5e:	2064      	movs	r0, #100	; 0x64
c0d04e60:	2103      	movs	r1, #3
c0d04e62:	5431      	strb	r1, [r6, r0]
c0d04e64:	2500      	movs	r5, #0
c0d04e66:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04e68:	4630      	mov	r0, r6
c0d04e6a:	3064      	adds	r0, #100	; 0x64
c0d04e6c:	f7fe fe32 	bl	c0d03ad4 <os_ux>
c0d04e70:	4620      	mov	r0, r4
c0d04e72:	f7fe fead 	bl	c0d03bd0 <os_sched_last_status>
c0d04e76:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04e78:	f7fe f920 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04e7c:	f7fe f920 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04e80:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04e82:	4620      	mov	r0, r4
c0d04e84:	f7fe fea4 	bl	c0d03bd0 <os_sched_last_status>
c0d04e88:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04e8a:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04e8c:	2900      	cmp	r1, #0
c0d04e8e:	9c00      	ldr	r4, [sp, #0]
c0d04e90:	d100      	bne.n	c0d04e94 <show+0x494>
c0d04e92:	e1fc      	b.n	c0d0528e <show+0x88e>
c0d04e94:	2800      	cmp	r0, #0
c0d04e96:	d100      	bne.n	c0d04e9a <show+0x49a>
c0d04e98:	e1f9      	b.n	c0d0528e <show+0x88e>
c0d04e9a:	2897      	cmp	r0, #151	; 0x97
c0d04e9c:	d100      	bne.n	c0d04ea0 <show+0x4a0>
c0d04e9e:	e1f6      	b.n	c0d0528e <show+0x88e>
c0d04ea0:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04ea2:	5df1      	ldrb	r1, [r6, r7]
c0d04ea4:	b280      	uxth	r0, r0
c0d04ea6:	4288      	cmp	r0, r1
c0d04ea8:	d300      	bcc.n	c0d04eac <show+0x4ac>
c0d04eaa:	e1f0      	b.n	c0d0528e <show+0x88e>
c0d04eac:	f7fe fe5c 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04eb0:	2800      	cmp	r0, #0
c0d04eb2:	d000      	beq.n	c0d04eb6 <show+0x4b6>
c0d04eb4:	e1eb      	b.n	c0d0528e <show+0x88e>
c0d04eb6:	f7fe fdd7 	bl	c0d03a68 <os_perso_isonboarded>
c0d04eba:	42a0      	cmp	r0, r4
c0d04ebc:	d104      	bne.n	c0d04ec8 <show+0x4c8>
c0d04ebe:	f7fe fdfd 	bl	c0d03abc <os_global_pin_is_validated>
c0d04ec2:	42a0      	cmp	r0, r4
c0d04ec4:	d000      	beq.n	c0d04ec8 <show+0x4c8>
c0d04ec6:	e1e2      	b.n	c0d0528e <show+0x88e>
c0d04ec8:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04eca:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04ecc:	0149      	lsls	r1, r1, #5
c0d04ece:	1840      	adds	r0, r0, r1
c0d04ed0:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04ed2:	2900      	cmp	r1, #0
c0d04ed4:	d002      	beq.n	c0d04edc <show+0x4dc>
c0d04ed6:	4788      	blx	r1
c0d04ed8:	2800      	cmp	r0, #0
c0d04eda:	d007      	beq.n	c0d04eec <show+0x4ec>
c0d04edc:	2801      	cmp	r0, #1
c0d04ede:	d103      	bne.n	c0d04ee8 <show+0x4e8>
c0d04ee0:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04ee2:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04ee4:	0149      	lsls	r1, r1, #5
c0d04ee6:	1840      	adds	r0, r0, r1
c0d04ee8:	f7fb fc5c 	bl	c0d007a4 <io_seproxyhal_display>
c0d04eec:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04eee:	1c40      	adds	r0, r0, #1
c0d04ef0:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04ef2:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04ef4:	2900      	cmp	r1, #0
c0d04ef6:	d1d4      	bne.n	c0d04ea2 <show+0x4a2>
c0d04ef8:	e1c9      	b.n	c0d0528e <show+0x88e>
            UX_DISPLAY(ui_account_back_nanos, ui_main_nanos_prepro);
            break;
        case UI_CONFIRM_ACCOUNT:

            
            UX_DISPLAY(ui_confirm_account_nanos, ui_main_nanos_prepro);
c0d04efa:	4ee6      	ldr	r6, [pc, #920]	; (c0d05294 <show+0x894>)
c0d04efc:	48ef      	ldr	r0, [pc, #956]	; (c0d052bc <show+0x8bc>)
c0d04efe:	4478      	add	r0, pc
c0d04f00:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04f02:	272c      	movs	r7, #44	; 0x2c
c0d04f04:	2005      	movs	r0, #5
c0d04f06:	55f0      	strb	r0, [r6, r7]
c0d04f08:	48ed      	ldr	r0, [pc, #948]	; (c0d052c0 <show+0x8c0>)
c0d04f0a:	4478      	add	r0, pc
c0d04f0c:	6370      	str	r0, [r6, #52]	; 0x34
c0d04f0e:	48ed      	ldr	r0, [pc, #948]	; (c0d052c4 <show+0x8c4>)
c0d04f10:	4478      	add	r0, pc
c0d04f12:	6330      	str	r0, [r6, #48]	; 0x30
c0d04f14:	2064      	movs	r0, #100	; 0x64
c0d04f16:	2103      	movs	r1, #3
c0d04f18:	5431      	strb	r1, [r6, r0]
c0d04f1a:	2500      	movs	r5, #0
c0d04f1c:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04f1e:	4630      	mov	r0, r6
c0d04f20:	3064      	adds	r0, #100	; 0x64
c0d04f22:	f7fe fdd7 	bl	c0d03ad4 <os_ux>
c0d04f26:	2404      	movs	r4, #4
c0d04f28:	4620      	mov	r0, r4
c0d04f2a:	f7fe fe51 	bl	c0d03bd0 <os_sched_last_status>
c0d04f2e:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04f30:	f7fe f8c4 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04f34:	f7fe f8c4 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04f38:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04f3a:	4620      	mov	r0, r4
c0d04f3c:	f7fe fe48 	bl	c0d03bd0 <os_sched_last_status>
c0d04f40:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04f42:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04f44:	2900      	cmp	r1, #0
c0d04f46:	9c00      	ldr	r4, [sp, #0]
c0d04f48:	d100      	bne.n	c0d04f4c <show+0x54c>
c0d04f4a:	e1a0      	b.n	c0d0528e <show+0x88e>
c0d04f4c:	2800      	cmp	r0, #0
c0d04f4e:	d100      	bne.n	c0d04f52 <show+0x552>
c0d04f50:	e19d      	b.n	c0d0528e <show+0x88e>
c0d04f52:	2897      	cmp	r0, #151	; 0x97
c0d04f54:	d100      	bne.n	c0d04f58 <show+0x558>
c0d04f56:	e19a      	b.n	c0d0528e <show+0x88e>
c0d04f58:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04f5a:	5df1      	ldrb	r1, [r6, r7]
c0d04f5c:	b280      	uxth	r0, r0
c0d04f5e:	4288      	cmp	r0, r1
c0d04f60:	d300      	bcc.n	c0d04f64 <show+0x564>
c0d04f62:	e194      	b.n	c0d0528e <show+0x88e>
c0d04f64:	f7fe fe00 	bl	c0d03b68 <io_seph_is_status_sent>
c0d04f68:	2800      	cmp	r0, #0
c0d04f6a:	d000      	beq.n	c0d04f6e <show+0x56e>
c0d04f6c:	e18f      	b.n	c0d0528e <show+0x88e>
c0d04f6e:	f7fe fd7b 	bl	c0d03a68 <os_perso_isonboarded>
c0d04f72:	42a0      	cmp	r0, r4
c0d04f74:	d104      	bne.n	c0d04f80 <show+0x580>
c0d04f76:	f7fe fda1 	bl	c0d03abc <os_global_pin_is_validated>
c0d04f7a:	42a0      	cmp	r0, r4
c0d04f7c:	d000      	beq.n	c0d04f80 <show+0x580>
c0d04f7e:	e186      	b.n	c0d0528e <show+0x88e>
c0d04f80:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04f82:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04f84:	0149      	lsls	r1, r1, #5
c0d04f86:	1840      	adds	r0, r0, r1
c0d04f88:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d04f8a:	2900      	cmp	r1, #0
c0d04f8c:	d002      	beq.n	c0d04f94 <show+0x594>
c0d04f8e:	4788      	blx	r1
c0d04f90:	2800      	cmp	r0, #0
c0d04f92:	d007      	beq.n	c0d04fa4 <show+0x5a4>
c0d04f94:	2801      	cmp	r0, #1
c0d04f96:	d103      	bne.n	c0d04fa0 <show+0x5a0>
c0d04f98:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d04f9a:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d04f9c:	0149      	lsls	r1, r1, #5
c0d04f9e:	1840      	adds	r0, r0, r1
c0d04fa0:	f7fb fc00 	bl	c0d007a4 <io_seproxyhal_display>
c0d04fa4:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d04fa6:	1c40      	adds	r0, r0, #1
c0d04fa8:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d04faa:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d04fac:	2900      	cmp	r1, #0
c0d04fae:	d1d4      	bne.n	c0d04f5a <show+0x55a>
c0d04fb0:	e16d      	b.n	c0d0528e <show+0x88e>
            break;
        case UI_MAIN_EXIT:
            UX_DISPLAY(ui_main_exit_nanos, ui_main_nanos_prepro);
            break;
        case UI_SIGN_TX:
            display_tx_part();
c0d04fb2:	f000 fb23 	bl	c0d055fc <display_tx_part>
            UX_DISPLAY(ui_sign_tx_nanos, ui_sign_tx_nanos_prepro);
c0d04fb6:	4eb7      	ldr	r6, [pc, #732]	; (c0d05294 <show+0x894>)
c0d04fb8:	48c3      	ldr	r0, [pc, #780]	; (c0d052c8 <show+0x8c8>)
c0d04fba:	4478      	add	r0, pc
c0d04fbc:	62b0      	str	r0, [r6, #40]	; 0x28
c0d04fbe:	272c      	movs	r7, #44	; 0x2c
c0d04fc0:	2005      	movs	r0, #5
c0d04fc2:	55f0      	strb	r0, [r6, r7]
c0d04fc4:	48c1      	ldr	r0, [pc, #772]	; (c0d052cc <show+0x8cc>)
c0d04fc6:	4478      	add	r0, pc
c0d04fc8:	6370      	str	r0, [r6, #52]	; 0x34
c0d04fca:	48c1      	ldr	r0, [pc, #772]	; (c0d052d0 <show+0x8d0>)
c0d04fcc:	4478      	add	r0, pc
c0d04fce:	6330      	str	r0, [r6, #48]	; 0x30
c0d04fd0:	2064      	movs	r0, #100	; 0x64
c0d04fd2:	2103      	movs	r1, #3
c0d04fd4:	5431      	strb	r1, [r6, r0]
c0d04fd6:	2500      	movs	r5, #0
c0d04fd8:	66b5      	str	r5, [r6, #104]	; 0x68
c0d04fda:	4630      	mov	r0, r6
c0d04fdc:	3064      	adds	r0, #100	; 0x64
c0d04fde:	f7fe fd79 	bl	c0d03ad4 <os_ux>
c0d04fe2:	2404      	movs	r4, #4
c0d04fe4:	4620      	mov	r0, r4
c0d04fe6:	f7fe fdf3 	bl	c0d03bd0 <os_sched_last_status>
c0d04fea:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04fec:	f7fe f866 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d04ff0:	f7fe f866 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d04ff4:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d04ff6:	4620      	mov	r0, r4
c0d04ff8:	f7fe fdea 	bl	c0d03bd0 <os_sched_last_status>
c0d04ffc:	66b0      	str	r0, [r6, #104]	; 0x68
c0d04ffe:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d05000:	2900      	cmp	r1, #0
c0d05002:	9c00      	ldr	r4, [sp, #0]
c0d05004:	d100      	bne.n	c0d05008 <show+0x608>
c0d05006:	e142      	b.n	c0d0528e <show+0x88e>
c0d05008:	2800      	cmp	r0, #0
c0d0500a:	d100      	bne.n	c0d0500e <show+0x60e>
c0d0500c:	e13f      	b.n	c0d0528e <show+0x88e>
c0d0500e:	2897      	cmp	r0, #151	; 0x97
c0d05010:	d100      	bne.n	c0d05014 <show+0x614>
c0d05012:	e13c      	b.n	c0d0528e <show+0x88e>
c0d05014:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d05016:	5df1      	ldrb	r1, [r6, r7]
c0d05018:	b280      	uxth	r0, r0
c0d0501a:	4288      	cmp	r0, r1
c0d0501c:	d300      	bcc.n	c0d05020 <show+0x620>
c0d0501e:	e136      	b.n	c0d0528e <show+0x88e>
c0d05020:	f7fe fda2 	bl	c0d03b68 <io_seph_is_status_sent>
c0d05024:	2800      	cmp	r0, #0
c0d05026:	d000      	beq.n	c0d0502a <show+0x62a>
c0d05028:	e131      	b.n	c0d0528e <show+0x88e>
c0d0502a:	f7fe fd1d 	bl	c0d03a68 <os_perso_isonboarded>
c0d0502e:	42a0      	cmp	r0, r4
c0d05030:	d104      	bne.n	c0d0503c <show+0x63c>
c0d05032:	f7fe fd43 	bl	c0d03abc <os_global_pin_is_validated>
c0d05036:	42a0      	cmp	r0, r4
c0d05038:	d000      	beq.n	c0d0503c <show+0x63c>
c0d0503a:	e128      	b.n	c0d0528e <show+0x88e>
c0d0503c:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d0503e:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d05040:	0149      	lsls	r1, r1, #5
c0d05042:	1840      	adds	r0, r0, r1
c0d05044:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d05046:	2900      	cmp	r1, #0
c0d05048:	d002      	beq.n	c0d05050 <show+0x650>
c0d0504a:	4788      	blx	r1
c0d0504c:	2800      	cmp	r0, #0
c0d0504e:	d007      	beq.n	c0d05060 <show+0x660>
c0d05050:	2801      	cmp	r0, #1
c0d05052:	d103      	bne.n	c0d0505c <show+0x65c>
c0d05054:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d05056:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d05058:	0149      	lsls	r1, r1, #5
c0d0505a:	1840      	adds	r0, r0, r1
c0d0505c:	f7fb fba2 	bl	c0d007a4 <io_seproxyhal_display>
c0d05060:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d05062:	1c40      	adds	r0, r0, #1
c0d05064:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d05066:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d05068:	2900      	cmp	r1, #0
c0d0506a:	d1d4      	bne.n	c0d05016 <show+0x616>
c0d0506c:	e10f      	b.n	c0d0528e <show+0x88e>
    }
    
#else
    switch(state){
        case UI_MAIN:
            UX_DISPLAY(ui_main_nanos, ui_main_nanos_prepro);
c0d0506e:	4e89      	ldr	r6, [pc, #548]	; (c0d05294 <show+0x894>)
c0d05070:	488c      	ldr	r0, [pc, #560]	; (c0d052a4 <show+0x8a4>)
c0d05072:	4478      	add	r0, pc
c0d05074:	62b0      	str	r0, [r6, #40]	; 0x28
c0d05076:	272c      	movs	r7, #44	; 0x2c
c0d05078:	2404      	movs	r4, #4
c0d0507a:	55f4      	strb	r4, [r6, r7]
c0d0507c:	488a      	ldr	r0, [pc, #552]	; (c0d052a8 <show+0x8a8>)
c0d0507e:	4478      	add	r0, pc
c0d05080:	6370      	str	r0, [r6, #52]	; 0x34
c0d05082:	488a      	ldr	r0, [pc, #552]	; (c0d052ac <show+0x8ac>)
c0d05084:	4478      	add	r0, pc
c0d05086:	6330      	str	r0, [r6, #48]	; 0x30
c0d05088:	2064      	movs	r0, #100	; 0x64
c0d0508a:	2103      	movs	r1, #3
c0d0508c:	5431      	strb	r1, [r6, r0]
c0d0508e:	2500      	movs	r5, #0
c0d05090:	66b5      	str	r5, [r6, #104]	; 0x68
c0d05092:	4630      	mov	r0, r6
c0d05094:	3064      	adds	r0, #100	; 0x64
c0d05096:	f7fe fd1d 	bl	c0d03ad4 <os_ux>
c0d0509a:	4620      	mov	r0, r4
c0d0509c:	f7fe fd98 	bl	c0d03bd0 <os_sched_last_status>
c0d050a0:	66b0      	str	r0, [r6, #104]	; 0x68
c0d050a2:	f7fe f80b 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d050a6:	f7fe f80b 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d050aa:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d050ac:	4620      	mov	r0, r4
c0d050ae:	9c00      	ldr	r4, [sp, #0]
c0d050b0:	f7fe fd8e 	bl	c0d03bd0 <os_sched_last_status>
c0d050b4:	66b0      	str	r0, [r6, #104]	; 0x68
c0d050b6:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d050b8:	2900      	cmp	r1, #0
c0d050ba:	d100      	bne.n	c0d050be <show+0x6be>
c0d050bc:	e0e7      	b.n	c0d0528e <show+0x88e>
c0d050be:	2800      	cmp	r0, #0
c0d050c0:	d100      	bne.n	c0d050c4 <show+0x6c4>
c0d050c2:	e0e4      	b.n	c0d0528e <show+0x88e>
c0d050c4:	2897      	cmp	r0, #151	; 0x97
c0d050c6:	d100      	bne.n	c0d050ca <show+0x6ca>
c0d050c8:	e0e1      	b.n	c0d0528e <show+0x88e>
c0d050ca:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d050cc:	5df1      	ldrb	r1, [r6, r7]
c0d050ce:	b280      	uxth	r0, r0
c0d050d0:	4288      	cmp	r0, r1
c0d050d2:	d300      	bcc.n	c0d050d6 <show+0x6d6>
c0d050d4:	e0db      	b.n	c0d0528e <show+0x88e>
c0d050d6:	f7fe fd47 	bl	c0d03b68 <io_seph_is_status_sent>
c0d050da:	2800      	cmp	r0, #0
c0d050dc:	d000      	beq.n	c0d050e0 <show+0x6e0>
c0d050de:	e0d6      	b.n	c0d0528e <show+0x88e>
c0d050e0:	f7fe fcc2 	bl	c0d03a68 <os_perso_isonboarded>
c0d050e4:	42a0      	cmp	r0, r4
c0d050e6:	d104      	bne.n	c0d050f2 <show+0x6f2>
c0d050e8:	f7fe fce8 	bl	c0d03abc <os_global_pin_is_validated>
c0d050ec:	42a0      	cmp	r0, r4
c0d050ee:	d000      	beq.n	c0d050f2 <show+0x6f2>
c0d050f0:	e0cd      	b.n	c0d0528e <show+0x88e>
c0d050f2:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d050f4:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d050f6:	0149      	lsls	r1, r1, #5
c0d050f8:	1840      	adds	r0, r0, r1
c0d050fa:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d050fc:	2900      	cmp	r1, #0
c0d050fe:	d002      	beq.n	c0d05106 <show+0x706>
c0d05100:	4788      	blx	r1
c0d05102:	2800      	cmp	r0, #0
c0d05104:	d007      	beq.n	c0d05116 <show+0x716>
c0d05106:	2801      	cmp	r0, #1
c0d05108:	d103      	bne.n	c0d05112 <show+0x712>
c0d0510a:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d0510c:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d0510e:	0149      	lsls	r1, r1, #5
c0d05110:	1840      	adds	r0, r0, r1
c0d05112:	f7fb fb47 	bl	c0d007a4 <io_seproxyhal_display>
c0d05116:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d05118:	1c40      	adds	r0, r0, #1
c0d0511a:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d0511c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0511e:	2900      	cmp	r1, #0
c0d05120:	d1d4      	bne.n	c0d050cc <show+0x6cc>
c0d05122:	e0b4      	b.n	c0d0528e <show+0x88e>
                UX_DISPLAY(ui_choose_account_nanos, ui_main_nanos_prepro);
            }

            break;
        case UI_CREATE_ACCOUNT:
            UX_DISPLAY(ui_create_account_nanos, ui_main_nanos_prepro);
c0d05124:	4e5b      	ldr	r6, [pc, #364]	; (c0d05294 <show+0x894>)
c0d05126:	4862      	ldr	r0, [pc, #392]	; (c0d052b0 <show+0x8b0>)
c0d05128:	4478      	add	r0, pc
c0d0512a:	62b0      	str	r0, [r6, #40]	; 0x28
c0d0512c:	272c      	movs	r7, #44	; 0x2c
c0d0512e:	2005      	movs	r0, #5
c0d05130:	55f0      	strb	r0, [r6, r7]
c0d05132:	4860      	ldr	r0, [pc, #384]	; (c0d052b4 <show+0x8b4>)
c0d05134:	4478      	add	r0, pc
c0d05136:	6370      	str	r0, [r6, #52]	; 0x34
c0d05138:	485f      	ldr	r0, [pc, #380]	; (c0d052b8 <show+0x8b8>)
c0d0513a:	4478      	add	r0, pc
c0d0513c:	6330      	str	r0, [r6, #48]	; 0x30
c0d0513e:	2064      	movs	r0, #100	; 0x64
c0d05140:	2103      	movs	r1, #3
c0d05142:	5431      	strb	r1, [r6, r0]
c0d05144:	2500      	movs	r5, #0
c0d05146:	66b5      	str	r5, [r6, #104]	; 0x68
c0d05148:	4630      	mov	r0, r6
c0d0514a:	3064      	adds	r0, #100	; 0x64
c0d0514c:	f7fe fcc2 	bl	c0d03ad4 <os_ux>
c0d05150:	2404      	movs	r4, #4
c0d05152:	4620      	mov	r0, r4
c0d05154:	f7fe fd3c 	bl	c0d03bd0 <os_sched_last_status>
c0d05158:	66b0      	str	r0, [r6, #104]	; 0x68
c0d0515a:	f7fd ffaf 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d0515e:	f7fd ffaf 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d05162:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d05164:	4620      	mov	r0, r4
c0d05166:	9c00      	ldr	r4, [sp, #0]
c0d05168:	f7fe fd32 	bl	c0d03bd0 <os_sched_last_status>
c0d0516c:	66b0      	str	r0, [r6, #104]	; 0x68
c0d0516e:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d05170:	2900      	cmp	r1, #0
c0d05172:	d100      	bne.n	c0d05176 <show+0x776>
c0d05174:	e08b      	b.n	c0d0528e <show+0x88e>
c0d05176:	2800      	cmp	r0, #0
c0d05178:	d100      	bne.n	c0d0517c <show+0x77c>
c0d0517a:	e088      	b.n	c0d0528e <show+0x88e>
c0d0517c:	2897      	cmp	r0, #151	; 0x97
c0d0517e:	d100      	bne.n	c0d05182 <show+0x782>
c0d05180:	e085      	b.n	c0d0528e <show+0x88e>
c0d05182:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d05184:	5df1      	ldrb	r1, [r6, r7]
c0d05186:	b280      	uxth	r0, r0
c0d05188:	4288      	cmp	r0, r1
c0d0518a:	d300      	bcc.n	c0d0518e <show+0x78e>
c0d0518c:	e07f      	b.n	c0d0528e <show+0x88e>
c0d0518e:	f7fe fceb 	bl	c0d03b68 <io_seph_is_status_sent>
c0d05192:	2800      	cmp	r0, #0
c0d05194:	d17b      	bne.n	c0d0528e <show+0x88e>
c0d05196:	f7fe fc67 	bl	c0d03a68 <os_perso_isonboarded>
c0d0519a:	42a0      	cmp	r0, r4
c0d0519c:	d103      	bne.n	c0d051a6 <show+0x7a6>
c0d0519e:	f7fe fc8d 	bl	c0d03abc <os_global_pin_is_validated>
c0d051a2:	42a0      	cmp	r0, r4
c0d051a4:	d173      	bne.n	c0d0528e <show+0x88e>
c0d051a6:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d051a8:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d051aa:	0149      	lsls	r1, r1, #5
c0d051ac:	1840      	adds	r0, r0, r1
c0d051ae:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d051b0:	2900      	cmp	r1, #0
c0d051b2:	d002      	beq.n	c0d051ba <show+0x7ba>
c0d051b4:	4788      	blx	r1
c0d051b6:	2800      	cmp	r0, #0
c0d051b8:	d007      	beq.n	c0d051ca <show+0x7ca>
c0d051ba:	2801      	cmp	r0, #1
c0d051bc:	d103      	bne.n	c0d051c6 <show+0x7c6>
c0d051be:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d051c0:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d051c2:	0149      	lsls	r1, r1, #5
c0d051c4:	1840      	adds	r0, r0, r1
c0d051c6:	f7fb faed 	bl	c0d007a4 <io_seproxyhal_display>
c0d051ca:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d051cc:	1c40      	adds	r0, r0, #1
c0d051ce:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d051d0:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d051d2:	2900      	cmp	r1, #0
c0d051d4:	d1d6      	bne.n	c0d05184 <show+0x784>
c0d051d6:	e05a      	b.n	c0d0528e <show+0x88e>
c0d051d8:	20001e70 	.word	0x20001e70
c0d051dc:	000027dc 	.word	0x000027dc
c0d051e0:	00000709 	.word	0x00000709
c0d051e4:	00000667 	.word	0x00000667
            UX_DISPLAY(ui_main_create_account_nanos, ui_main_nanos_prepro);
            break;
        case UI_CHOOSE_ACCOUNT:

            if(selected_account == 0){
                UX_DISPLAY(ui_choose_account_zero_nanos, ui_main_nanos_prepro);
c0d051e8:	482b      	ldr	r0, [pc, #172]	; (c0d05298 <show+0x898>)
c0d051ea:	4478      	add	r0, pc
c0d051ec:	62b0      	str	r0, [r6, #40]	; 0x28
c0d051ee:	272c      	movs	r7, #44	; 0x2c
c0d051f0:	2404      	movs	r4, #4
c0d051f2:	55f4      	strb	r4, [r6, r7]
c0d051f4:	4829      	ldr	r0, [pc, #164]	; (c0d0529c <show+0x89c>)
c0d051f6:	4478      	add	r0, pc
c0d051f8:	6370      	str	r0, [r6, #52]	; 0x34
c0d051fa:	4829      	ldr	r0, [pc, #164]	; (c0d052a0 <show+0x8a0>)
c0d051fc:	4478      	add	r0, pc
c0d051fe:	6330      	str	r0, [r6, #48]	; 0x30
c0d05200:	2064      	movs	r0, #100	; 0x64
c0d05202:	2103      	movs	r1, #3
c0d05204:	5431      	strb	r1, [r6, r0]
c0d05206:	2500      	movs	r5, #0
c0d05208:	66b5      	str	r5, [r6, #104]	; 0x68
c0d0520a:	4630      	mov	r0, r6
c0d0520c:	3064      	adds	r0, #100	; 0x64
c0d0520e:	f7fe fc61 	bl	c0d03ad4 <os_ux>
c0d05212:	4620      	mov	r0, r4
c0d05214:	f7fe fcdc 	bl	c0d03bd0 <os_sched_last_status>
c0d05218:	66b0      	str	r0, [r6, #104]	; 0x68
c0d0521a:	f7fd ff4f 	bl	c0d030bc <io_seproxyhal_init_ux>
c0d0521e:	f7fd ff4f 	bl	c0d030c0 <io_seproxyhal_init_button>
c0d05222:	84f5      	strh	r5, [r6, #38]	; 0x26
c0d05224:	4620      	mov	r0, r4
c0d05226:	f7fe fcd3 	bl	c0d03bd0 <os_sched_last_status>
c0d0522a:	66b0      	str	r0, [r6, #104]	; 0x68
c0d0522c:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0522e:	2900      	cmp	r1, #0
c0d05230:	9c00      	ldr	r4, [sp, #0]
c0d05232:	d02c      	beq.n	c0d0528e <show+0x88e>
c0d05234:	2800      	cmp	r0, #0
c0d05236:	d02a      	beq.n	c0d0528e <show+0x88e>
c0d05238:	2897      	cmp	r0, #151	; 0x97
c0d0523a:	d028      	beq.n	c0d0528e <show+0x88e>
c0d0523c:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d0523e:	5df1      	ldrb	r1, [r6, r7]
c0d05240:	b280      	uxth	r0, r0
c0d05242:	4288      	cmp	r0, r1
c0d05244:	d223      	bcs.n	c0d0528e <show+0x88e>
c0d05246:	f7fe fc8f 	bl	c0d03b68 <io_seph_is_status_sent>
c0d0524a:	2800      	cmp	r0, #0
c0d0524c:	d11f      	bne.n	c0d0528e <show+0x88e>
c0d0524e:	f7fe fc0b 	bl	c0d03a68 <os_perso_isonboarded>
c0d05252:	42a0      	cmp	r0, r4
c0d05254:	d103      	bne.n	c0d0525e <show+0x85e>
c0d05256:	f7fe fc31 	bl	c0d03abc <os_global_pin_is_validated>
c0d0525a:	42a0      	cmp	r0, r4
c0d0525c:	d117      	bne.n	c0d0528e <show+0x88e>
c0d0525e:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d05260:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d05262:	0149      	lsls	r1, r1, #5
c0d05264:	1840      	adds	r0, r0, r1
c0d05266:	6b31      	ldr	r1, [r6, #48]	; 0x30
c0d05268:	2900      	cmp	r1, #0
c0d0526a:	d002      	beq.n	c0d05272 <show+0x872>
c0d0526c:	4788      	blx	r1
c0d0526e:	2800      	cmp	r0, #0
c0d05270:	d007      	beq.n	c0d05282 <show+0x882>
c0d05272:	2801      	cmp	r0, #1
c0d05274:	d103      	bne.n	c0d0527e <show+0x87e>
c0d05276:	6ab0      	ldr	r0, [r6, #40]	; 0x28
c0d05278:	8cf1      	ldrh	r1, [r6, #38]	; 0x26
c0d0527a:	0149      	lsls	r1, r1, #5
c0d0527c:	1840      	adds	r0, r0, r1
c0d0527e:	f7fb fa91 	bl	c0d007a4 <io_seproxyhal_display>
c0d05282:	8cf0      	ldrh	r0, [r6, #38]	; 0x26
c0d05284:	1c40      	adds	r0, r0, #1
c0d05286:	84f0      	strh	r0, [r6, #38]	; 0x26
c0d05288:	6ab1      	ldr	r1, [r6, #40]	; 0x28
c0d0528a:	2900      	cmp	r1, #0
c0d0528c:	d1d7      	bne.n	c0d0523e <show+0x83e>
            break;
    }
    
#endif
    
}
c0d0528e:	b001      	add	sp, #4
c0d05290:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d05292:	46c0      	nop			; (mov r8, r8)
c0d05294:	20001e70 	.word	0x20001e70
c0d05298:	0000215a 	.word	0x0000215a
c0d0529c:	000000db 	.word	0x000000db
c0d052a0:	000002c5 	.word	0x000002c5
c0d052a4:	00002112 	.word	0x00002112
c0d052a8:	0000042b 	.word	0x0000042b
c0d052ac:	0000043d 	.word	0x0000043d
c0d052b0:	0000233c 	.word	0x0000233c
c0d052b4:	0000026d 	.word	0x0000026d
c0d052b8:	00000387 	.word	0x00000387
c0d052bc:	00002686 	.word	0x00002686
c0d052c0:	0000053f 	.word	0x0000053f
c0d052c4:	000005b1 	.word	0x000005b1
c0d052c8:	000026ea 	.word	0x000026ea
c0d052cc:	000006d3 	.word	0x000006d3
c0d052d0:	00000839 	.word	0x00000839

c0d052d4 <ui_choose_account_zero_nanos_button>:
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

unsigned int
ui_choose_account_zero_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
c0d052d4:	b5b0      	push	{r4, r5, r7, lr}

    switch (button_mask) {
c0d052d6:	4914      	ldr	r1, [pc, #80]	; (c0d05328 <ui_choose_account_zero_nanos_button+0x54>)
c0d052d8:	4288      	cmp	r0, r1
c0d052da:	d00c      	beq.n	c0d052f6 <ui_choose_account_zero_nanos_button+0x22>
c0d052dc:	4913      	ldr	r1, [pc, #76]	; (c0d0532c <ui_choose_account_zero_nanos_button+0x58>)
c0d052de:	4288      	cmp	r0, r1
c0d052e0:	d00b      	beq.n	c0d052fa <ui_choose_account_zero_nanos_button+0x26>
c0d052e2:	4913      	ldr	r1, [pc, #76]	; (c0d05330 <ui_choose_account_zero_nanos_button+0x5c>)
c0d052e4:	4288      	cmp	r0, r1
c0d052e6:	d11c      	bne.n	c0d05322 <ui_choose_account_zero_nanos_button+0x4e>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:

        if(selected_account > 0){
c0d052e8:	4912      	ldr	r1, [pc, #72]	; (c0d05334 <ui_choose_account_zero_nanos_button+0x60>)
c0d052ea:	6808      	ldr	r0, [r1, #0]
c0d052ec:	2801      	cmp	r0, #1
c0d052ee:	db18      	blt.n	c0d05322 <ui_choose_account_zero_nanos_button+0x4e>
            // show(UI_MAIN);
            selected_account--;
c0d052f0:	1e40      	subs	r0, r0, #1
c0d052f2:	6008      	str	r0, [r1, #0]
c0d052f4:	e00e      	b.n	c0d05314 <ui_choose_account_zero_nanos_button+0x40>
            show(UI_CREATE_ACCOUNT);
        }

        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
c0d052f6:	2000      	movs	r0, #0
c0d052f8:	e011      	b.n	c0d0531e <ui_choose_account_zero_nanos_button+0x4a>
        }
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        // show(UI_MAIN_CREATE_ACCOUNT);

        if(selected_account < N_storage.account_number - 1){
c0d052fa:	4c0e      	ldr	r4, [pc, #56]	; (c0d05334 <ui_choose_account_zero_nanos_button+0x60>)
c0d052fc:	6825      	ldr	r5, [r4, #0]
c0d052fe:	480e      	ldr	r0, [pc, #56]	; (c0d05338 <ui_choose_account_zero_nanos_button+0x64>)
c0d05300:	4478      	add	r0, pc
c0d05302:	f7fe fae7 	bl	c0d038d4 <pic>
c0d05306:	6840      	ldr	r0, [r0, #4]
c0d05308:	1e40      	subs	r0, r0, #1
c0d0530a:	4285      	cmp	r5, r0
c0d0530c:	da06      	bge.n	c0d0531c <ui_choose_account_zero_nanos_button+0x48>
            selected_account++;
c0d0530e:	6820      	ldr	r0, [r4, #0]
c0d05310:	1c40      	adds	r0, r0, #1
c0d05312:	6020      	str	r0, [r4, #0]
c0d05314:	f7fb f82a 	bl	c0d0036c <set_key>
c0d05318:	2004      	movs	r0, #4
c0d0531a:	e000      	b.n	c0d0531e <ui_choose_account_zero_nanos_button+0x4a>
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
        } else {
            show(UI_CREATE_ACCOUNT);
c0d0531c:	2005      	movs	r0, #5
c0d0531e:	f7ff fb6f 	bl	c0d04a00 <show>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
            break;
    }
    return 0;
c0d05322:	2000      	movs	r0, #0
c0d05324:	bdb0      	pop	{r4, r5, r7, pc}
c0d05326:	46c0      	nop			; (mov r8, r8)
c0d05328:	80000003 	.word	0x80000003
c0d0532c:	80000002 	.word	0x80000002
c0d05330:	80000001 	.word	0x80000001
c0d05334:	20001d20 	.word	0x20001d20
c0d05338:	000028fc 	.word	0x000028fc

c0d0533c <ui_choose_account_nanos_button>:
};

unsigned int
ui_choose_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
c0d0533c:	b5b0      	push	{r4, r5, r7, lr}

    switch (button_mask) {
c0d0533e:	4914      	ldr	r1, [pc, #80]	; (c0d05390 <ui_choose_account_nanos_button+0x54>)
c0d05340:	4288      	cmp	r0, r1
c0d05342:	d00c      	beq.n	c0d0535e <ui_choose_account_nanos_button+0x22>
c0d05344:	4913      	ldr	r1, [pc, #76]	; (c0d05394 <ui_choose_account_nanos_button+0x58>)
c0d05346:	4288      	cmp	r0, r1
c0d05348:	d00b      	beq.n	c0d05362 <ui_choose_account_nanos_button+0x26>
c0d0534a:	4913      	ldr	r1, [pc, #76]	; (c0d05398 <ui_choose_account_nanos_button+0x5c>)
c0d0534c:	4288      	cmp	r0, r1
c0d0534e:	d11c      	bne.n	c0d0538a <ui_choose_account_nanos_button+0x4e>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        if(selected_account > 0){
c0d05350:	4912      	ldr	r1, [pc, #72]	; (c0d0539c <ui_choose_account_nanos_button+0x60>)
c0d05352:	6808      	ldr	r0, [r1, #0]
c0d05354:	2801      	cmp	r0, #1
c0d05356:	db18      	blt.n	c0d0538a <ui_choose_account_nanos_button+0x4e>
            // show(UI_MAIN);
            selected_account--;
c0d05358:	1e40      	subs	r0, r0, #1
c0d0535a:	6008      	str	r0, [r1, #0]
c0d0535c:	e00e      	b.n	c0d0537c <ui_choose_account_nanos_button+0x40>
            show(UI_CREATE_ACCOUNT);
        }

        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
c0d0535e:	2000      	movs	r0, #0
c0d05360:	e011      	b.n	c0d05386 <ui_choose_account_nanos_button+0x4a>
        }
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        // show(UI_MAIN_CREATE_ACCOUNT);

        if(selected_account < N_storage.account_number - 1){
c0d05362:	4c0e      	ldr	r4, [pc, #56]	; (c0d0539c <ui_choose_account_nanos_button+0x60>)
c0d05364:	6825      	ldr	r5, [r4, #0]
c0d05366:	480e      	ldr	r0, [pc, #56]	; (c0d053a0 <ui_choose_account_nanos_button+0x64>)
c0d05368:	4478      	add	r0, pc
c0d0536a:	f7fe fab3 	bl	c0d038d4 <pic>
c0d0536e:	6840      	ldr	r0, [r0, #4]
c0d05370:	1e40      	subs	r0, r0, #1
c0d05372:	4285      	cmp	r5, r0
c0d05374:	da06      	bge.n	c0d05384 <ui_choose_account_nanos_button+0x48>
            selected_account++;
c0d05376:	6820      	ldr	r0, [r4, #0]
c0d05378:	1c40      	adds	r0, r0, #1
c0d0537a:	6020      	str	r0, [r4, #0]
c0d0537c:	f7fa fff6 	bl	c0d0036c <set_key>
c0d05380:	2004      	movs	r0, #4
c0d05382:	e000      	b.n	c0d05386 <ui_choose_account_nanos_button+0x4a>
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
        } else {
            show(UI_CREATE_ACCOUNT);
c0d05384:	2005      	movs	r0, #5
c0d05386:	f7ff fb3b 	bl	c0d04a00 <show>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
            break;
    }
    return 0;
c0d0538a:	2000      	movs	r0, #0
c0d0538c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0538e:	46c0      	nop			; (mov r8, r8)
c0d05390:	80000003 	.word	0x80000003
c0d05394:	80000002 	.word	0x80000002
c0d05398:	80000001 	.word	0x80000001
c0d0539c:	20001d20 	.word	0x20001d20
c0d053a0:	00002894 	.word	0x00002894

c0d053a4 <ui_create_account_nanos_button>:
};

unsigned int
ui_create_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
c0d053a4:	b510      	push	{r4, lr}
c0d053a6:	b082      	sub	sp, #8

    int x;
    switch (button_mask) {
c0d053a8:	4919      	ldr	r1, [pc, #100]	; (c0d05410 <ui_create_account_nanos_button+0x6c>)
c0d053aa:	4288      	cmp	r0, r1
c0d053ac:	d011      	beq.n	c0d053d2 <ui_create_account_nanos_button+0x2e>
c0d053ae:	4919      	ldr	r1, [pc, #100]	; (c0d05414 <ui_create_account_nanos_button+0x70>)
c0d053b0:	4288      	cmp	r0, r1
c0d053b2:	d027      	beq.n	c0d05404 <ui_create_account_nanos_button+0x60>
c0d053b4:	4918      	ldr	r1, [pc, #96]	; (c0d05418 <ui_create_account_nanos_button+0x74>)
c0d053b6:	4288      	cmp	r0, r1
c0d053b8:	d127      	bne.n	c0d0540a <ui_create_account_nanos_button+0x66>
        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            selected_account = N_storage.account_number - 1;
c0d053ba:	4819      	ldr	r0, [pc, #100]	; (c0d05420 <ui_create_account_nanos_button+0x7c>)
c0d053bc:	4478      	add	r0, pc
c0d053be:	f7fe fa89 	bl	c0d038d4 <pic>
c0d053c2:	6840      	ldr	r0, [r0, #4]
c0d053c4:	1e40      	subs	r0, r0, #1
c0d053c6:	4915      	ldr	r1, [pc, #84]	; (c0d0541c <ui_create_account_nanos_button+0x78>)
c0d053c8:	6008      	str	r0, [r1, #0]
            set_key(selected_account);
c0d053ca:	f7fa ffcf 	bl	c0d0036c <set_key>
c0d053ce:	2004      	movs	r0, #4
c0d053d0:	e019      	b.n	c0d05406 <ui_create_account_nanos_button+0x62>
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            show(UI_ACCOUNT_BACK);
            break;
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            
            x = N_storage.account_number + 1;
c0d053d2:	4c14      	ldr	r4, [pc, #80]	; (c0d05424 <ui_create_account_nanos_button+0x80>)
c0d053d4:	447c      	add	r4, pc
c0d053d6:	4620      	mov	r0, r4
c0d053d8:	f7fe fa7c 	bl	c0d038d4 <pic>
c0d053dc:	6840      	ldr	r0, [r0, #4]
c0d053de:	1c40      	adds	r0, r0, #1
c0d053e0:	9001      	str	r0, [sp, #4]
            nvm_write(&N_storage.account_number, (void*)&x, sizeof(int));
c0d053e2:	4620      	mov	r0, r4
c0d053e4:	f7fe fa76 	bl	c0d038d4 <pic>
c0d053e8:	1d00      	adds	r0, r0, #4
c0d053ea:	a901      	add	r1, sp, #4
c0d053ec:	2404      	movs	r4, #4
c0d053ee:	4622      	mov	r2, r4
c0d053f0:	f7fe fa9e 	bl	c0d03930 <nvm_write>
            selected_account++;
c0d053f4:	4909      	ldr	r1, [pc, #36]	; (c0d0541c <ui_create_account_nanos_button+0x78>)
c0d053f6:	6808      	ldr	r0, [r1, #0]
c0d053f8:	1c40      	adds	r0, r0, #1
c0d053fa:	6008      	str	r0, [r1, #0]
            set_key(selected_account);
c0d053fc:	f7fa ffb6 	bl	c0d0036c <set_key>

            show(UI_CHOOSE_ACCOUNT);
c0d05400:	4620      	mov	r0, r4
c0d05402:	e000      	b.n	c0d05406 <ui_create_account_nanos_button+0x62>
            set_key(selected_account);
            show(UI_CHOOSE_ACCOUNT);
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            show(UI_ACCOUNT_BACK);
c0d05404:	2006      	movs	r0, #6
c0d05406:	f7ff fafb 	bl	c0d04a00 <show>
            show(UI_CHOOSE_ACCOUNT);

            break;
    }

    return 0;
c0d0540a:	2000      	movs	r0, #0
c0d0540c:	b002      	add	sp, #8
c0d0540e:	bd10      	pop	{r4, pc}
c0d05410:	80000003 	.word	0x80000003
c0d05414:	80000002 	.word	0x80000002
c0d05418:	80000001 	.word	0x80000001
c0d0541c:	20001d20 	.word	0x20001d20
c0d05420:	00002840 	.word	0x00002840
c0d05424:	00002828 	.word	0x00002828

c0d05428 <ui_account_back_nanos_button>:
};


unsigned int
ui_account_back_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
c0d05428:	b580      	push	{r7, lr}

    switch (button_mask) {
c0d0542a:	4906      	ldr	r1, [pc, #24]	; (c0d05444 <ui_account_back_nanos_button+0x1c>)
c0d0542c:	4288      	cmp	r0, r1
c0d0542e:	d004      	beq.n	c0d0543a <ui_account_back_nanos_button+0x12>
c0d05430:	4905      	ldr	r1, [pc, #20]	; (c0d05448 <ui_account_back_nanos_button+0x20>)
c0d05432:	4288      	cmp	r0, r1
c0d05434:	d104      	bne.n	c0d05440 <ui_account_back_nanos_button+0x18>
        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            show(UI_CREATE_ACCOUNT);
c0d05436:	2005      	movs	r0, #5
c0d05438:	e000      	b.n	c0d0543c <ui_account_back_nanos_button+0x14>
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
            show(UI_MAIN);
c0d0543a:	2000      	movs	r0, #0
c0d0543c:	f7ff fae0 	bl	c0d04a00 <show>
            break;
    }

    return 0;
c0d05440:	2000      	movs	r0, #0
c0d05442:	bd80      	pop	{r7, pc}
c0d05444:	80000003 	.word	0x80000003
c0d05448:	80000001 	.word	0x80000001

c0d0544c <ui_confirm_account_nanos_button>:
};

unsigned int
ui_confirm_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
c0d0544c:	b510      	push	{r4, lr}
#include "context.h"

const bagl_element_t *sync_finished() {
    
    G_io_apdu_buffer[0] = 0x90;
c0d0544e:	2490      	movs	r4, #144	; 0x90
};

unsigned int
ui_confirm_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter){
    switch (button_mask) {
c0d05450:	4911      	ldr	r1, [pc, #68]	; (c0d05498 <ui_confirm_account_nanos_button+0x4c>)
c0d05452:	4288      	cmp	r0, r1
c0d05454:	d00f      	beq.n	c0d05476 <ui_confirm_account_nanos_button+0x2a>
c0d05456:	4911      	ldr	r1, [pc, #68]	; (c0d0549c <ui_confirm_account_nanos_button+0x50>)
c0d05458:	4288      	cmp	r0, r1
c0d0545a:	d11b      	bne.n	c0d05494 <ui_confirm_account_nanos_button+0x48>
        case BUTTON_EVT_RELEASED | BUTTON_LEFT:
            set_key(selected_account);
c0d0545c:	4811      	ldr	r0, [pc, #68]	; (c0d054a4 <ui_confirm_account_nanos_button+0x58>)
c0d0545e:	6800      	ldr	r0, [r0, #0]
c0d05460:	f7fa ff84 	bl	c0d0036c <set_key>
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

const bagl_element_t *sync_cancel() {
    
    G_io_apdu_buffer[0] = 0x90;
c0d05464:	4910      	ldr	r1, [pc, #64]	; (c0d054a8 <ui_confirm_account_nanos_button+0x5c>)
c0d05466:	700c      	strb	r4, [r1, #0]
c0d05468:	2020      	movs	r0, #32
    G_io_apdu_buffer[1] = 0x20;
c0d0546a:	7048      	strb	r0, [r1, #1]
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d0546c:	2102      	movs	r1, #2
c0d0546e:	f7fd ff5b 	bl	c0d03328 <io_exchange>
c0d05472:	2000      	movs	r0, #0
c0d05474:	e00c      	b.n	c0d05490 <ui_confirm_account_nanos_button+0x44>
            sync_cancel();
            show(UI_MAIN);
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            selected_account = confirm_account;
c0d05476:	480a      	ldr	r0, [pc, #40]	; (c0d054a0 <ui_confirm_account_nanos_button+0x54>)
c0d05478:	6800      	ldr	r0, [r0, #0]
c0d0547a:	490a      	ldr	r1, [pc, #40]	; (c0d054a4 <ui_confirm_account_nanos_button+0x58>)
c0d0547c:	6008      	str	r0, [r1, #0]
#include "context.h"

const bagl_element_t *sync_finished() {
    
    G_io_apdu_buffer[0] = 0x90;
c0d0547e:	480a      	ldr	r0, [pc, #40]	; (c0d054a8 <ui_confirm_account_nanos_button+0x5c>)
c0d05480:	7004      	strb	r4, [r0, #0]
c0d05482:	2400      	movs	r4, #0
    G_io_apdu_buffer[1] = 0x00;
c0d05484:	7044      	strb	r4, [r0, #1]
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d05486:	2020      	movs	r0, #32
c0d05488:	2102      	movs	r1, #2
c0d0548a:	f7fd ff4d 	bl	c0d03328 <io_exchange>
            break;
        
        case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
            selected_account = confirm_account;
            sync_finished();
            show(UI_MAIN);
c0d0548e:	4620      	mov	r0, r4
c0d05490:	f7ff fab6 	bl	c0d04a00 <show>
            break;
    }

    return 0;
c0d05494:	2000      	movs	r0, #0
c0d05496:	bd10      	pop	{r4, pc}
c0d05498:	80000002 	.word	0x80000002
c0d0549c:	80000001 	.word	0x80000001
c0d054a0:	20001d18 	.word	0x20001d18
c0d054a4:	20001d20 	.word	0x20001d20
c0d054a8:	20001fbc 	.word	0x20001fbc

c0d054ac <ui_main_nanos_button>:
#include "context.h"

unsigned int
ui_main_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
c0d054ac:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d054ae:	4904      	ldr	r1, [pc, #16]	; (c0d054c0 <ui_main_nanos_button+0x14>)
c0d054b0:	4288      	cmp	r0, r1
c0d054b2:	d102      	bne.n	c0d054ba <ui_main_nanos_button+0xe>
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_CHOOSE_ACCOUNT);
c0d054b4:	2001      	movs	r0, #1
c0d054b6:	f7ff faa3 	bl	c0d04a00 <show>
        break;
    }

    return 0;
c0d054ba:	2000      	movs	r0, #0
c0d054bc:	bd80      	pop	{r7, pc}
c0d054be:	46c0      	nop			; (mov r8, r8)
c0d054c0:	80000002 	.word	0x80000002

c0d054c4 <ui_main_nanos_prepro>:
};

const bagl_element_t*
ui_main_nanos_prepro(const bagl_element_t *element) {
c0d054c4:	b5b0      	push	{r4, r5, r7, lr}
c0d054c6:	4604      	mov	r4, r0
    switch (element->component.userid) {
c0d054c8:	7860      	ldrb	r0, [r4, #1]
c0d054ca:	2802      	cmp	r0, #2
c0d054cc:	d110      	bne.n	c0d054f0 <ui_main_nanos_prepro+0x2c>
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
c0d054ce:	2107      	movs	r1, #7
c0d054d0:	4620      	mov	r0, r4
c0d054d2:	f7fd fe93 	bl	c0d031fc <bagl_label_roundtrip_duration_ms>
c0d054d6:	217d      	movs	r1, #125	; 0x7d
c0d054d8:	00cd      	lsls	r5, r1, #3
c0d054da:	1941      	adds	r1, r0, r5
c0d054dc:	4805      	ldr	r0, [pc, #20]	; (c0d054f4 <ui_main_nanos_prepro+0x30>)
c0d054de:	4281      	cmp	r1, r0
c0d054e0:	d304      	bcc.n	c0d054ec <ui_main_nanos_prepro+0x28>
c0d054e2:	2107      	movs	r1, #7
c0d054e4:	4620      	mov	r0, r4
c0d054e6:	f7fd fe89 	bl	c0d031fc <bagl_label_roundtrip_duration_ms>
c0d054ea:	1940      	adds	r0, r0, r5

const bagl_element_t*
ui_main_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
c0d054ec:	f7fd fee6 	bl	c0d032bc <io_seproxyhal_setup_ticker>
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
c0d054f0:	4620      	mov	r0, r4
c0d054f2:	bdb0      	pop	{r4, r5, r7, pc}
c0d054f4:	00000bb8 	.word	0x00000bb8

c0d054f8 <ui_main_choose_account_nanos_button>:
}

unsigned int
ui_main_choose_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
c0d054f8:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d054fa:	4909      	ldr	r1, [pc, #36]	; (c0d05520 <ui_main_choose_account_nanos_button+0x28>)
c0d054fc:	4288      	cmp	r0, r1
c0d054fe:	d007      	beq.n	c0d05510 <ui_main_choose_account_nanos_button+0x18>
c0d05500:	4908      	ldr	r1, [pc, #32]	; (c0d05524 <ui_main_choose_account_nanos_button+0x2c>)
c0d05502:	4288      	cmp	r0, r1
c0d05504:	d006      	beq.n	c0d05514 <ui_main_choose_account_nanos_button+0x1c>
c0d05506:	4908      	ldr	r1, [pc, #32]	; (c0d05528 <ui_main_choose_account_nanos_button+0x30>)
c0d05508:	4288      	cmp	r0, r1
c0d0550a:	d106      	bne.n	c0d0551a <ui_main_choose_account_nanos_button+0x22>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN);
c0d0550c:	2000      	movs	r0, #0
c0d0550e:	e002      	b.n	c0d05516 <ui_main_choose_account_nanos_button+0x1e>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_CREATE_ACCOUNT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        show(UI_CHOOSE_ACCOUNT);
c0d05510:	2004      	movs	r0, #4
c0d05512:	e000      	b.n	c0d05516 <ui_main_choose_account_nanos_button+0x1e>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_CREATE_ACCOUNT);
c0d05514:	2002      	movs	r0, #2
c0d05516:	f7ff fa73 	bl	c0d04a00 <show>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        show(UI_CHOOSE_ACCOUNT);
        break;
    }
    return 0;
c0d0551a:	2000      	movs	r0, #0
c0d0551c:	bd80      	pop	{r7, pc}
c0d0551e:	46c0      	nop			; (mov r8, r8)
c0d05520:	80000003 	.word	0x80000003
c0d05524:	80000002 	.word	0x80000002
c0d05528:	80000001 	.word	0x80000001

c0d0552c <ui_main_create_account_nanos_button>:
    return element;
};

unsigned int
ui_main_create_account_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
c0d0552c:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d0552e:	4909      	ldr	r1, [pc, #36]	; (c0d05554 <ui_main_create_account_nanos_button+0x28>)
c0d05530:	4288      	cmp	r0, r1
c0d05532:	d007      	beq.n	c0d05544 <ui_main_create_account_nanos_button+0x18>
c0d05534:	4908      	ldr	r1, [pc, #32]	; (c0d05558 <ui_main_create_account_nanos_button+0x2c>)
c0d05536:	4288      	cmp	r0, r1
c0d05538:	d006      	beq.n	c0d05548 <ui_main_create_account_nanos_button+0x1c>
c0d0553a:	4908      	ldr	r1, [pc, #32]	; (c0d0555c <ui_main_create_account_nanos_button+0x30>)
c0d0553c:	4288      	cmp	r0, r1
c0d0553e:	d106      	bne.n	c0d0554e <ui_main_create_account_nanos_button+0x22>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN_CHOOSE_ACCOUNT);
c0d05540:	2001      	movs	r0, #1
c0d05542:	e002      	b.n	c0d0554a <ui_main_create_account_nanos_button+0x1e>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_EXIT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        show(UI_CREATE_ACCOUNT);
c0d05544:	2005      	movs	r0, #5
c0d05546:	e000      	b.n	c0d0554a <ui_main_create_account_nanos_button+0x1e>
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN_CHOOSE_ACCOUNT);
        break;
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        show(UI_MAIN_EXIT);
c0d05548:	2003      	movs	r0, #3
c0d0554a:	f7ff fa59 	bl	c0d04a00 <show>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        show(UI_CREATE_ACCOUNT);
        break;
    }
    return 0;
c0d0554e:	2000      	movs	r0, #0
c0d05550:	bd80      	pop	{r7, pc}
c0d05552:	46c0      	nop			; (mov r8, r8)
c0d05554:	80000003 	.word	0x80000003
c0d05558:	80000002 	.word	0x80000002
c0d0555c:	80000001 	.word	0x80000001

c0d05560 <ui_main_exit_nanos_button>:
    return element;
};

unsigned int
ui_main_exit_nanos_button(unsigned int button_mask,
                    unsigned int button_mask_counter) {
c0d05560:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d05562:	4907      	ldr	r1, [pc, #28]	; (c0d05580 <ui_main_exit_nanos_button+0x20>)
c0d05564:	4288      	cmp	r0, r1
c0d05566:	d006      	beq.n	c0d05576 <ui_main_exit_nanos_button+0x16>
c0d05568:	4906      	ldr	r1, [pc, #24]	; (c0d05584 <ui_main_exit_nanos_button+0x24>)
c0d0556a:	4288      	cmp	r0, r1
c0d0556c:	d106      	bne.n	c0d0557c <ui_main_exit_nanos_button+0x1c>
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        show(UI_MAIN_CREATE_ACCOUNT);
c0d0556e:	2002      	movs	r0, #2
c0d05570:	f7ff fa46 	bl	c0d04a00 <show>
c0d05574:	e002      	b.n	c0d0557c <ui_main_exit_nanos_button+0x1c>
    return element;
};

const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d05576:	2000      	movs	r0, #0
c0d05578:	f7fe fade 	bl	c0d03b38 <os_sched_exit>
        break;
    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT:
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d0557c:	2000      	movs	r0, #0
c0d0557e:	bd80      	pop	{r7, pc}
c0d05580:	80000003 	.word	0x80000003
c0d05584:	80000001 	.word	0x80000001

c0d05588 <clean_tx>:

transaction tx = {NULL,NULL,NULL,{NULL,NULL},NULL,NULL,NULL,NULL,NULL,NULL};
unsigned int current_text_pos; // parsing cursor in the text to display
static unsigned int text_y;           // current location of the displayed text

void clean_tx(){
c0d05588:	b580      	push	{r7, lr}
    current_text_pos = 0;
c0d0558a:	4804      	ldr	r0, [pc, #16]	; (c0d0559c <clean_tx+0x14>)
c0d0558c:	2100      	movs	r1, #0
c0d0558e:	6001      	str	r1, [r0, #0]
    text_y = 60;
    for(int i = 0; i < all_data_size; i++){
        all_data[i] = 0;
c0d05590:	206b      	movs	r0, #107	; 0x6b
c0d05592:	00c1      	lsls	r1, r0, #3
c0d05594:	4802      	ldr	r0, [pc, #8]	; (c0d055a0 <clean_tx+0x18>)
c0d05596:	f001 fc45 	bl	c0d06e24 <__aeabi_memclr>
    }
}
c0d0559a:	bd80      	pop	{r7, pc}
c0d0559c:	2000222c 	.word	0x2000222c
c0d055a0:	20001800 	.word	0x20001800

c0d055a4 <display_tx_pre_part>:
    G_io_apdu_buffer[1] = 0x00;
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
}

unsigned char display_tx_pre_part(){
c0d055a4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d055a6:	b081      	sub	sp, #4

    unsigned int i = 0;
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
c0d055a8:	4911      	ldr	r1, [pc, #68]	; (c0d055f0 <display_tx_pre_part+0x4c>)
c0d055aa:	794a      	ldrb	r2, [r1, #5]
c0d055ac:	2000      	movs	r0, #0
c0d055ae:	2a00      	cmp	r2, #0
c0d055b0:	d01c      	beq.n	c0d055ec <display_tx_pre_part+0x48>
c0d055b2:	2000      	movs	r0, #0
c0d055b4:	4b0f      	ldr	r3, [pc, #60]	; (c0d055f4 <display_tx_pre_part+0x50>)
c0d055b6:	4c10      	ldr	r4, [pc, #64]	; (c0d055f8 <display_tx_pre_part+0x54>)
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
c0d055b8:	2863      	cmp	r0, #99	; 0x63
c0d055ba:	d80e      	bhi.n	c0d055da <display_tx_pre_part+0x36>
c0d055bc:	b2d5      	uxtb	r5, r2
c0d055be:	2d0a      	cmp	r5, #10
c0d055c0:	d00b      	beq.n	c0d055da <display_tx_pre_part+0x36>
c0d055c2:	681d      	ldr	r5, [r3, #0]
c0d055c4:	0a6e      	lsrs	r6, r5, #9
c0d055c6:	d108      	bne.n	c0d055da <display_tx_pre_part+0x36>
        sign_tx[current_text_pos++] = text[i];
c0d055c8:	6826      	ldr	r6, [r4, #0]
c0d055ca:	1c6f      	adds	r7, r5, #1
c0d055cc:	601f      	str	r7, [r3, #0]
c0d055ce:	5572      	strb	r2, [r6, r5]
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
c0d055d0:	180a      	adds	r2, r1, r0
c0d055d2:	7992      	ldrb	r2, [r2, #6]
        sign_tx[current_text_pos++] = text[i];
        i++;
c0d055d4:	1c40      	adds	r0, r0, #1
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
c0d055d6:	2a00      	cmp	r2, #0
c0d055d8:	d1ee      	bne.n	c0d055b8 <display_tx_pre_part+0x14>
    }
}

const bagl_element_t *tx_pre_data_got() {
    
    G_io_apdu_buffer[0] = 0x90;
c0d055da:	2090      	movs	r0, #144	; 0x90
c0d055dc:	7008      	strb	r0, [r1, #0]
    G_io_apdu_buffer[1] = 0x00;
c0d055de:	2000      	movs	r0, #0
c0d055e0:	7048      	strb	r0, [r1, #1]
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, 2);
c0d055e2:	2020      	movs	r0, #32
c0d055e4:	2102      	movs	r1, #2
c0d055e6:	f7fd fe9f 	bl	c0d03328 <io_exchange>
c0d055ea:	2001      	movs	r0, #1
    //     i++;
    // }

    tx_pre_data_got(current_text_pos);
    return 1;
}
c0d055ec:	b001      	add	sp, #4
c0d055ee:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d055f0:	20001fbc 	.word	0x20001fbc
c0d055f4:	2000222c 	.word	0x2000222c
c0d055f8:	20001d1c 	.word	0x20001d1c

c0d055fc <display_tx_part>:

// Pick the text elements to display
unsigned char display_tx_part() {
c0d055fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d055fe:	b081      	sub	sp, #4
    unsigned int i = 0;
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
c0d05600:	4820      	ldr	r0, [pc, #128]	; (c0d05684 <display_tx_part+0x88>)
c0d05602:	7943      	ldrb	r3, [r0, #5]
c0d05604:	2000      	movs	r0, #0
c0d05606:	2b00      	cmp	r3, #0
c0d05608:	d03a      	beq.n	c0d05680 <display_tx_part+0x84>
c0d0560a:	2001      	movs	r0, #1
c0d0560c:	9000      	str	r0, [sp, #0]
c0d0560e:	0240      	lsls	r0, r0, #9
c0d05610:	2600      	movs	r6, #0
c0d05612:	4d1d      	ldr	r5, [pc, #116]	; (c0d05688 <display_tx_part+0x8c>)
c0d05614:	4f1d      	ldr	r7, [pc, #116]	; (c0d0568c <display_tx_part+0x90>)
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
c0d05616:	6829      	ldr	r1, [r5, #0]
c0d05618:	2e63      	cmp	r6, #99	; 0x63
c0d0561a:	d80f      	bhi.n	c0d0563c <display_tx_part+0x40>
c0d0561c:	b2dc      	uxtb	r4, r3
c0d0561e:	2c0a      	cmp	r4, #10
c0d05620:	d00c      	beq.n	c0d0563c <display_tx_part+0x40>
c0d05622:	4281      	cmp	r1, r0
c0d05624:	d20a      	bcs.n	c0d0563c <display_tx_part+0x40>
        sign_tx[current_text_pos++] = text[i];
c0d05626:	683c      	ldr	r4, [r7, #0]
c0d05628:	1c4a      	adds	r2, r1, #1
c0d0562a:	602a      	str	r2, [r5, #0]
c0d0562c:	5463      	strb	r3, [r4, r1]
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
c0d0562e:	4915      	ldr	r1, [pc, #84]	; (c0d05684 <display_tx_part+0x88>)
c0d05630:	1989      	adds	r1, r1, r6
c0d05632:	798b      	ldrb	r3, [r1, #6]
        sign_tx[current_text_pos++] = text[i];
        i++;
c0d05634:	1c76      	adds	r6, r6, #1
    WIDE char *text = (char*) G_io_apdu_buffer + 5;
    if (text[i] == '\0') {
        return 0;
    }
    i = 0;
    while ((text[i] != 0) && (text[i] != '\n') && i < MAX_CHARS_PER_LINE && current_text_pos < 512) {
c0d05636:	2b00      	cmp	r3, #0
c0d05638:	d1ed      	bne.n	c0d05616 <display_tx_part+0x1a>
        sign_tx[current_text_pos++] = text[i];
        i++;
    }

    int ml = cache_data_p - current_text_pos;
c0d0563a:	6829      	ldr	r1, [r5, #0]
c0d0563c:	3058      	adds	r0, #88	; 0x58
c0d0563e:	1a43      	subs	r3, r0, r1
    for(int m = current_text_pos; m >= 0; m--){
c0d05640:	2900      	cmp	r1, #0
c0d05642:	db08      	blt.n	c0d05656 <display_tx_part+0x5a>
c0d05644:	4a12      	ldr	r2, [pc, #72]	; (c0d05690 <display_tx_part+0x94>)
c0d05646:	460d      	mov	r5, r1
        all_data[m + ml] = all_data[m];
c0d05648:	5d54      	ldrb	r4, [r2, r5]
c0d0564a:	5414      	strb	r4, [r2, r0]
        sign_tx[current_text_pos++] = text[i];
        i++;
    }

    int ml = cache_data_p - current_text_pos;
    for(int m = current_text_pos; m >= 0; m--){
c0d0564c:	1e40      	subs	r0, r0, #1
c0d0564e:	1e6c      	subs	r4, r5, #1
c0d05650:	2d00      	cmp	r5, #0
c0d05652:	4625      	mov	r5, r4
c0d05654:	dcf8      	bgt.n	c0d05648 <display_tx_part+0x4c>
    // if (text[i] == '\n') {
    //     i++;
    // }
    // sign_tx[i] = '\0';

    ui_sign_message[0] = 'n';
c0d05656:	480f      	ldr	r0, [pc, #60]	; (c0d05694 <display_tx_part+0x98>)
c0d05658:	226e      	movs	r2, #110	; 0x6e
c0d0565a:	7002      	strb	r2, [r0, #0]
    ui_sign_message[1] = 'o';
c0d0565c:	226f      	movs	r2, #111	; 0x6f
c0d0565e:	7042      	strb	r2, [r0, #1]
    ui_sign_message[2] = 'd';
c0d05660:	2264      	movs	r2, #100	; 0x64
c0d05662:	7082      	strb	r2, [r0, #2]
    ui_sign_message[3] = 'a';
c0d05664:	2261      	movs	r2, #97	; 0x61
c0d05666:	70c2      	strb	r2, [r0, #3]
    ui_sign_message[4] = 't';
c0d05668:	2474      	movs	r4, #116	; 0x74
c0d0566a:	7104      	strb	r4, [r0, #4]
    ui_sign_message[5] = 'a';
c0d0566c:	7142      	strb	r2, [r0, #5]
    ui_sign_message[6] = '\0';
c0d0566e:	2200      	movs	r2, #0
c0d05670:	7182      	strb	r2, [r0, #6]
    // ui_sign_hash[3] = 'a';
    // ui_sign_hash[4] = 's';
    // ui_sign_hash[5] = 'h';
    // ui_sign_hash[6] = '\0';

    tx.operation.data = &ui_sign_message;
c0d05672:	4a09      	ldr	r2, [pc, #36]	; (c0d05698 <display_tx_part+0x9c>)
c0d05674:	60d0      	str	r0, [r2, #12]
    // tx.encode_hex = &ui_sign_hash;

    build_transaction(&(all_data[ml]), current_text_pos, &tx);
c0d05676:	4806      	ldr	r0, [pc, #24]	; (c0d05690 <display_tx_part+0x94>)
c0d05678:	18c0      	adds	r0, r0, r3
c0d0567a:	f7fe fc6b 	bl	c0d03f54 <build_transaction>
c0d0567e:	9800      	ldr	r0, [sp, #0]
    bagl_ui_text[0].component.font_id = DEFAULT_FONT;
    bagl_ui_text[0].text = ui_sign_message;
    text_y += TEXT_HEIGHT + TEXT_SPACE;
#endif
    return 1;
}
c0d05680:	b001      	add	sp, #4
c0d05682:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d05684:	20001fbc 	.word	0x20001fbc
c0d05688:	2000222c 	.word	0x2000222c
c0d0568c:	20001d1c 	.word	0x20001d1c
c0d05690:	20001800 	.word	0x20001800
c0d05694:	20001b7e 	.word	0x20001b7e
c0d05698:	20002200 	.word	0x20002200

c0d0569c <ui_sign_tx_nanos_button>:

unsigned int
ui_sign_tx_nanos_button(unsigned int button_mask,
                                 unsigned int button_mask_counter) {
c0d0569c:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d0569e:	4907      	ldr	r1, [pc, #28]	; (c0d056bc <ui_sign_tx_nanos_button+0x20>)
c0d056a0:	4288      	cmp	r0, r1
c0d056a2:	d006      	beq.n	c0d056b2 <ui_sign_tx_nanos_button+0x16>
c0d056a4:	4906      	ldr	r1, [pc, #24]	; (c0d056c0 <ui_sign_tx_nanos_button+0x24>)
c0d056a6:	4288      	cmp	r0, r1
c0d056a8:	d106      	bne.n	c0d056b8 <ui_sign_tx_nanos_button+0x1c>
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        // if (!display_tx_part()) {
            show(UI_APPROVAL_TX);
c0d056aa:	2009      	movs	r0, #9
c0d056ac:	f7ff f9a8 	bl	c0d04a00 <show>
c0d056b0:	e002      	b.n	c0d056b8 <ui_sign_tx_nanos_button+0x1c>
        //     UX_REDISPLAY();
        // }
        break;

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
c0d056b2:	2000      	movs	r0, #0
c0d056b4:	f7fa ffb0 	bl	c0d00618 <io_seproxyhal_touch_deny>
        break;
    }
    return 0;
c0d056b8:	2000      	movs	r0, #0
c0d056ba:	bd80      	pop	{r7, pc}
c0d056bc:	80000001 	.word	0x80000001
c0d056c0:	80000002 	.word	0x80000002

c0d056c4 <format_signature_out>:
}

void format_signature_out(const uint8_t* signature) {
c0d056c4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d056c6:	b081      	sub	sp, #4
c0d056c8:	4604      	mov	r4, r0
  os_memset(G_io_apdu_buffer + 1, 0x00, 64);
c0d056ca:	4818      	ldr	r0, [pc, #96]	; (c0d0572c <format_signature_out+0x68>)
c0d056cc:	1c40      	adds	r0, r0, #1
  }
  memmove(G_io_apdu_buffer+offset+32-xlength,  signature+xoffset, xlength);
  offset += 32;
  xoffset += xlength +2; //move over rvalue and TagLEn
  //copy s value
  xlength = signature[xoffset-1];
c0d056ce:	2100      	movs	r1, #0
    }
    return 0;
}

void format_signature_out(const uint8_t* signature) {
  os_memset(G_io_apdu_buffer + 1, 0x00, 64);
c0d056d0:	2240      	movs	r2, #64	; 0x40
c0d056d2:	9100      	str	r1, [sp, #0]
c0d056d4:	f7fd fb85 	bl	c0d02de2 <os_memset>
  uint8_t offset = 1;
  uint8_t xoffset = 4; //point to r value
  //copy r
  uint8_t xlength = signature[xoffset-1];
c0d056d8:	78e0      	ldrb	r0, [r4, #3]
  if (xlength == 33) {
c0d056da:	2605      	movs	r6, #5
c0d056dc:	2104      	movs	r1, #4
c0d056de:	2821      	cmp	r0, #33	; 0x21
c0d056e0:	d000      	beq.n	c0d056e4 <format_signature_out+0x20>
c0d056e2:	460e      	mov	r6, r1
    xlength = 32;
    xoffset ++;
  }
  memmove(G_io_apdu_buffer+offset+32-xlength,  signature+xoffset, xlength);
c0d056e4:	19a1      	adds	r1, r4, r6
c0d056e6:	2520      	movs	r5, #32
c0d056e8:	2821      	cmp	r0, #33	; 0x21
c0d056ea:	462f      	mov	r7, r5
c0d056ec:	d000      	beq.n	c0d056f0 <format_signature_out+0x2c>
c0d056ee:	4607      	mov	r7, r0
c0d056f0:	480e      	ldr	r0, [pc, #56]	; (c0d0572c <format_signature_out+0x68>)
c0d056f2:	1bc0      	subs	r0, r0, r7
c0d056f4:	3021      	adds	r0, #33	; 0x21
c0d056f6:	463a      	mov	r2, r7
c0d056f8:	f001 fb9a 	bl	c0d06e30 <__aeabi_memmove>
  offset += 32;
  xoffset += xlength +2; //move over rvalue and TagLEn
c0d056fc:	19ba      	adds	r2, r7, r6
c0d056fe:	1c91      	adds	r1, r2, #2
  //copy s value
  xlength = signature[xoffset-1];
c0d05700:	b2c8      	uxtb	r0, r1
c0d05702:	1820      	adds	r0, r4, r0
c0d05704:	9b00      	ldr	r3, [sp, #0]
c0d05706:	43db      	mvns	r3, r3
c0d05708:	5cc0      	ldrb	r0, [r0, r3]
  if (xlength == 33) {
c0d0570a:	1cd2      	adds	r2, r2, #3
c0d0570c:	2821      	cmp	r0, #33	; 0x21
c0d0570e:	d000      	beq.n	c0d05712 <format_signature_out+0x4e>
c0d05710:	460a      	mov	r2, r1
    xlength = 32;
    xoffset ++;
  }
  memmove(G_io_apdu_buffer+offset+32-xlength, signature+xoffset, xlength);
c0d05712:	b2d1      	uxtb	r1, r2
c0d05714:	1861      	adds	r1, r4, r1
c0d05716:	2821      	cmp	r0, #33	; 0x21
c0d05718:	d000      	beq.n	c0d0571c <format_signature_out+0x58>
c0d0571a:	4605      	mov	r5, r0
c0d0571c:	4803      	ldr	r0, [pc, #12]	; (c0d0572c <format_signature_out+0x68>)
c0d0571e:	1b40      	subs	r0, r0, r5
c0d05720:	3041      	adds	r0, #65	; 0x41
c0d05722:	462a      	mov	r2, r5
c0d05724:	f001 fb84 	bl	c0d06e30 <__aeabi_memmove>
}
c0d05728:	b001      	add	sp, #4
c0d0572a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0572c:	20001fbc 	.word	0x20001fbc

c0d05730 <io_seproxyhal_touch_approve_tx>:

const bagl_element_t*
io_seproxyhal_touch_approve_tx(const bagl_element_t *e) {
c0d05730:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05732:	b087      	sub	sp, #28
c0d05734:	2500      	movs	r5, #0
    unsigned int tx_p = 0;
    
    unsigned int info = 0;
c0d05736:	9506      	str	r5, [sp, #24]
    // unsigned char result[32];
    // unsigned char result2[100];
    for(int c = 0; c < 256; c++){
        all_data[cache_data_p + c] = 0;
c0d05738:	204b      	movs	r0, #75	; 0x4b
c0d0573a:	00c0      	lsls	r0, r0, #3
c0d0573c:	4921      	ldr	r1, [pc, #132]	; (c0d057c4 <io_seproxyhal_touch_approve_tx+0x94>)
c0d0573e:	180e      	adds	r6, r1, r0
c0d05740:	2401      	movs	r4, #1
c0d05742:	0221      	lsls	r1, r4, #8
c0d05744:	9404      	str	r4, [sp, #16]
c0d05746:	4630      	mov	r0, r6
c0d05748:	f001 fb6c 	bl	c0d06e24 <__aeabi_memclr>
    }
    unsigned char *result = &(all_data[cache_data_p]);
    unsigned char *result2 = &(all_data[*(tx.encode_p) + 1]);
c0d0574c:	4f1e      	ldr	r7, [pc, #120]	; (c0d057c8 <io_seproxyhal_touch_approve_tx+0x98>)
c0d0574e:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d05750:	6800      	ldr	r0, [r0, #0]

    cx_sha256_init(&hash);
c0d05752:	9005      	str	r0, [sp, #20]
c0d05754:	481d      	ldr	r0, [pc, #116]	; (c0d057cc <io_seproxyhal_touch_approve_tx+0x9c>)
c0d05756:	f7fe f927 	bl	c0d039a8 <cx_sha256_init>
    hash_tainted = 0;
c0d0575a:	481d      	ldr	r0, [pc, #116]	; (c0d057d0 <io_seproxyhal_touch_approve_tx+0xa0>)
c0d0575c:	7005      	strb	r5, [r0, #0]
    
    cx_hash(&hash.header, CX_LAST, tx.encode, *(tx.encode_p), result);
c0d0575e:	6a3a      	ldr	r2, [r7, #32]
c0d05760:	6ab8      	ldr	r0, [r7, #40]	; 0x28
c0d05762:	6803      	ldr	r3, [r0, #0]
c0d05764:	4668      	mov	r0, sp
c0d05766:	6006      	str	r6, [r0, #0]
c0d05768:	4818      	ldr	r0, [pc, #96]	; (c0d057cc <io_seproxyhal_touch_approve_tx+0x9c>)
c0d0576a:	4621      	mov	r1, r4
c0d0576c:	f7fa ff6c 	bl	c0d00648 <cx_hash_X>
c0d05770:	a806      	add	r0, sp, #24
    tx_p = cx_ecdsa_sign((void*) &private_key, CX_RND_RFC6979 | CX_LAST,
c0d05772:	4669      	mov	r1, sp
    
    unsigned int info = 0;
    // unsigned char result[32];
    // unsigned char result2[100];
    for(int c = 0; c < 256; c++){
        all_data[cache_data_p + c] = 0;
c0d05774:	4a13      	ldr	r2, [pc, #76]	; (c0d057c4 <io_seproxyhal_touch_approve_tx+0x94>)
c0d05776:	9b05      	ldr	r3, [sp, #20]
c0d05778:	18d2      	adds	r2, r2, r3
    }
    unsigned char *result = &(all_data[cache_data_p]);
    unsigned char *result2 = &(all_data[*(tx.encode_p) + 1]);
c0d0577a:	1c57      	adds	r7, r2, #1

    cx_sha256_init(&hash);
    hash_tainted = 0;
    
    cx_hash(&hash.header, CX_LAST, tx.encode, *(tx.encode_p), result);
    tx_p = cx_ecdsa_sign((void*) &private_key, CX_RND_RFC6979 | CX_LAST,
c0d0577c:	2204      	movs	r2, #4
c0d0577e:	c184      	stmia	r1!, {r2, r7}
c0d05780:	6008      	str	r0, [r1, #0]
c0d05782:	4814      	ldr	r0, [pc, #80]	; (c0d057d4 <io_seproxyhal_touch_approve_tx+0xa4>)
c0d05784:	4914      	ldr	r1, [pc, #80]	; (c0d057d8 <io_seproxyhal_touch_approve_tx+0xa8>)
c0d05786:	2403      	movs	r4, #3
c0d05788:	4622      	mov	r2, r4
c0d0578a:	4633      	mov	r3, r6
c0d0578c:	f7fa ffcb 	bl	c0d00726 <cx_ecdsa_sign_X>
                           CX_SHA256, result, sizeof(result), result2, &info);

    // G_io_apdu_buffer[0] &= 0xF0;
    hash_tainted = 1;
c0d05790:	480f      	ldr	r0, [pc, #60]	; (c0d057d0 <io_seproxyhal_touch_approve_tx+0xa0>)
c0d05792:	9904      	ldr	r1, [sp, #16]
c0d05794:	7001      	strb	r1, [r0, #0]

    G_io_apdu_buffer[0] = 27;

    if (info & CX_ECCINFO_PARITY_ODD) {
c0d05796:	9806      	ldr	r0, [sp, #24]
c0d05798:	4020      	ands	r0, r4
      G_io_apdu_buffer[0]++;
    }
    if (info & CX_ECCINFO_xGTn) {
c0d0579a:	301b      	adds	r0, #27
    hash_tainted = 1;

    G_io_apdu_buffer[0] = 27;

    if (info & CX_ECCINFO_PARITY_ODD) {
      G_io_apdu_buffer[0]++;
c0d0579c:	4c0f      	ldr	r4, [pc, #60]	; (c0d057dc <io_seproxyhal_touch_approve_tx+0xac>)
c0d0579e:	7020      	strb	r0, [r4, #0]
    }
    if (info & CX_ECCINFO_xGTn) {
      G_io_apdu_buffer[0] += 2;
    }

    format_signature_out(result2);
c0d057a0:	4638      	mov	r0, r7
c0d057a2:	f7ff ff8f 	bl	c0d056c4 <format_signature_out>
    tx_p = 65;

    G_io_apdu_buffer[tx_p++] = 0x90;
c0d057a6:	2041      	movs	r0, #65	; 0x41
c0d057a8:	2190      	movs	r1, #144	; 0x90
c0d057aa:	5421      	strb	r1, [r4, r0]
    G_io_apdu_buffer[tx_p++] = 0x00;
c0d057ac:	2042      	movs	r0, #66	; 0x42
c0d057ae:	5425      	strb	r5, [r4, r0]
c0d057b0:	2020      	movs	r0, #32
    // Send back the response, do not restart the event loop
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx_p);
c0d057b2:	2143      	movs	r1, #67	; 0x43
c0d057b4:	f7fd fdb8 	bl	c0d03328 <io_exchange>
    // Display back the original UX
    show(UI_MAIN);
c0d057b8:	4628      	mov	r0, r5
c0d057ba:	f7ff f921 	bl	c0d04a00 <show>
    return 0; // do not redraw the widget
c0d057be:	4628      	mov	r0, r5
c0d057c0:	b007      	add	sp, #28
c0d057c2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d057c4:	20001800 	.word	0x20001800
c0d057c8:	20002200 	.word	0x20002200
c0d057cc:	20001cac 	.word	0x20001cac
c0d057d0:	20001ca8 	.word	0x20001ca8
c0d057d4:	20001c34 	.word	0x20001c34
c0d057d8:	00000601 	.word	0x00000601
c0d057dc:	20001fbc 	.word	0x20001fbc

c0d057e0 <ui_approval_tx_nanos_button>:
}

unsigned int
ui_approval_tx_nanos_button(unsigned int button_mask,
                              unsigned int button_mask_counter) {
c0d057e0:	b580      	push	{r7, lr}
    switch (button_mask) {
c0d057e2:	4907      	ldr	r1, [pc, #28]	; (c0d05800 <ui_approval_tx_nanos_button+0x20>)
c0d057e4:	4288      	cmp	r0, r1
c0d057e6:	d005      	beq.n	c0d057f4 <ui_approval_tx_nanos_button+0x14>
c0d057e8:	4906      	ldr	r1, [pc, #24]	; (c0d05804 <ui_approval_tx_nanos_button+0x24>)
c0d057ea:	4288      	cmp	r0, r1
c0d057ec:	d105      	bne.n	c0d057fa <ui_approval_tx_nanos_button+0x1a>
    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        io_seproxyhal_touch_approve_tx(NULL);
c0d057ee:	f7ff ff9f 	bl	c0d05730 <io_seproxyhal_touch_approve_tx>
c0d057f2:	e002      	b.n	c0d057fa <ui_approval_tx_nanos_button+0x1a>
        break;

    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_deny(NULL);
c0d057f4:	2000      	movs	r0, #0
c0d057f6:	f7fa ff0f 	bl	c0d00618 <io_seproxyhal_touch_deny>
        break;
    }
    return 0;
c0d057fa:	2000      	movs	r0, #0
c0d057fc:	bd80      	pop	{r7, pc}
c0d057fe:	46c0      	nop			; (mov r8, r8)
c0d05800:	80000001 	.word	0x80000001
c0d05804:	80000002 	.word	0x80000002

c0d05808 <ui_sign_tx_nanos_prepro>:
}

const bagl_element_t*
ui_sign_tx_nanos_prepro(const bagl_element_t *element) {
c0d05808:	b5b0      	push	{r4, r5, r7, lr}
c0d0580a:	4604      	mov	r4, r0
    switch (element->component.userid) {
c0d0580c:	7860      	ldrb	r0, [r4, #1]
c0d0580e:	2802      	cmp	r0, #2
c0d05810:	d110      	bne.n	c0d05834 <ui_sign_tx_nanos_prepro+0x2c>
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
c0d05812:	2107      	movs	r1, #7
c0d05814:	4620      	mov	r0, r4
c0d05816:	f7fd fcf1 	bl	c0d031fc <bagl_label_roundtrip_duration_ms>
c0d0581a:	217d      	movs	r1, #125	; 0x7d
c0d0581c:	00cd      	lsls	r5, r1, #3
c0d0581e:	1941      	adds	r1, r0, r5
c0d05820:	4805      	ldr	r0, [pc, #20]	; (c0d05838 <ui_sign_tx_nanos_prepro+0x30>)
c0d05822:	4281      	cmp	r1, r0
c0d05824:	d304      	bcc.n	c0d05830 <ui_sign_tx_nanos_prepro+0x28>
c0d05826:	2107      	movs	r1, #7
c0d05828:	4620      	mov	r0, r4
c0d0582a:	f7fd fce7 	bl	c0d031fc <bagl_label_roundtrip_duration_ms>
c0d0582e:	1940      	adds	r0, r0, r5

const bagl_element_t*
ui_sign_tx_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
c0d05830:	f7fd fd44 	bl	c0d032bc <io_seproxyhal_setup_ticker>
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
c0d05834:	4620      	mov	r0, r4
c0d05836:	bdb0      	pop	{r4, r5, r7, pc}
c0d05838:	00000bb8 	.word	0x00000bb8

c0d0583c <clear128>:
    copy128(&LOWER_P(target), &LOWER_P(number));
}

void clear128(uint128_t *target) {
    UPPER_P(target) = 0;
    LOWER_P(target) = 0;
c0d0583c:	2100      	movs	r1, #0
c0d0583e:	6001      	str	r1, [r0, #0]
c0d05840:	6041      	str	r1, [r0, #4]
c0d05842:	6081      	str	r1, [r0, #8]
c0d05844:	60c1      	str	r1, [r0, #12]
}
c0d05846:	4770      	bx	lr

c0d05848 <clear256>:

void clear256(uint256_t *target) {
c0d05848:	b580      	push	{r7, lr}
    copy128(&LOWER_P(target), &LOWER_P(number));
}

void clear128(uint128_t *target) {
    UPPER_P(target) = 0;
    LOWER_P(target) = 0;
c0d0584a:	2120      	movs	r1, #32
c0d0584c:	f001 faea 	bl	c0d06e24 <__aeabi_memclr>
}

void clear256(uint256_t *target) {
    clear128(&UPPER_P(target));
    clear128(&LOWER_P(target));
}
c0d05850:	bd80      	pop	{r7, pc}

c0d05852 <add128>:

bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
c0d05852:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05854:	b081      	sub	sp, #4
c0d05856:	9200      	str	r2, [sp, #0]
    UPPER_P(target) =
        UPPER_P(number1) + UPPER_P(number2) +
        ((LOWER_P(number1) + LOWER_P(number2)) < LOWER_P(number1));
c0d05858:	6883      	ldr	r3, [r0, #8]
c0d0585a:	68c5      	ldr	r5, [r0, #12]
c0d0585c:	688c      	ldr	r4, [r1, #8]
c0d0585e:	68ce      	ldr	r6, [r1, #12]
c0d05860:	18e2      	adds	r2, r4, r3
c0d05862:	4175      	adcs	r5, r6
c0d05864:	2701      	movs	r7, #1
c0d05866:	2300      	movs	r3, #0
c0d05868:	42a2      	cmp	r2, r4
c0d0586a:	463c      	mov	r4, r7
c0d0586c:	d300      	bcc.n	c0d05870 <add128+0x1e>
c0d0586e:	461c      	mov	r4, r3
c0d05870:	42b5      	cmp	r5, r6
c0d05872:	d300      	bcc.n	c0d05876 <add128+0x24>
c0d05874:	461f      	mov	r7, r3
c0d05876:	42b5      	cmp	r5, r6
c0d05878:	d000      	beq.n	c0d0587c <add128+0x2a>
c0d0587a:	463c      	mov	r4, r7
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
        UPPER_P(number1) + UPPER_P(number2) +
c0d0587c:	c844      	ldmia	r0!, {r2, r6}
c0d0587e:	c9a0      	ldmia	r1!, {r5, r7}
c0d05880:	3908      	subs	r1, #8
c0d05882:	3808      	subs	r0, #8
c0d05884:	18ad      	adds	r5, r5, r2
c0d05886:	4177      	adcs	r7, r6
c0d05888:	1c6e      	adds	r6, r5, #1
c0d0588a:	417b      	adcs	r3, r7
c0d0588c:	2c00      	cmp	r4, #0
c0d0588e:	d100      	bne.n	c0d05892 <add128+0x40>
c0d05890:	463b      	mov	r3, r7
c0d05892:	9f00      	ldr	r7, [sp, #0]
bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
c0d05894:	607b      	str	r3, [r7, #4]
        UPPER_P(number1) + UPPER_P(number2) +
c0d05896:	2c00      	cmp	r4, #0
c0d05898:	d100      	bne.n	c0d0589c <add128+0x4a>
c0d0589a:	462e      	mov	r6, r5
bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
c0d0589c:	603e      	str	r6, [r7, #0]
        UPPER_P(number1) + UPPER_P(number2) +
        ((LOWER_P(number1) + LOWER_P(number2)) < LOWER_P(number1));
    LOWER_P(target) = LOWER_P(number1) + LOWER_P(number2);
c0d0589e:	6882      	ldr	r2, [r0, #8]
c0d058a0:	68c0      	ldr	r0, [r0, #12]
c0d058a2:	688b      	ldr	r3, [r1, #8]
c0d058a4:	68c9      	ldr	r1, [r1, #12]
c0d058a6:	189a      	adds	r2, r3, r2
c0d058a8:	4141      	adcs	r1, r0
c0d058aa:	60ba      	str	r2, [r7, #8]
c0d058ac:	60f9      	str	r1, [r7, #12]
}
c0d058ae:	b001      	add	sp, #4
c0d058b0:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d058b4 <mul128>:
void or256(uint256_t *number1, uint256_t *number2, uint256_t *target) {
    or128(&UPPER_P(number1), &UPPER_P(number2), &UPPER_P(target));
    or128(&LOWER_P(number1), &LOWER_P(number2), &LOWER_P(target));
}

int mul128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
c0d058b4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d058b6:	b087      	sub	sp, #28
c0d058b8:	9201      	str	r2, [sp, #4]

    top[0] = UPPER_P(number1) >> 32;
c0d058ba:	6842      	ldr	r2, [r0, #4]
c0d058bc:	4b7c      	ldr	r3, [pc, #496]	; (c0d05ab0 <mul128+0x1fc>)
    first32 += (products[1][1] & 0xffffffff) + (products[1][2] >> 32);

    second32 += products[2][3] & 0xffffffff;
    first32 += (products[2][2] & 0xffffffff) + (products[2][3] >> 32);

    first32 += products[3][3] & 0xffffffff;
c0d058be:	2400      	movs	r4, #0
    or128(&LOWER_P(number1), &LOWER_P(number2), &LOWER_P(target));
}

int mul128(uint128_t *number1, uint128_t *number2, uint128_t *target) {

    top[0] = UPPER_P(number1) >> 32;
c0d058c0:	c314      	stmia	r3!, {r2, r4}
    top[1] = UPPER_P(number1) & 0xffffffff;
c0d058c2:	6802      	ldr	r2, [r0, #0]
c0d058c4:	605c      	str	r4, [r3, #4]
c0d058c6:	601a      	str	r2, [r3, #0]
    top[2] = LOWER_P(number1) >> 32;
c0d058c8:	68c2      	ldr	r2, [r0, #12]
c0d058ca:	60dc      	str	r4, [r3, #12]
c0d058cc:	609a      	str	r2, [r3, #8]
    top[3] = LOWER_P(number1) & 0xffffffff;
c0d058ce:	6880      	ldr	r0, [r0, #8]
c0d058d0:	615c      	str	r4, [r3, #20]
c0d058d2:	6118      	str	r0, [r3, #16]

    bottom[0] = UPPER_P(number2) >> 32;
c0d058d4:	6848      	ldr	r0, [r1, #4]
c0d058d6:	4a77      	ldr	r2, [pc, #476]	; (c0d05ab4 <mul128+0x200>)
c0d058d8:	c211      	stmia	r2!, {r0, r4}
    bottom[1] = UPPER_P(number2) & 0xffffffff;
c0d058da:	6808      	ldr	r0, [r1, #0]
c0d058dc:	6054      	str	r4, [r2, #4]
c0d058de:	6010      	str	r0, [r2, #0]
    bottom[2] = LOWER_P(number2) >> 32;
c0d058e0:	68c8      	ldr	r0, [r1, #12]
c0d058e2:	60d4      	str	r4, [r2, #12]
c0d058e4:	6090      	str	r0, [r2, #8]
    bottom[3] = LOWER_P(number2) & 0xffffffff;
c0d058e6:	6888      	ldr	r0, [r1, #8]
c0d058e8:	6154      	str	r4, [r2, #20]
c0d058ea:	4605      	mov	r5, r0
c0d058ec:	6110      	str	r0, [r2, #16]
    copy128(&LOWER_P(target), &LOWER_P(number));
}

void clear128(uint128_t *target) {
    UPPER_P(target) = 0;
    LOWER_P(target) = 0;
c0d058ee:	4872      	ldr	r0, [pc, #456]	; (c0d05ab8 <mul128+0x204>)
c0d058f0:	6004      	str	r4, [r0, #0]
c0d058f2:	6044      	str	r4, [r0, #4]
c0d058f4:	6084      	str	r4, [r0, #8]
c0d058f6:	60c4      	str	r4, [r0, #12]
c0d058f8:	4870      	ldr	r0, [pc, #448]	; (c0d05abc <mul128+0x208>)
c0d058fa:	6004      	str	r4, [r0, #0]
c0d058fc:	6044      	str	r4, [r0, #4]
c0d058fe:	6084      	str	r4, [r0, #8]
c0d05900:	60c4      	str	r4, [r0, #12]
    //                       LOWER_P(number2) >> 32,
    //                       LOWER_P(number2) & 0xffffffff};
    
    clear128(&tmp);
    clear128(&tmp2);
    fourth32 = 0;
c0d05902:	486f      	ldr	r0, [pc, #444]	; (c0d05ac0 <mul128+0x20c>)
c0d05904:	6004      	str	r4, [r0, #0]
c0d05906:	6044      	str	r4, [r0, #4]
    third32 = 0;
c0d05908:	486e      	ldr	r0, [pc, #440]	; (c0d05ac4 <mul128+0x210>)
c0d0590a:	6004      	str	r4, [r0, #0]
c0d0590c:	6044      	str	r4, [r0, #4]
    second32 = 0;
c0d0590e:	486e      	ldr	r0, [pc, #440]	; (c0d05ac8 <mul128+0x214>)
c0d05910:	6004      	str	r4, [r0, #0]
c0d05912:	6044      	str	r4, [r0, #4]
    first32 = 0;
c0d05914:	486d      	ldr	r0, [pc, #436]	; (c0d05acc <mul128+0x218>)
c0d05916:	6004      	str	r4, [r0, #0]
c0d05918:	6044      	str	r4, [r0, #4]
    first32 += (products[1][1] & 0xffffffff) + (products[1][2] >> 32);

    second32 += products[2][3] & 0xffffffff;
    first32 += (products[2][2] & 0xffffffff) + (products[2][3] >> 32);

    first32 += products[3][3] & 0xffffffff;
c0d0591a:	43e3      	mvns	r3, r4
c0d0591c:	4e6c      	ldr	r6, [pc, #432]	; (c0d05ad0 <mul128+0x21c>)
c0d0591e:	3618      	adds	r6, #24
c0d05920:	2003      	movs	r0, #3
c0d05922:	9004      	str	r0, [sp, #16]
c0d05924:	9402      	str	r4, [sp, #8]
c0d05926:	4620      	mov	r0, r4
c0d05928:	e007      	b.n	c0d0593a <mul128+0x86>
c0d0592a:	00ca      	lsls	r2, r1, #3
c0d0592c:	4c61      	ldr	r4, [pc, #388]	; (c0d05ab4 <mul128+0x200>)
c0d0592e:	58a5      	ldr	r5, [r4, r2]
c0d05930:	9e03      	ldr	r6, [sp, #12]
    fourth32 = 0;
    third32 = 0;
    second32 = 0;
    first32 = 0;

    for (int y = 3; y > -1; y--) {
c0d05932:	1836      	adds	r6, r6, r0
c0d05934:	18a0      	adds	r0, r4, r2
c0d05936:	6840      	ldr	r0, [r0, #4]
c0d05938:	9104      	str	r1, [sp, #16]
c0d0593a:	9005      	str	r0, [sp, #20]
c0d0593c:	9506      	str	r5, [sp, #24]
c0d0593e:	4d5c      	ldr	r5, [pc, #368]	; (c0d05ab0 <mul128+0x1fc>)
c0d05940:	3518      	adds	r5, #24
c0d05942:	2404      	movs	r4, #4
c0d05944:	9603      	str	r6, [sp, #12]
        for (int x = 3; x > -1; x--) {
            products[3 - x][y] = top[x] * bottom[y];
c0d05946:	682a      	ldr	r2, [r5, #0]
c0d05948:	461f      	mov	r7, r3
c0d0594a:	686b      	ldr	r3, [r5, #4]
c0d0594c:	9806      	ldr	r0, [sp, #24]
c0d0594e:	9905      	ldr	r1, [sp, #20]
c0d05950:	f001 fa3c 	bl	c0d06dcc <__aeabi_lmul>
c0d05954:	463b      	mov	r3, r7
c0d05956:	c603      	stmia	r6!, {r0, r1}
    third32 = 0;
    second32 = 0;
    first32 = 0;

    for (int y = 3; y > -1; y--) {
        for (int x = 3; x > -1; x--) {
c0d05958:	00d8      	lsls	r0, r3, #3
c0d0595a:	182d      	adds	r5, r5, r0
c0d0595c:	3618      	adds	r6, #24
c0d0595e:	1e64      	subs	r4, r4, #1
c0d05960:	2c00      	cmp	r4, #0
c0d05962:	dcf0      	bgt.n	c0d05946 <mul128+0x92>
c0d05964:	9a04      	ldr	r2, [sp, #16]
    fourth32 = 0;
    third32 = 0;
    second32 = 0;
    first32 = 0;

    for (int y = 3; y > -1; y--) {
c0d05966:	1e51      	subs	r1, r2, #1
c0d05968:	2a01      	cmp	r2, #1
c0d0596a:	dade      	bge.n	c0d0592a <mul128+0x76>
c0d0596c:	4858      	ldr	r0, [pc, #352]	; (c0d05ad0 <mul128+0x21c>)
c0d0596e:	4605      	mov	r5, r0
        for (int x = 3; x > -1; x--) {
            products[3 - x][y] = top[x] * bottom[y];
        }
    }

    fourth32 = products[0][3] & 0xffffffff;
c0d05970:	69e8      	ldr	r0, [r5, #28]
c0d05972:	69a9      	ldr	r1, [r5, #24]
c0d05974:	4019      	ands	r1, r3
c0d05976:	4a52      	ldr	r2, [pc, #328]	; (c0d05ac0 <mul128+0x20c>)
c0d05978:	6011      	str	r1, [r2, #0]
c0d0597a:	9c02      	ldr	r4, [sp, #8]
c0d0597c:	6054      	str	r4, [r2, #4]
    third32 = (products[0][2] & 0xffffffff) + (products[0][3] >> 32);
c0d0597e:	6929      	ldr	r1, [r5, #16]
c0d05980:	4019      	ands	r1, r3
c0d05982:	1808      	adds	r0, r1, r0
c0d05984:	4627      	mov	r7, r4
c0d05986:	417f      	adcs	r7, r7
    second32 = (products[0][1] & 0xffffffff) + (products[0][2] >> 32);
    first32 = (products[0][0] & 0xffffffff) + (products[0][1] >> 32);

    third32 += products[1][3] & 0xffffffff;
c0d05988:	6baa      	ldr	r2, [r5, #56]	; 0x38
c0d0598a:	401a      	ands	r2, r3
c0d0598c:	1880      	adds	r0, r0, r2
c0d0598e:	9006      	str	r0, [sp, #24]
c0d05990:	4167      	adcs	r7, r4
c0d05992:	9705      	str	r7, [sp, #20]
c0d05994:	462a      	mov	r2, r5
        }
    }

    fourth32 = products[0][3] & 0xffffffff;
    third32 = (products[0][2] & 0xffffffff) + (products[0][3] >> 32);
    second32 = (products[0][1] & 0xffffffff) + (products[0][2] >> 32);
c0d05996:	68d1      	ldr	r1, [r2, #12]
c0d05998:	9104      	str	r1, [sp, #16]
c0d0599a:	4619      	mov	r1, r3
    first32 = (products[0][0] & 0xffffffff) + (products[0][1] >> 32);
c0d0599c:	6813      	ldr	r3, [r2, #0]

    third32 += products[1][3] & 0xffffffff;
c0d0599e:	6bd5      	ldr	r5, [r2, #60]	; 0x3c
            products[3 - x][y] = top[x] * bottom[y];
        }
    }

    fourth32 = products[0][3] & 0xffffffff;
    third32 = (products[0][2] & 0xffffffff) + (products[0][3] >> 32);
c0d059a0:	9503      	str	r5, [sp, #12]
c0d059a2:	6955      	ldr	r5, [r2, #20]
    second32 = (products[0][1] & 0xffffffff) + (products[0][2] >> 32);
c0d059a4:	6896      	ldr	r6, [r2, #8]
c0d059a6:	4a47      	ldr	r2, [pc, #284]	; (c0d05ac4 <mul128+0x210>)
    first32 = (products[0][0] & 0xffffffff) + (products[0][1] >> 32);

    third32 += products[1][3] & 0xffffffff;
c0d059a8:	c281      	stmia	r2!, {r0, r7}
        }
    }

    fourth32 = products[0][3] & 0xffffffff;
    third32 = (products[0][2] & 0xffffffff) + (products[0][3] >> 32);
    second32 = (products[0][1] & 0xffffffff) + (products[0][2] >> 32);
c0d059aa:	400e      	ands	r6, r1
c0d059ac:	19ad      	adds	r5, r5, r6
c0d059ae:	4626      	mov	r6, r4
c0d059b0:	4176      	adcs	r6, r6
c0d059b2:	4a47      	ldr	r2, [pc, #284]	; (c0d05ad0 <mul128+0x21c>)
    first32 = (products[0][0] & 0xffffffff) + (products[0][1] >> 32);

    third32 += products[1][3] & 0xffffffff;
    second32 += (products[1][2] & 0xffffffff) + (products[1][3] >> 32);
c0d059b4:	6b17      	ldr	r7, [r2, #48]	; 0x30
c0d059b6:	400f      	ands	r7, r1
c0d059b8:	9803      	ldr	r0, [sp, #12]
c0d059ba:	19c0      	adds	r0, r0, r7
c0d059bc:	4627      	mov	r7, r4
c0d059be:	417f      	adcs	r7, r7
c0d059c0:	1940      	adds	r0, r0, r5
c0d059c2:	4177      	adcs	r7, r6
    first32 += (products[1][1] & 0xffffffff) + (products[1][2] >> 32);

    second32 += products[2][3] & 0xffffffff;
c0d059c4:	6d95      	ldr	r5, [r2, #88]	; 0x58
c0d059c6:	400d      	ands	r5, r1
c0d059c8:	1945      	adds	r5, r0, r5
c0d059ca:	4167      	adcs	r7, r4
c0d059cc:	6dd0      	ldr	r0, [r2, #92]	; 0x5c
    third32 = (products[0][2] & 0xffffffff) + (products[0][3] >> 32);
    second32 = (products[0][1] & 0xffffffff) + (products[0][2] >> 32);
    first32 = (products[0][0] & 0xffffffff) + (products[0][1] >> 32);

    third32 += products[1][3] & 0xffffffff;
    second32 += (products[1][2] & 0xffffffff) + (products[1][3] >> 32);
c0d059ce:	9003      	str	r0, [sp, #12]
c0d059d0:	6b56      	ldr	r6, [r2, #52]	; 0x34
    first32 += (products[1][1] & 0xffffffff) + (products[1][2] >> 32);
c0d059d2:	6a90      	ldr	r0, [r2, #40]	; 0x28
c0d059d4:	4a3c      	ldr	r2, [pc, #240]	; (c0d05ac8 <mul128+0x214>)

    second32 += products[2][3] & 0xffffffff;
c0d059d6:	c2a0      	stmia	r2!, {r5, r7}
    }

    fourth32 = products[0][3] & 0xffffffff;
    third32 = (products[0][2] & 0xffffffff) + (products[0][3] >> 32);
    second32 = (products[0][1] & 0xffffffff) + (products[0][2] >> 32);
    first32 = (products[0][0] & 0xffffffff) + (products[0][1] >> 32);
c0d059d8:	400b      	ands	r3, r1
c0d059da:	9a04      	ldr	r2, [sp, #16]
c0d059dc:	18d2      	adds	r2, r2, r3
c0d059de:	4623      	mov	r3, r4
c0d059e0:	415b      	adcs	r3, r3

    third32 += products[1][3] & 0xffffffff;
    second32 += (products[1][2] & 0xffffffff) + (products[1][3] >> 32);
    first32 += (products[1][1] & 0xffffffff) + (products[1][2] >> 32);
c0d059e2:	4008      	ands	r0, r1
c0d059e4:	1830      	adds	r0, r6, r0
c0d059e6:	4625      	mov	r5, r4
c0d059e8:	416d      	adcs	r5, r5
c0d059ea:	1880      	adds	r0, r0, r2
c0d059ec:	415d      	adcs	r5, r3
c0d059ee:	4e38      	ldr	r6, [pc, #224]	; (c0d05ad0 <mul128+0x21c>)

    second32 += products[2][3] & 0xffffffff;
    first32 += (products[2][2] & 0xffffffff) + (products[2][3] >> 32);
c0d059f0:	6d32      	ldr	r2, [r6, #80]	; 0x50
c0d059f2:	400a      	ands	r2, r1
c0d059f4:	9b03      	ldr	r3, [sp, #12]
c0d059f6:	189a      	adds	r2, r3, r2
c0d059f8:	4623      	mov	r3, r4
c0d059fa:	415b      	adcs	r3, r3
c0d059fc:	1810      	adds	r0, r2, r0
c0d059fe:	416b      	adcs	r3, r5

    first32 += products[3][3] & 0xffffffff;
c0d05a00:	6fb2      	ldr	r2, [r6, #120]	; 0x78
c0d05a02:	400a      	ands	r2, r1
c0d05a04:	1810      	adds	r0, r2, r0
c0d05a06:	4163      	adcs	r3, r4
c0d05a08:	4a30      	ldr	r2, [pc, #192]	; (c0d05acc <mul128+0x218>)
c0d05a0a:	c209      	stmia	r2!, {r0, r3}
c0d05a0c:	4d2a      	ldr	r5, [pc, #168]	; (c0d05ab8 <mul128+0x204>)

    UPPER(tmp) = first32 << 32;
    LOWER(tmp) = 0;
c0d05a0e:	60ec      	str	r4, [r5, #12]
c0d05a10:	60ac      	str	r4, [r5, #8]
c0d05a12:	4e2a      	ldr	r6, [pc, #168]	; (c0d05abc <mul128+0x208>)
c0d05a14:	9905      	ldr	r1, [sp, #20]
    UPPER(tmp2) = third32 >> 32;
c0d05a16:	c612      	stmia	r6!, {r1, r4}
    LOWER(tmp2) = third32 << 32;
c0d05a18:	6034      	str	r4, [r6, #0]
c0d05a1a:	9a06      	ldr	r2, [sp, #24]
c0d05a1c:	6072      	str	r2, [r6, #4]
c0d05a1e:	9f01      	ldr	r7, [sp, #4]
bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
c0d05a20:	6078      	str	r0, [r7, #4]
c0d05a22:	6039      	str	r1, [r7, #0]
        UPPER_P(number1) + UPPER_P(number2) +
        ((LOWER_P(number1) + LOWER_P(number2)) < LOWER_P(number1));
    LOWER_P(target) = LOWER_P(number1) + LOWER_P(number2);
c0d05a24:	68a8      	ldr	r0, [r5, #8]
c0d05a26:	68e9      	ldr	r1, [r5, #12]
c0d05a28:	6832      	ldr	r2, [r6, #0]
c0d05a2a:	6873      	ldr	r3, [r6, #4]

    first32 += products[3][3] & 0xffffffff;

    UPPER(tmp) = first32 << 32;
    LOWER(tmp) = 0;
    UPPER(tmp2) = third32 >> 32;
c0d05a2c:	3e08      	subs	r6, #8

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
        UPPER_P(number1) + UPPER_P(number2) +
        ((LOWER_P(number1) + LOWER_P(number2)) < LOWER_P(number1));
    LOWER_P(target) = LOWER_P(number1) + LOWER_P(number2);
c0d05a2e:	1810      	adds	r0, r2, r0
c0d05a30:	414b      	adcs	r3, r1
c0d05a32:	60fb      	str	r3, [r7, #12]
c0d05a34:	60b8      	str	r0, [r7, #8]
c0d05a36:	4924      	ldr	r1, [pc, #144]	; (c0d05ac8 <mul128+0x214>)
    UPPER(tmp) = first32 << 32;
    LOWER(tmp) = 0;
    UPPER(tmp2) = third32 >> 32;
    LOWER(tmp2) = third32 << 32;
    add128(&tmp, &tmp2, target);
    UPPER(tmp) = second32;
c0d05a38:	c905      	ldmia	r1!, {r0, r2}
    LOWER(tmp) = 0;
c0d05a3a:	60ec      	str	r4, [r5, #12]
    UPPER(tmp) = first32 << 32;
    LOWER(tmp) = 0;
    UPPER(tmp2) = third32 >> 32;
    LOWER(tmp2) = third32 << 32;
    add128(&tmp, &tmp2, target);
    UPPER(tmp) = second32;
c0d05a3c:	c515      	stmia	r5!, {r0, r2, r4}
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
        UPPER_P(number1) + UPPER_P(number2) +
c0d05a3e:	683b      	ldr	r3, [r7, #0]
c0d05a40:	6879      	ldr	r1, [r7, #4]
    UPPER(tmp) = first32 << 32;
    LOWER(tmp) = 0;
    UPPER(tmp2) = third32 >> 32;
    LOWER(tmp2) = third32 << 32;
    add128(&tmp, &tmp2, target);
    UPPER(tmp) = second32;
c0d05a42:	3d0c      	subs	r5, #12
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
        UPPER_P(number1) + UPPER_P(number2) +
c0d05a44:	1818      	adds	r0, r3, r0
c0d05a46:	4151      	adcs	r1, r2
bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
c0d05a48:	c603      	stmia	r6!, {r0, r1}
        UPPER_P(number1) + UPPER_P(number2) +
        ((LOWER_P(number1) + LOWER_P(number2)) < LOWER_P(number1));
    LOWER_P(target) = LOWER_P(number1) + LOWER_P(number2);
c0d05a4a:	68ba      	ldr	r2, [r7, #8]
c0d05a4c:	68fb      	ldr	r3, [r7, #12]
c0d05a4e:	6073      	str	r3, [r6, #4]
c0d05a50:	6032      	str	r2, [r6, #0]
    LOWER(tmp2) = third32 << 32;
    add128(&tmp, &tmp2, target);
    UPPER(tmp) = second32;
    LOWER(tmp) = 0;
    add128(&tmp, target, &tmp2);
    UPPER(tmp) = 0;
c0d05a52:	606c      	str	r4, [r5, #4]
c0d05a54:	602c      	str	r4, [r5, #0]
c0d05a56:	4c1a      	ldr	r4, [pc, #104]	; (c0d05ac0 <mul128+0x20c>)
    LOWER(tmp) = fourth32;
c0d05a58:	6826      	ldr	r6, [r4, #0]
c0d05a5a:	6864      	ldr	r4, [r4, #4]
c0d05a5c:	60ae      	str	r6, [r5, #8]
c0d05a5e:	60ec      	str	r4, [r5, #12]
c0d05a60:	18b2      	adds	r2, r6, r2
c0d05a62:	4163      	adcs	r3, r4
c0d05a64:	2501      	movs	r5, #1
c0d05a66:	42b2      	cmp	r2, r6
c0d05a68:	462a      	mov	r2, r5
c0d05a6a:	d300      	bcc.n	c0d05a6e <mul128+0x1ba>
c0d05a6c:	9a02      	ldr	r2, [sp, #8]
c0d05a6e:	42a3      	cmp	r3, r4
c0d05a70:	d300      	bcc.n	c0d05a74 <mul128+0x1c0>
c0d05a72:	9d02      	ldr	r5, [sp, #8]
c0d05a74:	42a3      	cmp	r3, r4
c0d05a76:	d000      	beq.n	c0d05a7a <mul128+0x1c6>
c0d05a78:	462a      	mov	r2, r5
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
        UPPER_P(number1) + UPPER_P(number2) +
c0d05a7a:	1c43      	adds	r3, r0, #1
c0d05a7c:	460c      	mov	r4, r1
c0d05a7e:	9d02      	ldr	r5, [sp, #8]
c0d05a80:	416c      	adcs	r4, r5
c0d05a82:	2a00      	cmp	r2, #0
c0d05a84:	d100      	bne.n	c0d05a88 <mul128+0x1d4>
c0d05a86:	460c      	mov	r4, r1
bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
c0d05a88:	607c      	str	r4, [r7, #4]
        UPPER_P(number1) + UPPER_P(number2) +
c0d05a8a:	2a00      	cmp	r2, #0
c0d05a8c:	d100      	bne.n	c0d05a90 <mul128+0x1dc>
c0d05a8e:	4603      	mov	r3, r0
bool gte256(uint256_t *number1, uint256_t *number2) {
    return gt256(number1, number2) || equal256(number1, number2);
}

void add128(uint128_t *number1, uint128_t *number2, uint128_t *target) {
    UPPER_P(target) =
c0d05a90:	603b      	str	r3, [r7, #0]
c0d05a92:	4809      	ldr	r0, [pc, #36]	; (c0d05ab8 <mul128+0x204>)
c0d05a94:	4601      	mov	r1, r0
        UPPER_P(number1) + UPPER_P(number2) +
        ((LOWER_P(number1) + LOWER_P(number2)) < LOWER_P(number1));
    LOWER_P(target) = LOWER_P(number1) + LOWER_P(number2);
c0d05a96:	6888      	ldr	r0, [r1, #8]
c0d05a98:	68c9      	ldr	r1, [r1, #12]
c0d05a9a:	4a08      	ldr	r2, [pc, #32]	; (c0d05abc <mul128+0x208>)
c0d05a9c:	4613      	mov	r3, r2
c0d05a9e:	689a      	ldr	r2, [r3, #8]
c0d05aa0:	68db      	ldr	r3, [r3, #12]
c0d05aa2:	1810      	adds	r0, r2, r0
c0d05aa4:	414b      	adcs	r3, r1
c0d05aa6:	60b8      	str	r0, [r7, #8]
c0d05aa8:	60fb      	str	r3, [r7, #12]
    add128(&tmp, target, &tmp2);
    UPPER(tmp) = 0;
    LOWER(tmp) = fourth32;
    add128(&tmp, &tmp2, target);

    return 0;
c0d05aaa:	9802      	ldr	r0, [sp, #8]
c0d05aac:	b007      	add	sp, #28
c0d05aae:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d05ab0:	20002230 	.word	0x20002230
c0d05ab4:	20002250 	.word	0x20002250
c0d05ab8:	200022f0 	.word	0x200022f0
c0d05abc:	20002300 	.word	0x20002300
c0d05ac0:	20002310 	.word	0x20002310
c0d05ac4:	20002318 	.word	0x20002318
c0d05ac8:	20002320 	.word	0x20002320
c0d05acc:	20002328 	.word	0x20002328
c0d05ad0:	20002270 	.word	0x20002270

c0d05ad4 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d05ad4:	4902      	ldr	r1, [pc, #8]	; (c0d05ae0 <USBD_LL_Init+0xc>)
c0d05ad6:	2000      	movs	r0, #0
c0d05ad8:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d05ada:	4902      	ldr	r1, [pc, #8]	; (c0d05ae4 <USBD_LL_Init+0x10>)
c0d05adc:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d05ade:	4770      	bx	lr
c0d05ae0:	20002330 	.word	0x20002330
c0d05ae4:	20002334 	.word	0x20002334

c0d05ae8 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d05ae8:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05aea:	4807      	ldr	r0, [pc, #28]	; (c0d05b08 <USBD_LL_DeInit+0x20>)
c0d05aec:	214f      	movs	r1, #79	; 0x4f
c0d05aee:	7001      	strb	r1, [r0, #0]
c0d05af0:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d05af2:	7044      	strb	r4, [r0, #1]
c0d05af4:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d05af6:	7081      	strb	r1, [r0, #2]
c0d05af8:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d05afa:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d05afc:	2104      	movs	r1, #4
c0d05afe:	f7fe f827 	bl	c0d03b50 <io_seph_send>

  return USBD_OK; 
c0d05b02:	4620      	mov	r0, r4
c0d05b04:	bd10      	pop	{r4, pc}
c0d05b06:	46c0      	nop			; (mov r8, r8)
c0d05b08:	20001df0 	.word	0x20001df0

c0d05b0c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d05b0c:	b570      	push	{r4, r5, r6, lr}
c0d05b0e:	b082      	sub	sp, #8
c0d05b10:	466d      	mov	r5, sp
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05b12:	264f      	movs	r6, #79	; 0x4f
c0d05b14:	702e      	strb	r6, [r5, #0]
c0d05b16:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d05b18:	706c      	strb	r4, [r5, #1]
c0d05b1a:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d05b1c:	70a8      	strb	r0, [r5, #2]
c0d05b1e:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d05b20:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d05b22:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d05b24:	2105      	movs	r1, #5
c0d05b26:	4628      	mov	r0, r5
c0d05b28:	f7fe f812 	bl	c0d03b50 <io_seph_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05b2c:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d05b2e:	706c      	strb	r4, [r5, #1]
c0d05b30:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d05b32:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d05b34:	70e8      	strb	r0, [r5, #3]
c0d05b36:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d05b38:	4628      	mov	r0, r5
c0d05b3a:	f7fe f809 	bl	c0d03b50 <io_seph_send>
  return USBD_OK; 
c0d05b3e:	4620      	mov	r0, r4
c0d05b40:	b002      	add	sp, #8
c0d05b42:	bd70      	pop	{r4, r5, r6, pc}

c0d05b44 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d05b44:	b510      	push	{r4, lr}
c0d05b46:	b082      	sub	sp, #8
c0d05b48:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05b4a:	214f      	movs	r1, #79	; 0x4f
c0d05b4c:	7001      	strb	r1, [r0, #0]
c0d05b4e:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d05b50:	7044      	strb	r4, [r0, #1]
c0d05b52:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d05b54:	7081      	strb	r1, [r0, #2]
c0d05b56:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d05b58:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d05b5a:	2104      	movs	r1, #4
c0d05b5c:	f7fd fff8 	bl	c0d03b50 <io_seph_send>
  return USBD_OK; 
c0d05b60:	4620      	mov	r0, r4
c0d05b62:	b002      	add	sp, #8
c0d05b64:	bd10      	pop	{r4, pc}
	...

c0d05b68 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d05b68:	b5b0      	push	{r4, r5, r7, lr}
c0d05b6a:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d05b6c:	480e      	ldr	r0, [pc, #56]	; (c0d05ba8 <USBD_LL_OpenEP+0x40>)
c0d05b6e:	2400      	movs	r4, #0
c0d05b70:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d05b72:	480e      	ldr	r0, [pc, #56]	; (c0d05bac <USBD_LL_OpenEP+0x44>)
c0d05b74:	6004      	str	r4, [r0, #0]
c0d05b76:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05b78:	254f      	movs	r5, #79	; 0x4f
c0d05b7a:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d05b7c:	7044      	strb	r4, [r0, #1]
c0d05b7e:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d05b80:	7085      	strb	r5, [r0, #2]
c0d05b82:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d05b84:	70c5      	strb	r5, [r0, #3]
c0d05b86:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d05b88:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d05b8a:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d05b8c:	2a03      	cmp	r2, #3
c0d05b8e:	d802      	bhi.n	c0d05b96 <USBD_LL_OpenEP+0x2e>
c0d05b90:	00d0      	lsls	r0, r2, #3
c0d05b92:	4c07      	ldr	r4, [pc, #28]	; (c0d05bb0 <USBD_LL_OpenEP+0x48>)
c0d05b94:	40c4      	lsrs	r4, r0
c0d05b96:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d05b98:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d05b9a:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d05b9c:	2108      	movs	r1, #8
c0d05b9e:	f7fd ffd7 	bl	c0d03b50 <io_seph_send>
c0d05ba2:	2000      	movs	r0, #0
  return USBD_OK; 
c0d05ba4:	b002      	add	sp, #8
c0d05ba6:	bdb0      	pop	{r4, r5, r7, pc}
c0d05ba8:	20002330 	.word	0x20002330
c0d05bac:	20002334 	.word	0x20002334
c0d05bb0:	02030401 	.word	0x02030401

c0d05bb4 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d05bb4:	b510      	push	{r4, lr}
c0d05bb6:	b082      	sub	sp, #8
c0d05bb8:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05bba:	224f      	movs	r2, #79	; 0x4f
c0d05bbc:	7002      	strb	r2, [r0, #0]
c0d05bbe:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d05bc0:	7044      	strb	r4, [r0, #1]
c0d05bc2:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d05bc4:	7082      	strb	r2, [r0, #2]
c0d05bc6:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d05bc8:	70c2      	strb	r2, [r0, #3]
c0d05bca:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d05bcc:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d05bce:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d05bd0:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d05bd2:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d05bd4:	2108      	movs	r1, #8
c0d05bd6:	f7fd ffbb 	bl	c0d03b50 <io_seph_send>
  return USBD_OK; 
c0d05bda:	4620      	mov	r0, r4
c0d05bdc:	b002      	add	sp, #8
c0d05bde:	bd10      	pop	{r4, pc}

c0d05be0 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d05be0:	b5b0      	push	{r4, r5, r7, lr}
c0d05be2:	b082      	sub	sp, #8
c0d05be4:	460d      	mov	r5, r1
c0d05be6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05be8:	2150      	movs	r1, #80	; 0x50
c0d05bea:	7001      	strb	r1, [r0, #0]
c0d05bec:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d05bee:	7044      	strb	r4, [r0, #1]
c0d05bf0:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d05bf2:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d05bf4:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d05bf6:	2140      	movs	r1, #64	; 0x40
c0d05bf8:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d05bfa:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d05bfc:	2106      	movs	r1, #6
c0d05bfe:	f7fd ffa7 	bl	c0d03b50 <io_seph_send>
  if (ep_addr & 0x80) {
c0d05c02:	2080      	movs	r0, #128	; 0x80
c0d05c04:	4205      	tst	r5, r0
c0d05c06:	d101      	bne.n	c0d05c0c <USBD_LL_StallEP+0x2c>
c0d05c08:	4807      	ldr	r0, [pc, #28]	; (c0d05c28 <USBD_LL_StallEP+0x48>)
c0d05c0a:	e000      	b.n	c0d05c0e <USBD_LL_StallEP+0x2e>
c0d05c0c:	4805      	ldr	r0, [pc, #20]	; (c0d05c24 <USBD_LL_StallEP+0x44>)
c0d05c0e:	6801      	ldr	r1, [r0, #0]
c0d05c10:	227f      	movs	r2, #127	; 0x7f
c0d05c12:	4015      	ands	r5, r2
c0d05c14:	2201      	movs	r2, #1
c0d05c16:	40aa      	lsls	r2, r5
c0d05c18:	430a      	orrs	r2, r1
c0d05c1a:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d05c1c:	4620      	mov	r0, r4
c0d05c1e:	b002      	add	sp, #8
c0d05c20:	bdb0      	pop	{r4, r5, r7, pc}
c0d05c22:	46c0      	nop			; (mov r8, r8)
c0d05c24:	20002330 	.word	0x20002330
c0d05c28:	20002334 	.word	0x20002334

c0d05c2c <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d05c2c:	b570      	push	{r4, r5, r6, lr}
c0d05c2e:	b082      	sub	sp, #8
c0d05c30:	460d      	mov	r5, r1
c0d05c32:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05c34:	2150      	movs	r1, #80	; 0x50
c0d05c36:	7001      	strb	r1, [r0, #0]
c0d05c38:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d05c3a:	7044      	strb	r4, [r0, #1]
c0d05c3c:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d05c3e:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d05c40:	70c5      	strb	r5, [r0, #3]
c0d05c42:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d05c44:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d05c46:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d05c48:	2106      	movs	r1, #6
c0d05c4a:	f7fd ff81 	bl	c0d03b50 <io_seph_send>
  if (ep_addr & 0x80) {
c0d05c4e:	4235      	tst	r5, r6
c0d05c50:	d101      	bne.n	c0d05c56 <USBD_LL_ClearStallEP+0x2a>
c0d05c52:	4807      	ldr	r0, [pc, #28]	; (c0d05c70 <USBD_LL_ClearStallEP+0x44>)
c0d05c54:	e000      	b.n	c0d05c58 <USBD_LL_ClearStallEP+0x2c>
c0d05c56:	4805      	ldr	r0, [pc, #20]	; (c0d05c6c <USBD_LL_ClearStallEP+0x40>)
c0d05c58:	6801      	ldr	r1, [r0, #0]
c0d05c5a:	227f      	movs	r2, #127	; 0x7f
c0d05c5c:	4015      	ands	r5, r2
c0d05c5e:	2201      	movs	r2, #1
c0d05c60:	40aa      	lsls	r2, r5
c0d05c62:	4391      	bics	r1, r2
c0d05c64:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d05c66:	4620      	mov	r0, r4
c0d05c68:	b002      	add	sp, #8
c0d05c6a:	bd70      	pop	{r4, r5, r6, pc}
c0d05c6c:	20002330 	.word	0x20002330
c0d05c70:	20002334 	.word	0x20002334

c0d05c74 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d05c74:	2080      	movs	r0, #128	; 0x80
c0d05c76:	4201      	tst	r1, r0
c0d05c78:	d001      	beq.n	c0d05c7e <USBD_LL_IsStallEP+0xa>
c0d05c7a:	4806      	ldr	r0, [pc, #24]	; (c0d05c94 <USBD_LL_IsStallEP+0x20>)
c0d05c7c:	e000      	b.n	c0d05c80 <USBD_LL_IsStallEP+0xc>
c0d05c7e:	4804      	ldr	r0, [pc, #16]	; (c0d05c90 <USBD_LL_IsStallEP+0x1c>)
c0d05c80:	6800      	ldr	r0, [r0, #0]
c0d05c82:	227f      	movs	r2, #127	; 0x7f
c0d05c84:	4011      	ands	r1, r2
c0d05c86:	2201      	movs	r2, #1
c0d05c88:	408a      	lsls	r2, r1
c0d05c8a:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d05c8c:	b2d0      	uxtb	r0, r2
c0d05c8e:	4770      	bx	lr
c0d05c90:	20002334 	.word	0x20002334
c0d05c94:	20002330 	.word	0x20002330

c0d05c98 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d05c98:	b510      	push	{r4, lr}
c0d05c9a:	b082      	sub	sp, #8
c0d05c9c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d05c9e:	224f      	movs	r2, #79	; 0x4f
c0d05ca0:	7002      	strb	r2, [r0, #0]
c0d05ca2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d05ca4:	7044      	strb	r4, [r0, #1]
c0d05ca6:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d05ca8:	7082      	strb	r2, [r0, #2]
c0d05caa:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d05cac:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d05cae:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d05cb0:	2105      	movs	r1, #5
c0d05cb2:	f7fd ff4d 	bl	c0d03b50 <io_seph_send>
  return USBD_OK; 
c0d05cb6:	4620      	mov	r0, r4
c0d05cb8:	b002      	add	sp, #8
c0d05cba:	bd10      	pop	{r4, pc}

c0d05cbc <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d05cbc:	b5b0      	push	{r4, r5, r7, lr}
c0d05cbe:	b082      	sub	sp, #8
c0d05cc0:	461c      	mov	r4, r3
c0d05cc2:	4615      	mov	r5, r2
c0d05cc4:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05cc6:	2250      	movs	r2, #80	; 0x50
c0d05cc8:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d05cca:	1ce2      	adds	r2, r4, #3
c0d05ccc:	0a13      	lsrs	r3, r2, #8
c0d05cce:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d05cd0:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d05cd2:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d05cd4:	2120      	movs	r1, #32
c0d05cd6:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d05cd8:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d05cda:	2106      	movs	r1, #6
c0d05cdc:	f7fd ff38 	bl	c0d03b50 <io_seph_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d05ce0:	4628      	mov	r0, r5
c0d05ce2:	4621      	mov	r1, r4
c0d05ce4:	f7fd ff34 	bl	c0d03b50 <io_seph_send>
c0d05ce8:	2000      	movs	r0, #0
  return USBD_OK;   
c0d05cea:	b002      	add	sp, #8
c0d05cec:	bdb0      	pop	{r4, r5, r7, pc}

c0d05cee <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d05cee:	b510      	push	{r4, lr}
c0d05cf0:	b082      	sub	sp, #8
c0d05cf2:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d05cf4:	2350      	movs	r3, #80	; 0x50
c0d05cf6:	7003      	strb	r3, [r0, #0]
c0d05cf8:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d05cfa:	7044      	strb	r4, [r0, #1]
c0d05cfc:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d05cfe:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d05d00:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d05d02:	2130      	movs	r1, #48	; 0x30
c0d05d04:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d05d06:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d05d08:	2106      	movs	r1, #6
c0d05d0a:	f7fd ff21 	bl	c0d03b50 <io_seph_send>
  return USBD_OK;   
c0d05d0e:	4620      	mov	r0, r4
c0d05d10:	b002      	add	sp, #8
c0d05d12:	bd10      	pop	{r4, pc}

c0d05d14 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d05d14:	b570      	push	{r4, r5, r6, lr}
c0d05d16:	4615      	mov	r5, r2
c0d05d18:	460e      	mov	r6, r1
c0d05d1a:	4604      	mov	r4, r0
c0d05d1c:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d05d1e:	2c00      	cmp	r4, #0
c0d05d20:	d00f      	beq.n	c0d05d42 <USBD_Init+0x2e>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d05d22:	21d4      	movs	r1, #212	; 0xd4
c0d05d24:	4620      	mov	r0, r4
c0d05d26:	f001 f87d 	bl	c0d06e24 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d05d2a:	2e00      	cmp	r6, #0
c0d05d2c:	d001      	beq.n	c0d05d32 <USBD_Init+0x1e>
  {
    pdev->pDesc = pdesc;
c0d05d2e:	20b0      	movs	r0, #176	; 0xb0
c0d05d30:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d05d32:	209c      	movs	r0, #156	; 0x9c
c0d05d34:	2101      	movs	r1, #1
c0d05d36:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d05d38:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d05d3a:	4620      	mov	r0, r4
c0d05d3c:	f7ff feca 	bl	c0d05ad4 <USBD_LL_Init>
c0d05d40:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d05d42:	b2c0      	uxtb	r0, r0
c0d05d44:	bd70      	pop	{r4, r5, r6, pc}

c0d05d46 <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d05d46:	b570      	push	{r4, r5, r6, lr}
c0d05d48:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d05d4a:	209c      	movs	r0, #156	; 0x9c
c0d05d4c:	2101      	movs	r1, #1
c0d05d4e:	5421      	strb	r1, [r4, r0]
c0d05d50:	20b3      	movs	r0, #179	; 0xb3
c0d05d52:	43c5      	mvns	r5, r0
c0d05d54:	462e      	mov	r6, r5
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d05d56:	4628      	mov	r0, r5
c0d05d58:	30b3      	adds	r0, #179	; 0xb3
c0d05d5a:	4370      	muls	r0, r6
c0d05d5c:	5820      	ldr	r0, [r4, r0]
c0d05d5e:	2800      	cmp	r0, #0
c0d05d60:	d006      	beq.n	c0d05d70 <USBD_DeInit+0x2a>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d05d62:	6840      	ldr	r0, [r0, #4]
c0d05d64:	f7fd fdb6 	bl	c0d038d4 <pic>
c0d05d68:	4602      	mov	r2, r0
c0d05d6a:	7921      	ldrb	r1, [r4, #4]
c0d05d6c:	4620      	mov	r0, r4
c0d05d6e:	4790      	blx	r2
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05d70:	3e08      	subs	r6, #8
c0d05d72:	4630      	mov	r0, r6
c0d05d74:	30cc      	adds	r0, #204	; 0xcc
c0d05d76:	d1ee      	bne.n	c0d05d56 <USBD_DeInit+0x10>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d05d78:	4620      	mov	r0, r4
c0d05d7a:	f7ff fee3 	bl	c0d05b44 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d05d7e:	4620      	mov	r0, r4
c0d05d80:	f7ff feb2 	bl	c0d05ae8 <USBD_LL_DeInit>
  
  return USBD_OK;
c0d05d84:	2000      	movs	r0, #0
c0d05d86:	bd70      	pop	{r4, r5, r6, pc}

c0d05d88 <USBD_RegisterClassForInterface>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d05d88:	2302      	movs	r3, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d05d8a:	2a00      	cmp	r2, #0
c0d05d8c:	d006      	beq.n	c0d05d9c <USBD_RegisterClassForInterface+0x14>
c0d05d8e:	2300      	movs	r3, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d05d90:	2802      	cmp	r0, #2
c0d05d92:	d803      	bhi.n	c0d05d9c <USBD_RegisterClassForInterface+0x14>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d05d94:	00c0      	lsls	r0, r0, #3
c0d05d96:	1808      	adds	r0, r1, r0
c0d05d98:	21b4      	movs	r1, #180	; 0xb4
c0d05d9a:	5042      	str	r2, [r0, r1]
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d05d9c:	b2d8      	uxtb	r0, r3
c0d05d9e:	4770      	bx	lr

c0d05da0 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d05da0:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d05da2:	f7ff feb3 	bl	c0d05b0c <USBD_LL_Start>
  
  return USBD_OK;  
c0d05da6:	2000      	movs	r0, #0
c0d05da8:	bd80      	pop	{r7, pc}

c0d05daa <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d05daa:	b570      	push	{r4, r5, r6, lr}
c0d05dac:	460c      	mov	r4, r1
c0d05dae:	4605      	mov	r5, r0
c0d05db0:	2600      	movs	r6, #0
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d05db2:	4628      	mov	r0, r5
c0d05db4:	4631      	mov	r1, r6
c0d05db6:	f000 f96c 	bl	c0d06092 <usbd_is_valid_intf>
c0d05dba:	2800      	cmp	r0, #0
c0d05dbc:	d00a      	beq.n	c0d05dd4 <USBD_SetClassConfig+0x2a>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d05dbe:	00f0      	lsls	r0, r6, #3
c0d05dc0:	1828      	adds	r0, r5, r0
c0d05dc2:	21b4      	movs	r1, #180	; 0xb4
c0d05dc4:	5840      	ldr	r0, [r0, r1]
c0d05dc6:	6800      	ldr	r0, [r0, #0]
c0d05dc8:	f7fd fd84 	bl	c0d038d4 <pic>
c0d05dcc:	4602      	mov	r2, r0
c0d05dce:	4628      	mov	r0, r5
c0d05dd0:	4621      	mov	r1, r4
c0d05dd2:	4790      	blx	r2

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05dd4:	1c76      	adds	r6, r6, #1
c0d05dd6:	2e03      	cmp	r6, #3
c0d05dd8:	d1eb      	bne.n	c0d05db2 <USBD_SetClassConfig+0x8>
    if(usbd_is_valid_intf(pdev, intf)) {
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
    }
  }

  return USBD_OK; 
c0d05dda:	2000      	movs	r0, #0
c0d05ddc:	bd70      	pop	{r4, r5, r6, pc}

c0d05dde <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d05dde:	b570      	push	{r4, r5, r6, lr}
c0d05de0:	460c      	mov	r4, r1
c0d05de2:	4605      	mov	r5, r0
c0d05de4:	2600      	movs	r6, #0
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d05de6:	4628      	mov	r0, r5
c0d05de8:	4631      	mov	r1, r6
c0d05dea:	f000 f952 	bl	c0d06092 <usbd_is_valid_intf>
c0d05dee:	2800      	cmp	r0, #0
c0d05df0:	d00a      	beq.n	c0d05e08 <USBD_ClrClassConfig+0x2a>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d05df2:	00f0      	lsls	r0, r6, #3
c0d05df4:	1828      	adds	r0, r5, r0
c0d05df6:	21b4      	movs	r1, #180	; 0xb4
c0d05df8:	5840      	ldr	r0, [r0, r1]
c0d05dfa:	6840      	ldr	r0, [r0, #4]
c0d05dfc:	f7fd fd6a 	bl	c0d038d4 <pic>
c0d05e00:	4602      	mov	r2, r0
c0d05e02:	4628      	mov	r0, r5
c0d05e04:	4621      	mov	r1, r4
c0d05e06:	4790      	blx	r2
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05e08:	1c76      	adds	r6, r6, #1
c0d05e0a:	2e03      	cmp	r6, #3
c0d05e0c:	d1eb      	bne.n	c0d05de6 <USBD_ClrClassConfig+0x8>
    if(usbd_is_valid_intf(pdev, intf)) {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
    }
  }
  return USBD_OK;
c0d05e0e:	2000      	movs	r0, #0
c0d05e10:	bd70      	pop	{r4, r5, r6, pc}

c0d05e12 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d05e12:	b5b0      	push	{r4, r5, r7, lr}
c0d05e14:	4604      	mov	r4, r0
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d05e16:	4625      	mov	r5, r4
c0d05e18:	35a8      	adds	r5, #168	; 0xa8
c0d05e1a:	4628      	mov	r0, r5
c0d05e1c:	f000 fb80 	bl	c0d06520 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d05e20:	2094      	movs	r0, #148	; 0x94
c0d05e22:	2101      	movs	r1, #1
c0d05e24:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d05e26:	20ae      	movs	r0, #174	; 0xae
c0d05e28:	5a20      	ldrh	r0, [r4, r0]
c0d05e2a:	2198      	movs	r1, #152	; 0x98
c0d05e2c:	5060      	str	r0, [r4, r1]
c0d05e2e:	20a8      	movs	r0, #168	; 0xa8
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d05e30:	5c21      	ldrb	r1, [r4, r0]
c0d05e32:	201f      	movs	r0, #31
c0d05e34:	4008      	ands	r0, r1
c0d05e36:	2802      	cmp	r0, #2
c0d05e38:	d008      	beq.n	c0d05e4c <USBD_LL_SetupStage+0x3a>
c0d05e3a:	2801      	cmp	r0, #1
c0d05e3c:	d00b      	beq.n	c0d05e56 <USBD_LL_SetupStage+0x44>
c0d05e3e:	2800      	cmp	r0, #0
c0d05e40:	d10e      	bne.n	c0d05e60 <USBD_LL_SetupStage+0x4e>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d05e42:	4620      	mov	r0, r4
c0d05e44:	4629      	mov	r1, r5
c0d05e46:	f000 f931 	bl	c0d060ac <USBD_StdDevReq>
c0d05e4a:	e00e      	b.n	c0d05e6a <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d05e4c:	4620      	mov	r0, r4
c0d05e4e:	4629      	mov	r1, r5
c0d05e50:	f000 fadd 	bl	c0d0640e <USBD_StdEPReq>
c0d05e54:	e009      	b.n	c0d05e6a <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d05e56:	4620      	mov	r0, r4
c0d05e58:	4629      	mov	r1, r5
c0d05e5a:	f000 fab4 	bl	c0d063c6 <USBD_StdItfReq>
c0d05e5e:	e004      	b.n	c0d05e6a <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d05e60:	2080      	movs	r0, #128	; 0x80
c0d05e62:	4001      	ands	r1, r0
c0d05e64:	4620      	mov	r0, r4
c0d05e66:	f7ff febb 	bl	c0d05be0 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d05e6a:	2000      	movs	r0, #0
c0d05e6c:	bdb0      	pop	{r4, r5, r7, pc}

c0d05e6e <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d05e6e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05e70:	b081      	sub	sp, #4
c0d05e72:	9200      	str	r2, [sp, #0]
c0d05e74:	460e      	mov	r6, r1
c0d05e76:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d05e78:	2e00      	cmp	r6, #0
c0d05e7a:	d01d      	beq.n	c0d05eb8 <USBD_LL_DataOutStage+0x4a>
c0d05e7c:	4625      	mov	r5, r4
c0d05e7e:	359c      	adds	r5, #156	; 0x9c
c0d05e80:	2700      	movs	r7, #0
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d05e82:	4620      	mov	r0, r4
c0d05e84:	4639      	mov	r1, r7
c0d05e86:	f000 f904 	bl	c0d06092 <usbd_is_valid_intf>
c0d05e8a:	2800      	cmp	r0, #0
c0d05e8c:	d010      	beq.n	c0d05eb0 <USBD_LL_DataOutStage+0x42>
c0d05e8e:	00f8      	lsls	r0, r7, #3
c0d05e90:	1820      	adds	r0, r4, r0
c0d05e92:	21b4      	movs	r1, #180	; 0xb4
c0d05e94:	5840      	ldr	r0, [r0, r1]
c0d05e96:	6980      	ldr	r0, [r0, #24]
c0d05e98:	2800      	cmp	r0, #0
c0d05e9a:	d009      	beq.n	c0d05eb0 <USBD_LL_DataOutStage+0x42>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d05e9c:	7829      	ldrb	r1, [r5, #0]
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d05e9e:	2903      	cmp	r1, #3
c0d05ea0:	d106      	bne.n	c0d05eb0 <USBD_LL_DataOutStage+0x42>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d05ea2:	f7fd fd17 	bl	c0d038d4 <pic>
c0d05ea6:	4603      	mov	r3, r0
c0d05ea8:	4620      	mov	r0, r4
c0d05eaa:	4631      	mov	r1, r6
c0d05eac:	9a00      	ldr	r2, [sp, #0]
c0d05eae:	4798      	blx	r3
    }
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05eb0:	1c7f      	adds	r7, r7, #1
c0d05eb2:	2f03      	cmp	r7, #3
c0d05eb4:	d1e5      	bne.n	c0d05e82 <USBD_LL_DataOutStage+0x14>
c0d05eb6:	e030      	b.n	c0d05f1a <USBD_LL_DataOutStage+0xac>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d05eb8:	2094      	movs	r0, #148	; 0x94
c0d05eba:	5820      	ldr	r0, [r4, r0]
c0d05ebc:	2803      	cmp	r0, #3
c0d05ebe:	d12c      	bne.n	c0d05f1a <USBD_LL_DataOutStage+0xac>
    {
      if(pep->rem_length > pep->maxpacket)
c0d05ec0:	6de1      	ldr	r1, [r4, #92]	; 0x5c
c0d05ec2:	6e20      	ldr	r0, [r4, #96]	; 0x60
c0d05ec4:	4281      	cmp	r1, r0
c0d05ec6:	d90a      	bls.n	c0d05ede <USBD_LL_DataOutStage+0x70>
      {
        pep->rem_length -=  pep->maxpacket;
c0d05ec8:	1a09      	subs	r1, r1, r0
c0d05eca:	65e1      	str	r1, [r4, #92]	; 0x5c
c0d05ecc:	4281      	cmp	r1, r0
c0d05ece:	d300      	bcc.n	c0d05ed2 <USBD_LL_DataOutStage+0x64>
c0d05ed0:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d05ed2:	b28a      	uxth	r2, r1
c0d05ed4:	4620      	mov	r0, r4
c0d05ed6:	9900      	ldr	r1, [sp, #0]
c0d05ed8:	f000 fdcf 	bl	c0d06a7a <USBD_CtlContinueRx>
c0d05edc:	e01d      	b.n	c0d05f1a <USBD_LL_DataOutStage+0xac>
c0d05ede:	4626      	mov	r6, r4
c0d05ee0:	369c      	adds	r6, #156	; 0x9c
c0d05ee2:	2500      	movs	r5, #0
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d05ee4:	4620      	mov	r0, r4
c0d05ee6:	4629      	mov	r1, r5
c0d05ee8:	f000 f8d3 	bl	c0d06092 <usbd_is_valid_intf>
c0d05eec:	2800      	cmp	r0, #0
c0d05eee:	d00e      	beq.n	c0d05f0e <USBD_LL_DataOutStage+0xa0>
c0d05ef0:	00e8      	lsls	r0, r5, #3
c0d05ef2:	1820      	adds	r0, r4, r0
c0d05ef4:	21b4      	movs	r1, #180	; 0xb4
c0d05ef6:	5840      	ldr	r0, [r0, r1]
c0d05ef8:	6900      	ldr	r0, [r0, #16]
c0d05efa:	2800      	cmp	r0, #0
c0d05efc:	d007      	beq.n	c0d05f0e <USBD_LL_DataOutStage+0xa0>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d05efe:	7831      	ldrb	r1, [r6, #0]
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d05f00:	2903      	cmp	r1, #3
c0d05f02:	d104      	bne.n	c0d05f0e <USBD_LL_DataOutStage+0xa0>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d05f04:	f7fd fce6 	bl	c0d038d4 <pic>
c0d05f08:	4601      	mov	r1, r0
c0d05f0a:	4620      	mov	r0, r4
c0d05f0c:	4788      	blx	r1
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        uint8_t intf;
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05f0e:	1c6d      	adds	r5, r5, #1
c0d05f10:	2d03      	cmp	r5, #3
c0d05f12:	d1e7      	bne.n	c0d05ee4 <USBD_LL_DataOutStage+0x76>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
          }
        }
        USBD_CtlSendStatus(pdev);
c0d05f14:	4620      	mov	r0, r4
c0d05f16:	f000 fdb7 	bl	c0d06a88 <USBD_CtlSendStatus>
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
      }
    }
  }  
  return USBD_OK;
c0d05f1a:	2000      	movs	r0, #0
c0d05f1c:	b001      	add	sp, #4
c0d05f1e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d05f20 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d05f20:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d05f22:	b081      	sub	sp, #4
c0d05f24:	460d      	mov	r5, r1
c0d05f26:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d05f28:	2d00      	cmp	r5, #0
c0d05f2a:	d01c      	beq.n	c0d05f66 <USBD_LL_DataInStage+0x46>
c0d05f2c:	4627      	mov	r7, r4
c0d05f2e:	379c      	adds	r7, #156	; 0x9c
c0d05f30:	2600      	movs	r6, #0
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d05f32:	4620      	mov	r0, r4
c0d05f34:	4631      	mov	r1, r6
c0d05f36:	f000 f8ac 	bl	c0d06092 <usbd_is_valid_intf>
c0d05f3a:	2800      	cmp	r0, #0
c0d05f3c:	d00f      	beq.n	c0d05f5e <USBD_LL_DataInStage+0x3e>
c0d05f3e:	00f0      	lsls	r0, r6, #3
c0d05f40:	1820      	adds	r0, r4, r0
c0d05f42:	21b4      	movs	r1, #180	; 0xb4
c0d05f44:	5840      	ldr	r0, [r0, r1]
c0d05f46:	6940      	ldr	r0, [r0, #20]
c0d05f48:	2800      	cmp	r0, #0
c0d05f4a:	d008      	beq.n	c0d05f5e <USBD_LL_DataInStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d05f4c:	7839      	ldrb	r1, [r7, #0]
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d05f4e:	2903      	cmp	r1, #3
c0d05f50:	d105      	bne.n	c0d05f5e <USBD_LL_DataInStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d05f52:	f7fd fcbf 	bl	c0d038d4 <pic>
c0d05f56:	4602      	mov	r2, r0
c0d05f58:	4620      	mov	r0, r4
c0d05f5a:	4629      	mov	r1, r5
c0d05f5c:	4790      	blx	r2
      pdev->dev_test_mode = 0;
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05f5e:	1c76      	adds	r6, r6, #1
c0d05f60:	2e03      	cmp	r6, #3
c0d05f62:	d1e6      	bne.n	c0d05f32 <USBD_LL_DataInStage+0x12>
c0d05f64:	e04e      	b.n	c0d06004 <USBD_LL_DataInStage+0xe4>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d05f66:	2094      	movs	r0, #148	; 0x94
c0d05f68:	5820      	ldr	r0, [r4, r0]
c0d05f6a:	2802      	cmp	r0, #2
c0d05f6c:	d143      	bne.n	c0d05ff6 <USBD_LL_DataInStage+0xd6>
    {
      if(pep->rem_length > pep->maxpacket)
c0d05f6e:	69e0      	ldr	r0, [r4, #28]
c0d05f70:	6a26      	ldr	r6, [r4, #32]
c0d05f72:	42b0      	cmp	r0, r6
c0d05f74:	d90a      	bls.n	c0d05f8c <USBD_LL_DataInStage+0x6c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d05f76:	1b80      	subs	r0, r0, r6
c0d05f78:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d05f7a:	22d0      	movs	r2, #208	; 0xd0
c0d05f7c:	58a1      	ldr	r1, [r4, r2]
c0d05f7e:	1989      	adds	r1, r1, r6
c0d05f80:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d05f82:	b282      	uxth	r2, r0
c0d05f84:	4620      	mov	r0, r4
c0d05f86:	f000 fd6a 	bl	c0d06a5e <USBD_CtlContinueSendData>
c0d05f8a:	e034      	b.n	c0d05ff6 <USBD_LL_DataInStage+0xd6>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d05f8c:	69a5      	ldr	r5, [r4, #24]
c0d05f8e:	4628      	mov	r0, r5
c0d05f90:	4631      	mov	r1, r6
c0d05f92:	f000 fe2b 	bl	c0d06bec <__aeabi_uidivmod>
c0d05f96:	42b5      	cmp	r5, r6
c0d05f98:	d30f      	bcc.n	c0d05fba <USBD_LL_DataInStage+0x9a>
c0d05f9a:	2900      	cmp	r1, #0
c0d05f9c:	d10d      	bne.n	c0d05fba <USBD_LL_DataInStage+0x9a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d05f9e:	2098      	movs	r0, #152	; 0x98
c0d05fa0:	5820      	ldr	r0, [r4, r0]
c0d05fa2:	4626      	mov	r6, r4
c0d05fa4:	3698      	adds	r6, #152	; 0x98
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d05fa6:	4285      	cmp	r5, r0
c0d05fa8:	d207      	bcs.n	c0d05fba <USBD_LL_DataInStage+0x9a>
c0d05faa:	2500      	movs	r5, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d05fac:	4620      	mov	r0, r4
c0d05fae:	4629      	mov	r1, r5
c0d05fb0:	462a      	mov	r2, r5
c0d05fb2:	f000 fd54 	bl	c0d06a5e <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d05fb6:	6035      	str	r5, [r6, #0]
c0d05fb8:	e01d      	b.n	c0d05ff6 <USBD_LL_DataInStage+0xd6>
c0d05fba:	4626      	mov	r6, r4
c0d05fbc:	369c      	adds	r6, #156	; 0x9c
c0d05fbe:	2500      	movs	r5, #0
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d05fc0:	4620      	mov	r0, r4
c0d05fc2:	4629      	mov	r1, r5
c0d05fc4:	f000 f865 	bl	c0d06092 <usbd_is_valid_intf>
c0d05fc8:	2800      	cmp	r0, #0
c0d05fca:	d00e      	beq.n	c0d05fea <USBD_LL_DataInStage+0xca>
c0d05fcc:	00e8      	lsls	r0, r5, #3
c0d05fce:	1820      	adds	r0, r4, r0
c0d05fd0:	21b4      	movs	r1, #180	; 0xb4
c0d05fd2:	5840      	ldr	r0, [r0, r1]
c0d05fd4:	68c0      	ldr	r0, [r0, #12]
c0d05fd6:	2800      	cmp	r0, #0
c0d05fd8:	d007      	beq.n	c0d05fea <USBD_LL_DataInStage+0xca>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d05fda:	7831      	ldrb	r1, [r6, #0]
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d05fdc:	2903      	cmp	r1, #3
c0d05fde:	d104      	bne.n	c0d05fea <USBD_LL_DataInStage+0xca>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d05fe0:	f7fd fc78 	bl	c0d038d4 <pic>
c0d05fe4:	4601      	mov	r1, r0
c0d05fe6:	4620      	mov	r0, r4
c0d05fe8:	4788      	blx	r1
          
        }
        else
        {
          uint8_t intf;
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d05fea:	1c6d      	adds	r5, r5, #1
c0d05fec:	2d03      	cmp	r5, #3
c0d05fee:	d1e7      	bne.n	c0d05fc0 <USBD_LL_DataInStage+0xa0>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
            {
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
            }
          }
          USBD_CtlReceiveStatus(pdev);
c0d05ff0:	4620      	mov	r0, r4
c0d05ff2:	f000 fd55 	bl	c0d06aa0 <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d05ff6:	20a0      	movs	r0, #160	; 0xa0
c0d05ff8:	5c20      	ldrb	r0, [r4, r0]
c0d05ffa:	34a0      	adds	r4, #160	; 0xa0
c0d05ffc:	2801      	cmp	r0, #1
c0d05ffe:	d101      	bne.n	c0d06004 <USBD_LL_DataInStage+0xe4>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d06000:	2000      	movs	r0, #0
c0d06002:	7020      	strb	r0, [r4, #0]
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
      }
    }
  }
  return USBD_OK;
c0d06004:	2000      	movs	r0, #0
c0d06006:	b001      	add	sp, #4
c0d06008:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0600a <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d0600a:	b5b0      	push	{r4, r5, r7, lr}
c0d0600c:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d0600e:	2040      	movs	r0, #64	; 0x40
c0d06010:	6620      	str	r0, [r4, #96]	; 0x60
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d06012:	6220      	str	r0, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d06014:	209c      	movs	r0, #156	; 0x9c
c0d06016:	2101      	movs	r1, #1
c0d06018:	5421      	strb	r1, [r4, r0]
c0d0601a:	2500      	movs	r5, #0
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if( usbd_is_valid_intf(pdev, intf))
c0d0601c:	4620      	mov	r0, r4
c0d0601e:	4629      	mov	r1, r5
c0d06020:	f000 f837 	bl	c0d06092 <usbd_is_valid_intf>
c0d06024:	2800      	cmp	r0, #0
c0d06026:	d00a      	beq.n	c0d0603e <USBD_LL_Reset+0x34>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d06028:	00e8      	lsls	r0, r5, #3
c0d0602a:	1820      	adds	r0, r4, r0
c0d0602c:	21b4      	movs	r1, #180	; 0xb4
c0d0602e:	5840      	ldr	r0, [r0, r1]
c0d06030:	6840      	ldr	r0, [r0, #4]
c0d06032:	f7fd fc4f 	bl	c0d038d4 <pic>
c0d06036:	4602      	mov	r2, r0
c0d06038:	7921      	ldrb	r1, [r4, #4]
c0d0603a:	4620      	mov	r0, r4
c0d0603c:	4790      	blx	r2
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d0603e:	1c6d      	adds	r5, r5, #1
c0d06040:	2d03      	cmp	r5, #3
c0d06042:	d1eb      	bne.n	c0d0601c <USBD_LL_Reset+0x12>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
    }
  }
  
  return USBD_OK;
c0d06044:	2000      	movs	r0, #0
c0d06046:	bdb0      	pop	{r4, r5, r7, pc}

c0d06048 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d06048:	7401      	strb	r1, [r0, #16]
c0d0604a:	2000      	movs	r0, #0
  return USBD_OK;
c0d0604c:	4770      	bx	lr

c0d0604e <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d0604e:	2000      	movs	r0, #0
c0d06050:	4770      	bx	lr

c0d06052 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d06052:	2000      	movs	r0, #0
c0d06054:	4770      	bx	lr

c0d06056 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d06056:	b5b0      	push	{r4, r5, r7, lr}
c0d06058:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d0605a:	209c      	movs	r0, #156	; 0x9c
c0d0605c:	5c20      	ldrb	r0, [r4, r0]
c0d0605e:	2803      	cmp	r0, #3
c0d06060:	d115      	bne.n	c0d0608e <USBD_LL_SOF+0x38>
c0d06062:	2500      	movs	r5, #0
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d06064:	4620      	mov	r0, r4
c0d06066:	4629      	mov	r1, r5
c0d06068:	f000 f813 	bl	c0d06092 <usbd_is_valid_intf>
c0d0606c:	2800      	cmp	r0, #0
c0d0606e:	d00b      	beq.n	c0d06088 <USBD_LL_SOF+0x32>
c0d06070:	00e8      	lsls	r0, r5, #3
c0d06072:	1820      	adds	r0, r4, r0
c0d06074:	21b4      	movs	r1, #180	; 0xb4
c0d06076:	5840      	ldr	r0, [r0, r1]
c0d06078:	69c0      	ldr	r0, [r0, #28]
c0d0607a:	2800      	cmp	r0, #0
c0d0607c:	d004      	beq.n	c0d06088 <USBD_LL_SOF+0x32>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d0607e:	f7fd fc29 	bl	c0d038d4 <pic>
c0d06082:	4601      	mov	r1, r0
c0d06084:	4620      	mov	r0, r4
c0d06086:	4788      	blx	r1
USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d06088:	1c6d      	adds	r5, r5, #1
c0d0608a:	2d03      	cmp	r5, #3
c0d0608c:	d1ea      	bne.n	c0d06064 <USBD_LL_SOF+0xe>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
      }
    }
  }
  return USBD_OK;
c0d0608e:	2000      	movs	r0, #0
c0d06090:	bdb0      	pop	{r4, r5, r7, pc}

c0d06092 <usbd_is_valid_intf>:

/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
c0d06092:	4602      	mov	r2, r0
c0d06094:	2000      	movs	r0, #0
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d06096:	2902      	cmp	r1, #2
c0d06098:	d807      	bhi.n	c0d060aa <usbd_is_valid_intf+0x18>
c0d0609a:	00c8      	lsls	r0, r1, #3
c0d0609c:	1810      	adds	r0, r2, r0
c0d0609e:	21b4      	movs	r1, #180	; 0xb4
c0d060a0:	5841      	ldr	r1, [r0, r1]
c0d060a2:	2001      	movs	r0, #1
c0d060a4:	2900      	cmp	r1, #0
c0d060a6:	d100      	bne.n	c0d060aa <usbd_is_valid_intf+0x18>
c0d060a8:	4608      	mov	r0, r1
c0d060aa:	4770      	bx	lr

c0d060ac <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d060ac:	b580      	push	{r7, lr}
c0d060ae:	784a      	ldrb	r2, [r1, #1]
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d060b0:	2a04      	cmp	r2, #4
c0d060b2:	dd08      	ble.n	c0d060c6 <USBD_StdDevReq+0x1a>
c0d060b4:	2a07      	cmp	r2, #7
c0d060b6:	dc0f      	bgt.n	c0d060d8 <USBD_StdDevReq+0x2c>
c0d060b8:	2a05      	cmp	r2, #5
c0d060ba:	d014      	beq.n	c0d060e6 <USBD_StdDevReq+0x3a>
c0d060bc:	2a06      	cmp	r2, #6
c0d060be:	d11b      	bne.n	c0d060f8 <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d060c0:	f000 f821 	bl	c0d06106 <USBD_GetDescriptor>
c0d060c4:	e01d      	b.n	c0d06102 <USBD_StdDevReq+0x56>
c0d060c6:	2a00      	cmp	r2, #0
c0d060c8:	d010      	beq.n	c0d060ec <USBD_StdDevReq+0x40>
c0d060ca:	2a01      	cmp	r2, #1
c0d060cc:	d017      	beq.n	c0d060fe <USBD_StdDevReq+0x52>
c0d060ce:	2a03      	cmp	r2, #3
c0d060d0:	d112      	bne.n	c0d060f8 <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d060d2:	f000 f933 	bl	c0d0633c <USBD_SetFeature>
c0d060d6:	e014      	b.n	c0d06102 <USBD_StdDevReq+0x56>
c0d060d8:	2a08      	cmp	r2, #8
c0d060da:	d00a      	beq.n	c0d060f2 <USBD_StdDevReq+0x46>
c0d060dc:	2a09      	cmp	r2, #9
c0d060de:	d10b      	bne.n	c0d060f8 <USBD_StdDevReq+0x4c>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d060e0:	f000 f8bc 	bl	c0d0625c <USBD_SetConfig>
c0d060e4:	e00d      	b.n	c0d06102 <USBD_StdDevReq+0x56>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d060e6:	f000 f894 	bl	c0d06212 <USBD_SetAddress>
c0d060ea:	e00a      	b.n	c0d06102 <USBD_StdDevReq+0x56>
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d060ec:	f000 f904 	bl	c0d062f8 <USBD_GetStatus>
c0d060f0:	e007      	b.n	c0d06102 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d060f2:	f000 f8ea 	bl	c0d062ca <USBD_GetConfig>
c0d060f6:	e004      	b.n	c0d06102 <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d060f8:	f000 fbe6 	bl	c0d068c8 <USBD_CtlError>
c0d060fc:	e001      	b.n	c0d06102 <USBD_StdDevReq+0x56>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d060fe:	f000 f93a 	bl	c0d06376 <USBD_ClrFeature>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d06102:	2000      	movs	r0, #0
c0d06104:	bd80      	pop	{r7, pc}

c0d06106 <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d06106:	b5b0      	push	{r4, r5, r7, lr}
c0d06108:	b082      	sub	sp, #8
c0d0610a:	460d      	mov	r5, r1
c0d0610c:	4604      	mov	r4, r0
c0d0610e:	a801      	add	r0, sp, #4
  uint16_t len = 0;
c0d06110:	2100      	movs	r1, #0
c0d06112:	8001      	strh	r1, [r0, #0]
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d06114:	886a      	ldrh	r2, [r5, #2]
c0d06116:	0a10      	lsrs	r0, r2, #8
c0d06118:	2805      	cmp	r0, #5
c0d0611a:	dc12      	bgt.n	c0d06142 <USBD_GetDescriptor+0x3c>
c0d0611c:	2801      	cmp	r0, #1
c0d0611e:	d01c      	beq.n	c0d0615a <USBD_GetDescriptor+0x54>
c0d06120:	2802      	cmp	r0, #2
c0d06122:	d024      	beq.n	c0d0616e <USBD_GetDescriptor+0x68>
c0d06124:	2803      	cmp	r0, #3
c0d06126:	d137      	bne.n	c0d06198 <USBD_GetDescriptor+0x92>
c0d06128:	b2d0      	uxtb	r0, r2
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d0612a:	2802      	cmp	r0, #2
c0d0612c:	dc39      	bgt.n	c0d061a2 <USBD_GetDescriptor+0x9c>
c0d0612e:	2800      	cmp	r0, #0
c0d06130:	d05f      	beq.n	c0d061f2 <USBD_GetDescriptor+0xec>
c0d06132:	2801      	cmp	r0, #1
c0d06134:	d065      	beq.n	c0d06202 <USBD_GetDescriptor+0xfc>
c0d06136:	2802      	cmp	r0, #2
c0d06138:	d12e      	bne.n	c0d06198 <USBD_GetDescriptor+0x92>
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d0613a:	20b0      	movs	r0, #176	; 0xb0
c0d0613c:	5820      	ldr	r0, [r4, r0]
c0d0613e:	68c0      	ldr	r0, [r0, #12]
c0d06140:	e00e      	b.n	c0d06160 <USBD_GetDescriptor+0x5a>
c0d06142:	2806      	cmp	r0, #6
c0d06144:	d01c      	beq.n	c0d06180 <USBD_GetDescriptor+0x7a>
c0d06146:	2807      	cmp	r0, #7
c0d06148:	d023      	beq.n	c0d06192 <USBD_GetDescriptor+0x8c>
c0d0614a:	280f      	cmp	r0, #15
c0d0614c:	d124      	bne.n	c0d06198 <USBD_GetDescriptor+0x92>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    if(pdev->pDesc->GetBOSDescriptor != NULL) {
c0d0614e:	20b0      	movs	r0, #176	; 0xb0
c0d06150:	5820      	ldr	r0, [r4, r0]
c0d06152:	69c0      	ldr	r0, [r0, #28]
c0d06154:	2800      	cmp	r0, #0
c0d06156:	d103      	bne.n	c0d06160 <USBD_GetDescriptor+0x5a>
c0d06158:	e01e      	b.n	c0d06198 <USBD_GetDescriptor+0x92>
      goto default_error;
    }
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d0615a:	20b0      	movs	r0, #176	; 0xb0
c0d0615c:	5820      	ldr	r0, [r4, r0]
c0d0615e:	6800      	ldr	r0, [r0, #0]
c0d06160:	f7fd fbb8 	bl	c0d038d4 <pic>
c0d06164:	4602      	mov	r2, r0
c0d06166:	7c20      	ldrb	r0, [r4, #16]
c0d06168:	a901      	add	r1, sp, #4
c0d0616a:	4790      	blx	r2
c0d0616c:	e02f      	b.n	c0d061ce <USBD_GetDescriptor+0xc8>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d0616e:	20b4      	movs	r0, #180	; 0xb4
c0d06170:	5820      	ldr	r0, [r4, r0]
c0d06172:	2800      	cmp	r0, #0
c0d06174:	d02c      	beq.n	c0d061d0 <USBD_GetDescriptor+0xca>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d06176:	7c21      	ldrb	r1, [r4, #16]
c0d06178:	2900      	cmp	r1, #0
c0d0617a:	d022      	beq.n	c0d061c2 <USBD_GetDescriptor+0xbc>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
        //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
      }
      else
      {
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d0617c:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d0617e:	e021      	b.n	c0d061c4 <USBD_GetDescriptor+0xbe>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d06180:	7c20      	ldrb	r0, [r4, #16]
c0d06182:	2800      	cmp	r0, #0
c0d06184:	d108      	bne.n	c0d06198 <USBD_GetDescriptor+0x92>
c0d06186:	20b4      	movs	r0, #180	; 0xb4
c0d06188:	5820      	ldr	r0, [r4, r0]
c0d0618a:	2800      	cmp	r0, #0
c0d0618c:	d004      	beq.n	c0d06198 <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d0618e:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d06190:	e018      	b.n	c0d061c4 <USBD_GetDescriptor+0xbe>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d06192:	7c20      	ldrb	r0, [r4, #16]
c0d06194:	2800      	cmp	r0, #0
c0d06196:	d00e      	beq.n	c0d061b6 <USBD_GetDescriptor+0xb0>
      goto default_error;
    }

  default: 
  default_error:
     USBD_CtlError(pdev , req);
c0d06198:	4620      	mov	r0, r4
c0d0619a:	4629      	mov	r1, r5
c0d0619c:	f000 fb94 	bl	c0d068c8 <USBD_CtlError>
c0d061a0:	e025      	b.n	c0d061ee <USBD_GetDescriptor+0xe8>
c0d061a2:	2803      	cmp	r0, #3
c0d061a4:	d029      	beq.n	c0d061fa <USBD_GetDescriptor+0xf4>
c0d061a6:	2804      	cmp	r0, #4
c0d061a8:	d02f      	beq.n	c0d0620a <USBD_GetDescriptor+0x104>
c0d061aa:	2805      	cmp	r0, #5
c0d061ac:	d1f4      	bne.n	c0d06198 <USBD_GetDescriptor+0x92>
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d061ae:	20b0      	movs	r0, #176	; 0xb0
c0d061b0:	5820      	ldr	r0, [r4, r0]
c0d061b2:	6980      	ldr	r0, [r0, #24]
c0d061b4:	e7d4      	b.n	c0d06160 <USBD_GetDescriptor+0x5a>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d061b6:	20b4      	movs	r0, #180	; 0xb4
c0d061b8:	5820      	ldr	r0, [r4, r0]
c0d061ba:	2800      	cmp	r0, #0
c0d061bc:	d0ec      	beq.n	c0d06198 <USBD_GetDescriptor+0x92>
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d061be:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d061c0:	e000      	b.n	c0d061c4 <USBD_GetDescriptor+0xbe>
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->interfacesClass[0].pClass != NULL) {
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
      {
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d061c2:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d061c4:	f7fd fb86 	bl	c0d038d4 <pic>
c0d061c8:	4601      	mov	r1, r0
c0d061ca:	a801      	add	r0, sp, #4
c0d061cc:	4788      	blx	r1
c0d061ce:	4601      	mov	r1, r0
c0d061d0:	a801      	add	r0, sp, #4
  default_error:
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d061d2:	8802      	ldrh	r2, [r0, #0]
c0d061d4:	2a00      	cmp	r2, #0
c0d061d6:	d00a      	beq.n	c0d061ee <USBD_GetDescriptor+0xe8>
c0d061d8:	88e8      	ldrh	r0, [r5, #6]
c0d061da:	2800      	cmp	r0, #0
c0d061dc:	d007      	beq.n	c0d061ee <USBD_GetDescriptor+0xe8>
  {
    
    len = MIN(len , req->wLength);
c0d061de:	4282      	cmp	r2, r0
c0d061e0:	d300      	bcc.n	c0d061e4 <USBD_GetDescriptor+0xde>
c0d061e2:	4602      	mov	r2, r0
c0d061e4:	a801      	add	r0, sp, #4
c0d061e6:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d061e8:	4620      	mov	r0, r4
c0d061ea:	f000 fc23 	bl	c0d06a34 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d061ee:	b002      	add	sp, #8
c0d061f0:	bdb0      	pop	{r4, r5, r7, pc}
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d061f2:	20b0      	movs	r0, #176	; 0xb0
c0d061f4:	5820      	ldr	r0, [r4, r0]
c0d061f6:	6840      	ldr	r0, [r0, #4]
c0d061f8:	e7b2      	b.n	c0d06160 <USBD_GetDescriptor+0x5a>
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d061fa:	20b0      	movs	r0, #176	; 0xb0
c0d061fc:	5820      	ldr	r0, [r4, r0]
c0d061fe:	6900      	ldr	r0, [r0, #16]
c0d06200:	e7ae      	b.n	c0d06160 <USBD_GetDescriptor+0x5a>
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d06202:	20b0      	movs	r0, #176	; 0xb0
c0d06204:	5820      	ldr	r0, [r4, r0]
c0d06206:	6880      	ldr	r0, [r0, #8]
c0d06208:	e7aa      	b.n	c0d06160 <USBD_GetDescriptor+0x5a>
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d0620a:	20b0      	movs	r0, #176	; 0xb0
c0d0620c:	5820      	ldr	r0, [r4, r0]
c0d0620e:	6940      	ldr	r0, [r0, #20]
c0d06210:	e7a6      	b.n	c0d06160 <USBD_GetDescriptor+0x5a>

c0d06212 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d06212:	b570      	push	{r4, r5, r6, lr}
c0d06214:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d06216:	8888      	ldrh	r0, [r1, #4]
c0d06218:	2800      	cmp	r0, #0
c0d0621a:	d10b      	bne.n	c0d06234 <USBD_SetAddress+0x22>
c0d0621c:	88c8      	ldrh	r0, [r1, #6]
c0d0621e:	2800      	cmp	r0, #0
c0d06220:	d108      	bne.n	c0d06234 <USBD_SetAddress+0x22>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d06222:	8848      	ldrh	r0, [r1, #2]
c0d06224:	267f      	movs	r6, #127	; 0x7f
c0d06226:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d06228:	209c      	movs	r0, #156	; 0x9c
c0d0622a:	5c20      	ldrb	r0, [r4, r0]
c0d0622c:	4625      	mov	r5, r4
c0d0622e:	359c      	adds	r5, #156	; 0x9c
c0d06230:	2803      	cmp	r0, #3
c0d06232:	d103      	bne.n	c0d0623c <USBD_SetAddress+0x2a>
c0d06234:	4620      	mov	r0, r4
c0d06236:	f000 fb47 	bl	c0d068c8 <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d0623a:	bd70      	pop	{r4, r5, r6, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d0623c:	209e      	movs	r0, #158	; 0x9e
c0d0623e:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d06240:	b2f1      	uxtb	r1, r6
c0d06242:	4620      	mov	r0, r4
c0d06244:	f7ff fd28 	bl	c0d05c98 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d06248:	4620      	mov	r0, r4
c0d0624a:	f000 fc1d 	bl	c0d06a88 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d0624e:	2002      	movs	r0, #2
c0d06250:	2101      	movs	r1, #1
c0d06252:	2e00      	cmp	r6, #0
c0d06254:	d100      	bne.n	c0d06258 <USBD_SetAddress+0x46>
c0d06256:	4608      	mov	r0, r1
c0d06258:	7028      	strb	r0, [r5, #0]
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d0625a:	bd70      	pop	{r4, r5, r6, pc}

c0d0625c <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0625c:	b570      	push	{r4, r5, r6, lr}
c0d0625e:	460d      	mov	r5, r1
c0d06260:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d06262:	78ae      	ldrb	r6, [r5, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d06264:	2e02      	cmp	r6, #2
c0d06266:	d21d      	bcs.n	c0d062a4 <USBD_SetConfig+0x48>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d06268:	209c      	movs	r0, #156	; 0x9c
c0d0626a:	5c21      	ldrb	r1, [r4, r0]
c0d0626c:	4620      	mov	r0, r4
c0d0626e:	309c      	adds	r0, #156	; 0x9c
c0d06270:	2903      	cmp	r1, #3
c0d06272:	d007      	beq.n	c0d06284 <USBD_SetConfig+0x28>
c0d06274:	2902      	cmp	r1, #2
c0d06276:	d115      	bne.n	c0d062a4 <USBD_SetConfig+0x48>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d06278:	2e00      	cmp	r6, #0
c0d0627a:	d022      	beq.n	c0d062c2 <USBD_SetConfig+0x66>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d0627c:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d0627e:	2103      	movs	r1, #3
c0d06280:	7001      	strb	r1, [r0, #0]
c0d06282:	e009      	b.n	c0d06298 <USBD_SetConfig+0x3c>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d06284:	2e00      	cmp	r6, #0
c0d06286:	d012      	beq.n	c0d062ae <USBD_SetConfig+0x52>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d06288:	6860      	ldr	r0, [r4, #4]
c0d0628a:	4286      	cmp	r6, r0
c0d0628c:	d019      	beq.n	c0d062c2 <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d0628e:	b2c1      	uxtb	r1, r0
c0d06290:	4620      	mov	r0, r4
c0d06292:	f7ff fda4 	bl	c0d05dde <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d06296:	6066      	str	r6, [r4, #4]
c0d06298:	4620      	mov	r0, r4
c0d0629a:	4631      	mov	r1, r6
c0d0629c:	f7ff fd85 	bl	c0d05daa <USBD_SetClassConfig>
c0d062a0:	2802      	cmp	r0, #2
c0d062a2:	d10e      	bne.n	c0d062c2 <USBD_SetConfig+0x66>
c0d062a4:	4620      	mov	r0, r4
c0d062a6:	4629      	mov	r1, r5
c0d062a8:	f000 fb0e 	bl	c0d068c8 <USBD_CtlError>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d062ac:	bd70      	pop	{r4, r5, r6, pc}
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d062ae:	2102      	movs	r1, #2
c0d062b0:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d062b2:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d062b4:	4620      	mov	r0, r4
c0d062b6:	4631      	mov	r1, r6
c0d062b8:	f7ff fd91 	bl	c0d05dde <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d062bc:	4620      	mov	r0, r4
c0d062be:	f000 fbe3 	bl	c0d06a88 <USBD_CtlSendStatus>
c0d062c2:	4620      	mov	r0, r4
c0d062c4:	f000 fbe0 	bl	c0d06a88 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d062c8:	bd70      	pop	{r4, r5, r6, pc}

c0d062ca <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d062ca:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d062cc:	88ca      	ldrh	r2, [r1, #6]
c0d062ce:	2a01      	cmp	r2, #1
c0d062d0:	d10a      	bne.n	c0d062e8 <USBD_GetConfig+0x1e>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d062d2:	229c      	movs	r2, #156	; 0x9c
c0d062d4:	5c82      	ldrb	r2, [r0, r2]
c0d062d6:	2a03      	cmp	r2, #3
c0d062d8:	d009      	beq.n	c0d062ee <USBD_GetConfig+0x24>
c0d062da:	2a02      	cmp	r2, #2
c0d062dc:	d104      	bne.n	c0d062e8 <USBD_GetConfig+0x1e>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d062de:	2100      	movs	r1, #0
c0d062e0:	6081      	str	r1, [r0, #8]
c0d062e2:	4601      	mov	r1, r0
c0d062e4:	3108      	adds	r1, #8
c0d062e6:	e003      	b.n	c0d062f0 <USBD_GetConfig+0x26>
c0d062e8:	f000 faee 	bl	c0d068c8 <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d062ec:	bd80      	pop	{r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d062ee:	1d01      	adds	r1, r0, #4
c0d062f0:	2201      	movs	r2, #1
c0d062f2:	f000 fb9f 	bl	c0d06a34 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d062f6:	bd80      	pop	{r7, pc}

c0d062f8 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d062f8:	b5b0      	push	{r4, r5, r7, lr}
c0d062fa:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d062fc:	209c      	movs	r0, #156	; 0x9c
c0d062fe:	5c20      	ldrb	r0, [r4, r0]
c0d06300:	22fe      	movs	r2, #254	; 0xfe
c0d06302:	4002      	ands	r2, r0
c0d06304:	2a02      	cmp	r2, #2
c0d06306:	d115      	bne.n	c0d06334 <USBD_GetStatus+0x3c>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d06308:	2001      	movs	r0, #1
c0d0630a:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d0630c:	20a4      	movs	r0, #164	; 0xa4
c0d0630e:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d06310:	4625      	mov	r5, r4
c0d06312:	350c      	adds	r5, #12
c0d06314:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d06316:	2900      	cmp	r1, #0
c0d06318:	d005      	beq.n	c0d06326 <USBD_GetStatus+0x2e>
c0d0631a:	4620      	mov	r0, r4
c0d0631c:	f000 fbc0 	bl	c0d06aa0 <USBD_CtlReceiveStatus>
c0d06320:	68e1      	ldr	r1, [r4, #12]
c0d06322:	2002      	movs	r0, #2
c0d06324:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d06326:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d06328:	2202      	movs	r2, #2
c0d0632a:	4620      	mov	r0, r4
c0d0632c:	4629      	mov	r1, r5
c0d0632e:	f000 fb81 	bl	c0d06a34 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d06332:	bdb0      	pop	{r4, r5, r7, pc}
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d06334:	4620      	mov	r0, r4
c0d06336:	f000 fac7 	bl	c0d068c8 <USBD_CtlError>
    break;
  }
}
c0d0633a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0633c <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d0633c:	b5b0      	push	{r4, r5, r7, lr}
c0d0633e:	460d      	mov	r5, r1
c0d06340:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d06342:	8868      	ldrh	r0, [r5, #2]
c0d06344:	2801      	cmp	r0, #1
c0d06346:	d115      	bne.n	c0d06374 <USBD_SetFeature+0x38>
  {
    pdev->dev_remote_wakeup = 1;  
c0d06348:	20a4      	movs	r0, #164	; 0xa4
c0d0634a:	2101      	movs	r1, #1
c0d0634c:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0634e:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d06350:	2802      	cmp	r0, #2
c0d06352:	d80c      	bhi.n	c0d0636e <USBD_SetFeature+0x32>
c0d06354:	00c0      	lsls	r0, r0, #3
c0d06356:	1820      	adds	r0, r4, r0
c0d06358:	21b4      	movs	r1, #180	; 0xb4
c0d0635a:	5840      	ldr	r0, [r0, r1]
{

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
  {
    pdev->dev_remote_wakeup = 1;  
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d0635c:	2800      	cmp	r0, #0
c0d0635e:	d006      	beq.n	c0d0636e <USBD_SetFeature+0x32>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d06360:	6880      	ldr	r0, [r0, #8]
c0d06362:	f7fd fab7 	bl	c0d038d4 <pic>
c0d06366:	4602      	mov	r2, r0
c0d06368:	4620      	mov	r0, r4
c0d0636a:	4629      	mov	r1, r5
c0d0636c:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d0636e:	4620      	mov	r0, r4
c0d06370:	f000 fb8a 	bl	c0d06a88 <USBD_CtlSendStatus>
  }

}
c0d06374:	bdb0      	pop	{r4, r5, r7, pc}

c0d06376 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d06376:	b5b0      	push	{r4, r5, r7, lr}
c0d06378:	460d      	mov	r5, r1
c0d0637a:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d0637c:	209c      	movs	r0, #156	; 0x9c
c0d0637e:	5c20      	ldrb	r0, [r4, r0]
c0d06380:	21fe      	movs	r1, #254	; 0xfe
c0d06382:	4001      	ands	r1, r0
c0d06384:	2902      	cmp	r1, #2
c0d06386:	d119      	bne.n	c0d063bc <USBD_ClrFeature+0x46>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d06388:	8868      	ldrh	r0, [r5, #2]
c0d0638a:	2801      	cmp	r0, #1
c0d0638c:	d11a      	bne.n	c0d063c4 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d0638e:	20a4      	movs	r0, #164	; 0xa4
c0d06390:	2100      	movs	r1, #0
c0d06392:	5021      	str	r1, [r4, r0]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d06394:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d06396:	2802      	cmp	r0, #2
c0d06398:	d80c      	bhi.n	c0d063b4 <USBD_ClrFeature+0x3e>
c0d0639a:	00c0      	lsls	r0, r0, #3
c0d0639c:	1820      	adds	r0, r4, r0
c0d0639e:	21b4      	movs	r1, #180	; 0xb4
c0d063a0:	5840      	ldr	r0, [r0, r1]
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
    {
      pdev->dev_remote_wakeup = 0; 
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d063a2:	2800      	cmp	r0, #0
c0d063a4:	d006      	beq.n	c0d063b4 <USBD_ClrFeature+0x3e>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d063a6:	6880      	ldr	r0, [r0, #8]
c0d063a8:	f7fd fa94 	bl	c0d038d4 <pic>
c0d063ac:	4602      	mov	r2, r0
c0d063ae:	4620      	mov	r0, r4
c0d063b0:	4629      	mov	r1, r5
c0d063b2:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d063b4:	4620      	mov	r0, r4
c0d063b6:	f000 fb67 	bl	c0d06a88 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d063ba:	bdb0      	pop	{r4, r5, r7, pc}
      USBD_CtlSendStatus(pdev);
    }
    break;
    
  default :
     USBD_CtlError(pdev , req);
c0d063bc:	4620      	mov	r0, r4
c0d063be:	4629      	mov	r1, r5
c0d063c0:	f000 fa82 	bl	c0d068c8 <USBD_CtlError>
    break;
  }
}
c0d063c4:	bdb0      	pop	{r4, r5, r7, pc}

c0d063c6 <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d063c6:	b5b0      	push	{r4, r5, r7, lr}
c0d063c8:	460d      	mov	r5, r1
c0d063ca:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d063cc:	209c      	movs	r0, #156	; 0x9c
c0d063ce:	5c20      	ldrb	r0, [r4, r0]
c0d063d0:	2803      	cmp	r0, #3
c0d063d2:	d116      	bne.n	c0d06402 <USBD_StdItfReq+0x3c>
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d063d4:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d063d6:	2802      	cmp	r0, #2
c0d063d8:	d813      	bhi.n	c0d06402 <USBD_StdItfReq+0x3c>
c0d063da:	00c0      	lsls	r0, r0, #3
c0d063dc:	1820      	adds	r0, r4, r0
c0d063de:	21b4      	movs	r1, #180	; 0xb4
c0d063e0:	5840      	ldr	r0, [r0, r1]
  
  switch (pdev->dev_state) 
  {
  case USBD_STATE_CONFIGURED:
    
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d063e2:	2800      	cmp	r0, #0
c0d063e4:	d00d      	beq.n	c0d06402 <USBD_StdItfReq+0x3c>
    {
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d063e6:	6880      	ldr	r0, [r0, #8]
c0d063e8:	f7fd fa74 	bl	c0d038d4 <pic>
c0d063ec:	4602      	mov	r2, r0
c0d063ee:	4620      	mov	r0, r4
c0d063f0:	4629      	mov	r1, r5
c0d063f2:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d063f4:	88e8      	ldrh	r0, [r5, #6]
c0d063f6:	2800      	cmp	r0, #0
c0d063f8:	d107      	bne.n	c0d0640a <USBD_StdItfReq+0x44>
      {
         USBD_CtlSendStatus(pdev);
c0d063fa:	4620      	mov	r0, r4
c0d063fc:	f000 fb44 	bl	c0d06a88 <USBD_CtlSendStatus>
c0d06400:	e003      	b.n	c0d0640a <USBD_StdItfReq+0x44>
c0d06402:	4620      	mov	r0, r4
c0d06404:	4629      	mov	r1, r5
c0d06406:	f000 fa5f 	bl	c0d068c8 <USBD_CtlError>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d0640a:	2000      	movs	r0, #0
c0d0640c:	bdb0      	pop	{r4, r5, r7, pc}

c0d0640e <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0640e:	b570      	push	{r4, r5, r6, lr}
c0d06410:	460d      	mov	r5, r1
c0d06412:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d06414:	7828      	ldrb	r0, [r5, #0]
c0d06416:	2160      	movs	r1, #96	; 0x60
c0d06418:	4001      	ands	r1, r0
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d0641a:	792e      	ldrb	r6, [r5, #4]
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d0641c:	2920      	cmp	r1, #32
c0d0641e:	d10f      	bne.n	c0d06440 <USBD_StdEPReq+0x32>
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d06420:	2e02      	cmp	r6, #2
c0d06422:	d80d      	bhi.n	c0d06440 <USBD_StdEPReq+0x32>
c0d06424:	00f0      	lsls	r0, r6, #3
c0d06426:	1820      	adds	r0, r4, r0
c0d06428:	21b4      	movs	r1, #180	; 0xb4
c0d0642a:	5840      	ldr	r0, [r0, r1]
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d0642c:	2800      	cmp	r0, #0
c0d0642e:	d007      	beq.n	c0d06440 <USBD_StdEPReq+0x32>
  {
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d06430:	6880      	ldr	r0, [r0, #8]
c0d06432:	f7fd fa4f 	bl	c0d038d4 <pic>
c0d06436:	4602      	mov	r2, r0
c0d06438:	4620      	mov	r0, r4
c0d0643a:	4629      	mov	r1, r5
c0d0643c:	4790      	blx	r2
c0d0643e:	e06d      	b.n	c0d0651c <USBD_StdEPReq+0x10e>
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d06440:	7868      	ldrb	r0, [r5, #1]
c0d06442:	2800      	cmp	r0, #0
c0d06444:	d017      	beq.n	c0d06476 <USBD_StdEPReq+0x68>
c0d06446:	2801      	cmp	r0, #1
c0d06448:	d01e      	beq.n	c0d06488 <USBD_StdEPReq+0x7a>
c0d0644a:	2803      	cmp	r0, #3
c0d0644c:	d166      	bne.n	c0d0651c <USBD_StdEPReq+0x10e>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d0644e:	209c      	movs	r0, #156	; 0x9c
c0d06450:	5c20      	ldrb	r0, [r4, r0]
c0d06452:	2803      	cmp	r0, #3
c0d06454:	d11c      	bne.n	c0d06490 <USBD_StdEPReq+0x82>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d06456:	8868      	ldrh	r0, [r5, #2]
c0d06458:	2800      	cmp	r0, #0
c0d0645a:	d108      	bne.n	c0d0646e <USBD_StdEPReq+0x60>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d0645c:	2080      	movs	r0, #128	; 0x80
c0d0645e:	4330      	orrs	r0, r6
c0d06460:	2880      	cmp	r0, #128	; 0x80
c0d06462:	d004      	beq.n	c0d0646e <USBD_StdEPReq+0x60>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d06464:	4620      	mov	r0, r4
c0d06466:	4631      	mov	r1, r6
c0d06468:	f7ff fbba 	bl	c0d05be0 <USBD_LL_StallEP>
          
        }
c0d0646c:	792e      	ldrb	r6, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0646e:	2e02      	cmp	r6, #2
c0d06470:	d851      	bhi.n	c0d06516 <USBD_StdEPReq+0x108>
c0d06472:	00f0      	lsls	r0, r6, #3
c0d06474:	e043      	b.n	c0d064fe <USBD_StdEPReq+0xf0>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d06476:	209c      	movs	r0, #156	; 0x9c
c0d06478:	5c20      	ldrb	r0, [r4, r0]
c0d0647a:	2803      	cmp	r0, #3
c0d0647c:	d018      	beq.n	c0d064b0 <USBD_StdEPReq+0xa2>
c0d0647e:	2802      	cmp	r0, #2
c0d06480:	d111      	bne.n	c0d064a6 <USBD_StdEPReq+0x98>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d06482:	0670      	lsls	r0, r6, #25
c0d06484:	d10a      	bne.n	c0d0649c <USBD_StdEPReq+0x8e>
c0d06486:	e049      	b.n	c0d0651c <USBD_StdEPReq+0x10e>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d06488:	209c      	movs	r0, #156	; 0x9c
c0d0648a:	5c20      	ldrb	r0, [r4, r0]
c0d0648c:	2803      	cmp	r0, #3
c0d0648e:	d029      	beq.n	c0d064e4 <USBD_StdEPReq+0xd6>
c0d06490:	2802      	cmp	r0, #2
c0d06492:	d108      	bne.n	c0d064a6 <USBD_StdEPReq+0x98>
c0d06494:	2080      	movs	r0, #128	; 0x80
c0d06496:	4330      	orrs	r0, r6
c0d06498:	2880      	cmp	r0, #128	; 0x80
c0d0649a:	d03f      	beq.n	c0d0651c <USBD_StdEPReq+0x10e>
c0d0649c:	4620      	mov	r0, r4
c0d0649e:	4631      	mov	r1, r6
c0d064a0:	f7ff fb9e 	bl	c0d05be0 <USBD_LL_StallEP>
c0d064a4:	e03a      	b.n	c0d0651c <USBD_StdEPReq+0x10e>
c0d064a6:	4620      	mov	r0, r4
c0d064a8:	4629      	mov	r1, r5
c0d064aa:	f000 fa0d 	bl	c0d068c8 <USBD_CtlError>
c0d064ae:	e035      	b.n	c0d0651c <USBD_StdEPReq+0x10e>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d064b0:	4625      	mov	r5, r4
c0d064b2:	3514      	adds	r5, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d064b4:	4620      	mov	r0, r4
c0d064b6:	3054      	adds	r0, #84	; 0x54
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d064b8:	2180      	movs	r1, #128	; 0x80
c0d064ba:	420e      	tst	r6, r1
c0d064bc:	d100      	bne.n	c0d064c0 <USBD_StdEPReq+0xb2>
c0d064be:	4605      	mov	r5, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d064c0:	4620      	mov	r0, r4
c0d064c2:	4631      	mov	r1, r6
c0d064c4:	f7ff fbd6 	bl	c0d05c74 <USBD_LL_IsStallEP>
c0d064c8:	2101      	movs	r1, #1
c0d064ca:	2800      	cmp	r0, #0
c0d064cc:	d100      	bne.n	c0d064d0 <USBD_StdEPReq+0xc2>
c0d064ce:	4601      	mov	r1, r0
c0d064d0:	207f      	movs	r0, #127	; 0x7f
c0d064d2:	4006      	ands	r6, r0
c0d064d4:	0130      	lsls	r0, r6, #4
c0d064d6:	5029      	str	r1, [r5, r0]
c0d064d8:	1829      	adds	r1, r5, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d064da:	2202      	movs	r2, #2
c0d064dc:	4620      	mov	r0, r4
c0d064de:	f000 faa9 	bl	c0d06a34 <USBD_CtlSendData>
c0d064e2:	e01b      	b.n	c0d0651c <USBD_StdEPReq+0x10e>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d064e4:	8868      	ldrh	r0, [r5, #2]
c0d064e6:	2800      	cmp	r0, #0
c0d064e8:	d118      	bne.n	c0d0651c <USBD_StdEPReq+0x10e>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d064ea:	0670      	lsls	r0, r6, #25
c0d064ec:	d013      	beq.n	c0d06516 <USBD_StdEPReq+0x108>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d064ee:	4620      	mov	r0, r4
c0d064f0:	4631      	mov	r1, r6
c0d064f2:	f7ff fb9b 	bl	c0d05c2c <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d064f6:	7928      	ldrb	r0, [r5, #4]
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d064f8:	2802      	cmp	r0, #2
c0d064fa:	d80c      	bhi.n	c0d06516 <USBD_StdEPReq+0x108>
c0d064fc:	00c0      	lsls	r0, r0, #3
c0d064fe:	1820      	adds	r0, r4, r0
c0d06500:	21b4      	movs	r1, #180	; 0xb4
c0d06502:	5840      	ldr	r0, [r0, r1]
c0d06504:	2800      	cmp	r0, #0
c0d06506:	d006      	beq.n	c0d06516 <USBD_StdEPReq+0x108>
c0d06508:	6880      	ldr	r0, [r0, #8]
c0d0650a:	f7fd f9e3 	bl	c0d038d4 <pic>
c0d0650e:	4602      	mov	r2, r0
c0d06510:	4620      	mov	r0, r4
c0d06512:	4629      	mov	r1, r5
c0d06514:	4790      	blx	r2
c0d06516:	4620      	mov	r0, r4
c0d06518:	f000 fab6 	bl	c0d06a88 <USBD_CtlSendStatus>
    
  default:
    break;
  }
  return ret;
}
c0d0651c:	2000      	movs	r0, #0
c0d0651e:	bd70      	pop	{r4, r5, r6, pc}

c0d06520 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d06520:	780a      	ldrb	r2, [r1, #0]
c0d06522:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d06524:	784a      	ldrb	r2, [r1, #1]
c0d06526:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d06528:	788a      	ldrb	r2, [r1, #2]
c0d0652a:	78cb      	ldrb	r3, [r1, #3]
c0d0652c:	021b      	lsls	r3, r3, #8
c0d0652e:	4313      	orrs	r3, r2
c0d06530:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d06532:	790a      	ldrb	r2, [r1, #4]
c0d06534:	794b      	ldrb	r3, [r1, #5]
c0d06536:	021b      	lsls	r3, r3, #8
c0d06538:	4313      	orrs	r3, r2
c0d0653a:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d0653c:	798a      	ldrb	r2, [r1, #6]
c0d0653e:	79c9      	ldrb	r1, [r1, #7]
c0d06540:	0209      	lsls	r1, r1, #8
c0d06542:	4311      	orrs	r1, r2
c0d06544:	80c1      	strh	r1, [r0, #6]

}
c0d06546:	4770      	bx	lr

c0d06548 <USBD_CtlStall>:
* @param  pdev: device instance
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
c0d06548:	b510      	push	{r4, lr}
c0d0654a:	4604      	mov	r4, r0
  USBD_LL_StallEP(pdev , 0x80);
c0d0654c:	2180      	movs	r1, #128	; 0x80
c0d0654e:	f7ff fb47 	bl	c0d05be0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d06552:	2100      	movs	r1, #0
c0d06554:	4620      	mov	r0, r4
c0d06556:	f7ff fb43 	bl	c0d05be0 <USBD_LL_StallEP>
}
c0d0655a:	bd10      	pop	{r4, pc}

c0d0655c <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0655c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0655e:	b083      	sub	sp, #12
c0d06560:	460d      	mov	r5, r1
c0d06562:	4604      	mov	r4, r0
c0d06564:	a802      	add	r0, sp, #8
c0d06566:	2700      	movs	r7, #0
  uint16_t len = 0;
c0d06568:	8007      	strh	r7, [r0, #0]
c0d0656a:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d0656c:	7007      	strb	r7, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0656e:	7829      	ldrb	r1, [r5, #0]
c0d06570:	2060      	movs	r0, #96	; 0x60
c0d06572:	4008      	ands	r0, r1
c0d06574:	2800      	cmp	r0, #0
c0d06576:	d010      	beq.n	c0d0659a <USBD_HID_Setup+0x3e>
c0d06578:	2820      	cmp	r0, #32
c0d0657a:	d138      	bne.n	c0d065ee <USBD_HID_Setup+0x92>
c0d0657c:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d0657e:	4601      	mov	r1, r0
c0d06580:	390a      	subs	r1, #10
c0d06582:	2902      	cmp	r1, #2
c0d06584:	d333      	bcc.n	c0d065ee <USBD_HID_Setup+0x92>
c0d06586:	2802      	cmp	r0, #2
c0d06588:	d01c      	beq.n	c0d065c4 <USBD_HID_Setup+0x68>
c0d0658a:	2803      	cmp	r0, #3
c0d0658c:	d01a      	beq.n	c0d065c4 <USBD_HID_Setup+0x68>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d0658e:	4620      	mov	r0, r4
c0d06590:	4629      	mov	r1, r5
c0d06592:	f000 f999 	bl	c0d068c8 <USBD_CtlError>
c0d06596:	2702      	movs	r7, #2
c0d06598:	e029      	b.n	c0d065ee <USBD_HID_Setup+0x92>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d0659a:	7868      	ldrb	r0, [r5, #1]
c0d0659c:	280b      	cmp	r0, #11
c0d0659e:	d014      	beq.n	c0d065ca <USBD_HID_Setup+0x6e>
c0d065a0:	280a      	cmp	r0, #10
c0d065a2:	d00f      	beq.n	c0d065c4 <USBD_HID_Setup+0x68>
c0d065a4:	2806      	cmp	r0, #6
c0d065a6:	d122      	bne.n	c0d065ee <USBD_HID_Setup+0x92>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d065a8:	8868      	ldrh	r0, [r5, #2]
c0d065aa:	0a00      	lsrs	r0, r0, #8
c0d065ac:	2700      	movs	r7, #0
c0d065ae:	2821      	cmp	r0, #33	; 0x21
c0d065b0:	d00f      	beq.n	c0d065d2 <USBD_HID_Setup+0x76>
c0d065b2:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d065b4:	463a      	mov	r2, r7
c0d065b6:	4639      	mov	r1, r7
c0d065b8:	d116      	bne.n	c0d065e8 <USBD_HID_Setup+0x8c>
c0d065ba:	ae02      	add	r6, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d065bc:	4630      	mov	r0, r6
c0d065be:	f000 f857 	bl	c0d06670 <USBD_HID_GetReportDescriptor_impl>
c0d065c2:	e00a      	b.n	c0d065da <USBD_HID_Setup+0x7e>
c0d065c4:	a901      	add	r1, sp, #4
c0d065c6:	2201      	movs	r2, #1
c0d065c8:	e00e      	b.n	c0d065e8 <USBD_HID_Setup+0x8c>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d065ca:	4620      	mov	r0, r4
c0d065cc:	f000 fa5c 	bl	c0d06a88 <USBD_CtlSendStatus>
c0d065d0:	e00d      	b.n	c0d065ee <USBD_HID_Setup+0x92>
c0d065d2:	ae02      	add	r6, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d065d4:	4630      	mov	r0, r6
c0d065d6:	f000 f831 	bl	c0d0663c <USBD_HID_GetHidDescriptor_impl>
c0d065da:	4601      	mov	r1, r0
c0d065dc:	8832      	ldrh	r2, [r6, #0]
c0d065de:	88e8      	ldrh	r0, [r5, #6]
c0d065e0:	4282      	cmp	r2, r0
c0d065e2:	d300      	bcc.n	c0d065e6 <USBD_HID_Setup+0x8a>
c0d065e4:	4602      	mov	r2, r0
c0d065e6:	8032      	strh	r2, [r6, #0]
c0d065e8:	4620      	mov	r0, r4
c0d065ea:	f000 fa23 	bl	c0d06a34 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d065ee:	b2f8      	uxtb	r0, r7
c0d065f0:	b003      	add	sp, #12
c0d065f2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d065f4 <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d065f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d065f6:	b081      	sub	sp, #4
c0d065f8:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d065fa:	2182      	movs	r1, #130	; 0x82
c0d065fc:	2603      	movs	r6, #3
c0d065fe:	2540      	movs	r5, #64	; 0x40
c0d06600:	4632      	mov	r2, r6
c0d06602:	462b      	mov	r3, r5
c0d06604:	f7ff fab0 	bl	c0d05b68 <USBD_LL_OpenEP>
c0d06608:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0660a:	4620      	mov	r0, r4
c0d0660c:	4639      	mov	r1, r7
c0d0660e:	4632      	mov	r2, r6
c0d06610:	462b      	mov	r3, r5
c0d06612:	f7ff faa9 	bl	c0d05b68 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d06616:	4620      	mov	r0, r4
c0d06618:	4639      	mov	r1, r7
c0d0661a:	462a      	mov	r2, r5
c0d0661c:	f7ff fb67 	bl	c0d05cee <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d06620:	2000      	movs	r0, #0
c0d06622:	b001      	add	sp, #4
c0d06624:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d06626 <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d06626:	b510      	push	{r4, lr}
c0d06628:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d0662a:	2182      	movs	r1, #130	; 0x82
c0d0662c:	f7ff fac2 	bl	c0d05bb4 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d06630:	2102      	movs	r1, #2
c0d06632:	4620      	mov	r0, r4
c0d06634:	f7ff fabe 	bl	c0d05bb4 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d06638:	2000      	movs	r0, #0
c0d0663a:	bd10      	pop	{r4, pc}

c0d0663c <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  switch (USBD_Device.request.wIndex&0xFF) {
c0d0663c:	21ac      	movs	r1, #172	; 0xac
c0d0663e:	4a09      	ldr	r2, [pc, #36]	; (c0d06664 <USBD_HID_GetHidDescriptor_impl+0x28>)
c0d06640:	5c51      	ldrb	r1, [r2, r1]
c0d06642:	2209      	movs	r2, #9
c0d06644:	2900      	cmp	r1, #0
c0d06646:	d004      	beq.n	c0d06652 <USBD_HID_GetHidDescriptor_impl+0x16>
c0d06648:	2901      	cmp	r1, #1
c0d0664a:	d105      	bne.n	c0d06658 <USBD_HID_GetHidDescriptor_impl+0x1c>
c0d0664c:	4907      	ldr	r1, [pc, #28]	; (c0d0666c <USBD_HID_GetHidDescriptor_impl+0x30>)
c0d0664e:	4479      	add	r1, pc
c0d06650:	e004      	b.n	c0d0665c <USBD_HID_GetHidDescriptor_impl+0x20>
c0d06652:	4905      	ldr	r1, [pc, #20]	; (c0d06668 <USBD_HID_GetHidDescriptor_impl+0x2c>)
c0d06654:	4479      	add	r1, pc
c0d06656:	e001      	b.n	c0d0665c <USBD_HID_GetHidDescriptor_impl+0x20>
c0d06658:	2200      	movs	r2, #0
c0d0665a:	4611      	mov	r1, r2
c0d0665c:	8002      	strh	r2, [r0, #0]
      *len = sizeof(USBD_HID_Desc);
      return (uint8_t*)USBD_HID_Desc; 
  }
  *len = 0;
  return 0;
}
c0d0665e:	4608      	mov	r0, r1
c0d06660:	4770      	bx	lr
c0d06662:	46c0      	nop			; (mov r8, r8)
c0d06664:	20002338 	.word	0x20002338
c0d06668:	000011fc 	.word	0x000011fc
c0d0666c:	000011f6 	.word	0x000011f6

c0d06670 <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d06670:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d06672:	b081      	sub	sp, #4
c0d06674:	4602      	mov	r2, r0
  switch (USBD_Device.request.wIndex&0xFF) {
c0d06676:	20ac      	movs	r0, #172	; 0xac
c0d06678:	4913      	ldr	r1, [pc, #76]	; (c0d066c8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d0667a:	5c08      	ldrb	r0, [r1, r0]
c0d0667c:	2422      	movs	r4, #34	; 0x22
c0d0667e:	2800      	cmp	r0, #0
c0d06680:	d01a      	beq.n	c0d066b8 <USBD_HID_GetReportDescriptor_impl+0x48>
c0d06682:	2801      	cmp	r0, #1
c0d06684:	d11b      	bne.n	c0d066be <USBD_HID_GetReportDescriptor_impl+0x4e>
#ifdef HAVE_IO_U2F
  case U2F_INTF:

    // very dirty work due to lack of callback when USB_HID_Init is called
    USBD_LL_OpenEP(&USBD_Device,
c0d06686:	4810      	ldr	r0, [pc, #64]	; (c0d066c8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d06688:	2181      	movs	r1, #129	; 0x81
c0d0668a:	2703      	movs	r7, #3
c0d0668c:	2640      	movs	r6, #64	; 0x40
c0d0668e:	9200      	str	r2, [sp, #0]
c0d06690:	463a      	mov	r2, r7
c0d06692:	4633      	mov	r3, r6
c0d06694:	f7ff fa68 	bl	c0d05b68 <USBD_LL_OpenEP>
c0d06698:	2501      	movs	r5, #1
                   U2F_EPIN_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPIN_SIZE);
    
    USBD_LL_OpenEP(&USBD_Device,
c0d0669a:	480b      	ldr	r0, [pc, #44]	; (c0d066c8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d0669c:	4629      	mov	r1, r5
c0d0669e:	463a      	mov	r2, r7
c0d066a0:	4633      	mov	r3, r6
c0d066a2:	f7ff fa61 	bl	c0d05b68 <USBD_LL_OpenEP>
                   U2F_EPOUT_ADDR,
                   USBD_EP_TYPE_INTR,
                   U2F_EPOUT_SIZE);

    /* Prepare Out endpoint to receive 1st packet */ 
    USBD_LL_PrepareReceive(&USBD_Device, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d066a6:	4808      	ldr	r0, [pc, #32]	; (c0d066c8 <USBD_HID_GetReportDescriptor_impl+0x58>)
c0d066a8:	4629      	mov	r1, r5
c0d066aa:	4632      	mov	r2, r6
c0d066ac:	f7ff fb1f 	bl	c0d05cee <USBD_LL_PrepareReceive>
c0d066b0:	9a00      	ldr	r2, [sp, #0]
c0d066b2:	4807      	ldr	r0, [pc, #28]	; (c0d066d0 <USBD_HID_GetReportDescriptor_impl+0x60>)
c0d066b4:	4478      	add	r0, pc
c0d066b6:	e004      	b.n	c0d066c2 <USBD_HID_GetReportDescriptor_impl+0x52>
c0d066b8:	4804      	ldr	r0, [pc, #16]	; (c0d066cc <USBD_HID_GetReportDescriptor_impl+0x5c>)
c0d066ba:	4478      	add	r0, pc
c0d066bc:	e001      	b.n	c0d066c2 <USBD_HID_GetReportDescriptor_impl+0x52>
c0d066be:	2400      	movs	r4, #0
c0d066c0:	4620      	mov	r0, r4
c0d066c2:	8014      	strh	r4, [r2, #0]
    *len = sizeof(HID_ReportDesc);
    return (uint8_t*)HID_ReportDesc;
  }
  *len = 0;
  return 0;
}
c0d066c4:	b001      	add	sp, #4
c0d066c6:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d066c8:	20002338 	.word	0x20002338
c0d066cc:	000011c1 	.word	0x000011c1
c0d066d0:	000011a5 	.word	0x000011a5

c0d066d4 <USBD_U2F_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_U2F_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d066d4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d066d6:	b081      	sub	sp, #4
c0d066d8:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d066da:	2181      	movs	r1, #129	; 0x81
c0d066dc:	2603      	movs	r6, #3
c0d066de:	2540      	movs	r5, #64	; 0x40
c0d066e0:	4632      	mov	r2, r6
c0d066e2:	462b      	mov	r3, r5
c0d066e4:	f7ff fa40 	bl	c0d05b68 <USBD_LL_OpenEP>
c0d066e8:	2701      	movs	r7, #1
                 U2F_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d066ea:	4620      	mov	r0, r4
c0d066ec:	4639      	mov	r1, r7
c0d066ee:	4632      	mov	r2, r6
c0d066f0:	462b      	mov	r3, r5
c0d066f2:	f7ff fa39 	bl	c0d05b68 <USBD_LL_OpenEP>
                 U2F_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 U2F_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR, U2F_EPOUT_SIZE);
c0d066f6:	4620      	mov	r0, r4
c0d066f8:	4639      	mov	r1, r7
c0d066fa:	462a      	mov	r2, r5
c0d066fc:	f7ff faf7 	bl	c0d05cee <USBD_LL_PrepareReceive>

  return USBD_OK;
c0d06700:	2000      	movs	r0, #0
c0d06702:	b001      	add	sp, #4
c0d06704:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d06708 <USBD_U2F_DataIn_impl>:
}

uint8_t  USBD_U2F_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d06708:	b580      	push	{r7, lr}
  UNUSED(pdev);
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d0670a:	2901      	cmp	r1, #1
c0d0670c:	d103      	bne.n	c0d06716 <USBD_U2F_DataIn_impl+0xe>
  // FIDO endpoint
  case (U2F_EPIN_ADDR&0x7F):
    // advance the u2f sending machine state
    u2f_transport_sent(&G_io_u2f, U2F_MEDIA_USB);
c0d0670e:	4803      	ldr	r0, [pc, #12]	; (c0d0671c <USBD_U2F_DataIn_impl+0x14>)
c0d06710:	2101      	movs	r1, #1
c0d06712:	f7fd fdd1 	bl	c0d042b8 <u2f_transport_sent>
    break;
  } 
  return USBD_OK;
c0d06716:	2000      	movs	r0, #0
c0d06718:	bd80      	pop	{r7, pc}
c0d0671a:	46c0      	nop			; (mov r8, r8)
c0d0671c:	20002130 	.word	0x20002130

c0d06720 <USBD_U2F_DataOut_impl>:
}

uint8_t  USBD_U2F_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d06720:	b5b0      	push	{r4, r5, r7, lr}
c0d06722:	4614      	mov	r4, r2
  switch (epnum) {
c0d06724:	2901      	cmp	r1, #1
c0d06726:	d10d      	bne.n	c0d06744 <USBD_U2F_DataOut_impl+0x24>
c0d06728:	2501      	movs	r5, #1
  // FIDO endpoint
  case (U2F_EPOUT_ADDR&0x7F):
      USBD_LL_PrepareReceive(pdev, U2F_EPOUT_ADDR , U2F_EPOUT_SIZE);
c0d0672a:	2240      	movs	r2, #64	; 0x40
c0d0672c:	4629      	mov	r1, r5
c0d0672e:	f7ff fade 	bl	c0d05cee <USBD_LL_PrepareReceive>
      u2f_transport_received(&G_io_u2f, buffer, io_seproxyhal_get_ep_rx_size(U2F_EPOUT_ADDR), U2F_MEDIA_USB);
c0d06732:	4628      	mov	r0, r5
c0d06734:	f7fc fbcc 	bl	c0d02ed0 <io_seproxyhal_get_ep_rx_size>
c0d06738:	4602      	mov	r2, r0
c0d0673a:	4803      	ldr	r0, [pc, #12]	; (c0d06748 <USBD_U2F_DataOut_impl+0x28>)
c0d0673c:	4621      	mov	r1, r4
c0d0673e:	462b      	mov	r3, r5
c0d06740:	f7fd ff22 	bl	c0d04588 <u2f_transport_received>
    break;
  }

  return USBD_OK;
c0d06744:	2000      	movs	r0, #0
c0d06746:	bdb0      	pop	{r4, r5, r7, pc}
c0d06748:	20002130 	.word	0x20002130

c0d0674c <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d0674c:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d0674e:	2902      	cmp	r1, #2
c0d06750:	d103      	bne.n	c0d0675a <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d06752:	4803      	ldr	r0, [pc, #12]	; (c0d06760 <USBD_HID_DataIn_impl+0x14>)
c0d06754:	4478      	add	r0, pc
c0d06756:	f7fd f845 	bl	c0d037e4 <io_usb_hid_sent>
      break;
  }

  return USBD_OK;
c0d0675a:	2000      	movs	r0, #0
c0d0675c:	bd80      	pop	{r7, pc}
c0d0675e:	46c0      	nop			; (mov r8, r8)
c0d06760:	ffffc849 	.word	0xffffc849

c0d06764 <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d06764:	b5b0      	push	{r4, r5, r7, lr}
c0d06766:	4614      	mov	r4, r2
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d06768:	2902      	cmp	r1, #2
c0d0676a:	d119      	bne.n	c0d067a0 <USBD_HID_DataOut_impl+0x3c>

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d0676c:	2102      	movs	r1, #2
c0d0676e:	2240      	movs	r2, #64	; 0x40
c0d06770:	f7ff fabd 	bl	c0d05cee <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d06774:	4d0b      	ldr	r5, [pc, #44]	; (c0d067a4 <USBD_HID_DataOut_impl+0x40>)
c0d06776:	79a8      	ldrb	r0, [r5, #6]
c0d06778:	2800      	cmp	r0, #0
c0d0677a:	d111      	bne.n	c0d067a0 <USBD_HID_DataOut_impl+0x3c>
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d0677c:	2002      	movs	r0, #2
c0d0677e:	f7fc fba7 	bl	c0d02ed0 <io_seproxyhal_get_ep_rx_size>
c0d06782:	4602      	mov	r2, r0
c0d06784:	4809      	ldr	r0, [pc, #36]	; (c0d067ac <USBD_HID_DataOut_impl+0x48>)
c0d06786:	4478      	add	r0, pc
c0d06788:	4621      	mov	r1, r4
c0d0678a:	f7fc ff6d 	bl	c0d03668 <io_usb_hid_receive>
c0d0678e:	2802      	cmp	r0, #2
c0d06790:	d106      	bne.n	c0d067a0 <USBD_HID_DataOut_impl+0x3c>
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d06792:	2001      	movs	r0, #1
c0d06794:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d06796:	2007      	movs	r0, #7
c0d06798:	7028      	strb	r0, [r5, #0]
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d0679a:	4803      	ldr	r0, [pc, #12]	; (c0d067a8 <USBD_HID_DataOut_impl+0x44>)
c0d0679c:	6800      	ldr	r0, [r0, #0]
c0d0679e:	8068      	strh	r0, [r5, #2]
      }
    }
    break;
  }

  return USBD_OK;
c0d067a0:	2000      	movs	r0, #0
c0d067a2:	bdb0      	pop	{r4, r5, r7, pc}
c0d067a4:	20002110 	.word	0x20002110
c0d067a8:	200021b8 	.word	0x200021b8
c0d067ac:	ffffc817 	.word	0xffffc817

c0d067b0 <USBD_WEBUSB_Init>:

#ifdef HAVE_WEBUSB

uint8_t  USBD_WEBUSB_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d067b0:	b570      	push	{r4, r5, r6, lr}
c0d067b2:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d067b4:	2183      	movs	r1, #131	; 0x83
c0d067b6:	2503      	movs	r5, #3
c0d067b8:	2640      	movs	r6, #64	; 0x40
c0d067ba:	462a      	mov	r2, r5
c0d067bc:	4633      	mov	r3, r6
c0d067be:	f7ff f9d3 	bl	c0d05b68 <USBD_LL_OpenEP>
                 WEBUSB_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d067c2:	4620      	mov	r0, r4
c0d067c4:	4629      	mov	r1, r5
c0d067c6:	462a      	mov	r2, r5
c0d067c8:	4633      	mov	r3, r6
c0d067ca:	f7ff f9cd 	bl	c0d05b68 <USBD_LL_OpenEP>
                 WEBUSB_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d067ce:	4620      	mov	r0, r4
c0d067d0:	4629      	mov	r1, r5
c0d067d2:	4632      	mov	r2, r6
c0d067d4:	f7ff fa8b 	bl	c0d05cee <USBD_LL_PrepareReceive>

  return USBD_OK;
c0d067d8:	2000      	movs	r0, #0
c0d067da:	bd70      	pop	{r4, r5, r6, pc}

c0d067dc <USBD_WEBUSB_DeInit>:

uint8_t  USBD_WEBUSB_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx) {
  UNUSED(pdev);
  UNUSED(cfgidx);
  return USBD_OK;
c0d067dc:	2000      	movs	r0, #0
c0d067de:	4770      	bx	lr

c0d067e0 <USBD_WEBUSB_Setup>:
uint8_t  USBD_WEBUSB_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
  UNUSED(pdev);
  UNUSED(req);
  return USBD_OK;
c0d067e0:	2000      	movs	r0, #0
c0d067e2:	4770      	bx	lr

c0d067e4 <USBD_WEBUSB_DataIn>:
}

uint8_t  USBD_WEBUSB_DataIn (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d067e4:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d067e6:	2903      	cmp	r1, #3
c0d067e8:	d103      	bne.n	c0d067f2 <USBD_WEBUSB_DataIn+0xe>
    // HID gen endpoint
    case (WEBUSB_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data_ep0x83);
c0d067ea:	4803      	ldr	r0, [pc, #12]	; (c0d067f8 <USBD_WEBUSB_DataIn+0x14>)
c0d067ec:	4478      	add	r0, pc
c0d067ee:	f7fc fff9 	bl	c0d037e4 <io_usb_hid_sent>
      break;
  }
  return USBD_OK;
c0d067f2:	2000      	movs	r0, #0
c0d067f4:	bd80      	pop	{r7, pc}
c0d067f6:	46c0      	nop			; (mov r8, r8)
c0d067f8:	ffffc7c1 	.word	0xffffc7c1

c0d067fc <USBD_WEBUSB_DataOut>:
}

uint8_t USBD_WEBUSB_DataOut (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d067fc:	b5b0      	push	{r4, r5, r7, lr}
c0d067fe:	4614      	mov	r4, r2
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d06800:	2903      	cmp	r1, #3
c0d06802:	d119      	bne.n	c0d06838 <USBD_WEBUSB_DataOut+0x3c>

  // HID gen endpoint
  case (WEBUSB_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d06804:	2103      	movs	r1, #3
c0d06806:	2240      	movs	r2, #64	; 0x40
c0d06808:	f7ff fa71 	bl	c0d05cee <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d0680c:	4d0b      	ldr	r5, [pc, #44]	; (c0d0683c <USBD_WEBUSB_DataOut+0x40>)
c0d0680e:	79a8      	ldrb	r0, [r5, #6]
c0d06810:	2800      	cmp	r0, #0
c0d06812:	d111      	bne.n	c0d06838 <USBD_WEBUSB_DataOut+0x3c>
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
c0d06814:	2003      	movs	r0, #3
c0d06816:	f7fc fb5b 	bl	c0d02ed0 <io_seproxyhal_get_ep_rx_size>
c0d0681a:	4602      	mov	r2, r0
c0d0681c:	4809      	ldr	r0, [pc, #36]	; (c0d06844 <USBD_WEBUSB_DataOut+0x48>)
c0d0681e:	4478      	add	r0, pc
c0d06820:	4621      	mov	r1, r4
c0d06822:	f7fc ff21 	bl	c0d03668 <io_usb_hid_receive>
c0d06826:	2802      	cmp	r0, #2
c0d06828:	d106      	bne.n	c0d06838 <USBD_WEBUSB_DataOut+0x3c>
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
c0d0682a:	2005      	movs	r0, #5
c0d0682c:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
c0d0682e:	200b      	movs	r0, #11
c0d06830:	7028      	strb	r0, [r5, #0]
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d06832:	4803      	ldr	r0, [pc, #12]	; (c0d06840 <USBD_WEBUSB_DataOut+0x44>)
c0d06834:	6800      	ldr	r0, [r0, #0]
c0d06836:	8068      	strh	r0, [r5, #2]
      }
    }
    break;
  }

  return USBD_OK;
c0d06838:	2000      	movs	r0, #0
c0d0683a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0683c:	20002110 	.word	0x20002110
c0d06840:	200021b8 	.word	0x200021b8
c0d06844:	ffffc78f 	.word	0xffffc78f

c0d06848 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d06848:	2012      	movs	r0, #18
c0d0684a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d0684c:	4801      	ldr	r0, [pc, #4]	; (c0d06854 <USBD_DeviceDescriptor+0xc>)
c0d0684e:	4478      	add	r0, pc
c0d06850:	4770      	bx	lr
c0d06852:	46c0      	nop			; (mov r8, r8)
c0d06854:	000012d2 	.word	0x000012d2

c0d06858 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d06858:	2004      	movs	r0, #4
c0d0685a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d0685c:	4801      	ldr	r0, [pc, #4]	; (c0d06864 <USBD_LangIDStrDescriptor+0xc>)
c0d0685e:	4478      	add	r0, pc
c0d06860:	4770      	bx	lr
c0d06862:	46c0      	nop			; (mov r8, r8)
c0d06864:	000012d4 	.word	0x000012d4

c0d06868 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d06868:	200e      	movs	r0, #14
c0d0686a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d0686c:	4801      	ldr	r0, [pc, #4]	; (c0d06874 <USBD_ManufacturerStrDescriptor+0xc>)
c0d0686e:	4478      	add	r0, pc
c0d06870:	4770      	bx	lr
c0d06872:	46c0      	nop			; (mov r8, r8)
c0d06874:	000012c8 	.word	0x000012c8

c0d06878 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d06878:	200e      	movs	r0, #14
c0d0687a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d0687c:	4801      	ldr	r0, [pc, #4]	; (c0d06884 <USBD_ProductStrDescriptor+0xc>)
c0d0687e:	4478      	add	r0, pc
c0d06880:	4770      	bx	lr
c0d06882:	46c0      	nop			; (mov r8, r8)
c0d06884:	000012c6 	.word	0x000012c6

c0d06888 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d06888:	200a      	movs	r0, #10
c0d0688a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d0688c:	4801      	ldr	r0, [pc, #4]	; (c0d06894 <USBD_SerialStrDescriptor+0xc>)
c0d0688e:	4478      	add	r0, pc
c0d06890:	4770      	bx	lr
c0d06892:	46c0      	nop			; (mov r8, r8)
c0d06894:	000012c4 	.word	0x000012c4

c0d06898 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d06898:	200e      	movs	r0, #14
c0d0689a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d0689c:	4801      	ldr	r0, [pc, #4]	; (c0d068a4 <USBD_ConfigStrDescriptor+0xc>)
c0d0689e:	4478      	add	r0, pc
c0d068a0:	4770      	bx	lr
c0d068a2:	46c0      	nop			; (mov r8, r8)
c0d068a4:	000012a6 	.word	0x000012a6

c0d068a8 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d068a8:	200e      	movs	r0, #14
c0d068aa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d068ac:	4801      	ldr	r0, [pc, #4]	; (c0d068b4 <USBD_InterfaceStrDescriptor+0xc>)
c0d068ae:	4478      	add	r0, pc
c0d068b0:	4770      	bx	lr
c0d068b2:	46c0      	nop			; (mov r8, r8)
c0d068b4:	00001296 	.word	0x00001296

c0d068b8 <USBD_BOSDescriptor>:

static uint8_t *USBD_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
#ifdef HAVE_WEBUSB
  *length = sizeof(C_usb_bos);
c0d068b8:	2039      	movs	r0, #57	; 0x39
c0d068ba:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)C_usb_bos;
c0d068bc:	4801      	ldr	r0, [pc, #4]	; (c0d068c4 <USBD_BOSDescriptor+0xc>)
c0d068be:	4478      	add	r0, pc
c0d068c0:	4770      	bx	lr
c0d068c2:	46c0      	nop			; (mov r8, r8)
c0d068c4:	00000fdf 	.word	0x00000fdf

c0d068c8 <USBD_CtlError>:
  '4', 0x00, '6', 0x00, '7', 0x00, '6', 0x00, '5', 0x00, '7', 0x00,
  '2', 0x00, '}', 0x00, 0x00, 0x00, 0x00, 0x00 // propertyData, double unicode nul terminated
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
c0d068c8:	b580      	push	{r7, lr}
    USBD_CtlSendData (pdev, (unsigned char*)C_webusb_url_descriptor, MIN(req->wLength, sizeof(C_webusb_url_descriptor)));
  }
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
c0d068ca:	780a      	ldrb	r2, [r1, #0]
c0d068cc:	b252      	sxtb	r2, r2
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
c0d068ce:	2a00      	cmp	r2, #0
c0d068d0:	db02      	blt.n	c0d068d8 <USBD_CtlError+0x10>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
c0d068d2:	f7ff fe39 	bl	c0d06548 <USBD_CtlStall>
  }
}
c0d068d6:	bd80      	pop	{r7, pc}
  }
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
c0d068d8:	784a      	ldrb	r2, [r1, #1]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
c0d068da:	2a77      	cmp	r2, #119	; 0x77
c0d068dc:	d00f      	beq.n	c0d068fe <USBD_CtlError+0x36>
c0d068de:	2a06      	cmp	r2, #6
c0d068e0:	d1f7      	bne.n	c0d068d2 <USBD_CtlError+0xa>
c0d068e2:	884a      	ldrh	r2, [r1, #2]
    && (req->wValue & 0xFF) == 0xEE) {
c0d068e4:	4b19      	ldr	r3, [pc, #100]	; (c0d0694c <USBD_CtlError+0x84>)
c0d068e6:	429a      	cmp	r2, r3
c0d068e8:	d1f3      	bne.n	c0d068d2 <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
c0d068ea:	88ca      	ldrh	r2, [r1, #6]
c0d068ec:	2112      	movs	r1, #18
c0d068ee:	2a12      	cmp	r2, #18
c0d068f0:	d300      	bcc.n	c0d068f4 <USBD_CtlError+0x2c>
c0d068f2:	460a      	mov	r2, r1
c0d068f4:	4916      	ldr	r1, [pc, #88]	; (c0d06950 <USBD_CtlError+0x88>)
c0d068f6:	4479      	add	r1, pc
c0d068f8:	f000 f89c 	bl	c0d06a34 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d068fc:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
c0d068fe:	888a      	ldrh	r2, [r1, #4]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
    && (req->wValue & 0xFF) == 0xEE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
  }
  // SETUP (LE): 0x80 0x77 0x04 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d06900:	2a04      	cmp	r2, #4
c0d06902:	d109      	bne.n	c0d06918 <USBD_CtlError+0x50>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
c0d06904:	88ca      	ldrh	r2, [r1, #6]
c0d06906:	2128      	movs	r1, #40	; 0x28
c0d06908:	2a28      	cmp	r2, #40	; 0x28
c0d0690a:	d300      	bcc.n	c0d0690e <USBD_CtlError+0x46>
c0d0690c:	460a      	mov	r2, r1
c0d0690e:	4911      	ldr	r1, [pc, #68]	; (c0d06954 <USBD_CtlError+0x8c>)
c0d06910:	4479      	add	r1, pc
c0d06912:	f000 f88f 	bl	c0d06a34 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d06916:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
c0d06918:	888a      	ldrh	r2, [r1, #4]
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
  }
  // SETUP (LE): 0x80 0x77 0x05 0x00 0x00 0x00 0xXX 0xXX
  else if ((req->bmRequest & 0x80) 
c0d0691a:	2a05      	cmp	r2, #5
c0d0691c:	d109      	bne.n	c0d06932 <USBD_CtlError+0x6a>
    && req->bRequest == WINUSB_VENDOR_CODE 
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
c0d0691e:	88ca      	ldrh	r2, [r1, #6]
c0d06920:	2192      	movs	r1, #146	; 0x92
c0d06922:	2a92      	cmp	r2, #146	; 0x92
c0d06924:	d300      	bcc.n	c0d06928 <USBD_CtlError+0x60>
c0d06926:	460a      	mov	r2, r1
c0d06928:	490b      	ldr	r1, [pc, #44]	; (c0d06958 <USBD_CtlError+0x90>)
c0d0692a:	4479      	add	r1, pc
c0d0692c:	f000 f882 	bl	c0d06a34 <USBD_CtlSendData>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d06930:	bd80      	pop	{r7, pc}
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
c0d06932:	888a      	ldrh	r2, [r1, #4]
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
  ) {        
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
  }
  // Microsoft OS 2.0 Descriptors for Windows 8.1 and Windows 10
  else if ((req->bmRequest & 0x80)
c0d06934:	2a07      	cmp	r2, #7
c0d06936:	d1cc      	bne.n	c0d068d2 <USBD_CtlError+0xa>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
c0d06938:	88ca      	ldrh	r2, [r1, #6]
c0d0693a:	21b2      	movs	r1, #178	; 0xb2
c0d0693c:	2ab2      	cmp	r2, #178	; 0xb2
c0d0693e:	d300      	bcc.n	c0d06942 <USBD_CtlError+0x7a>
c0d06940:	460a      	mov	r2, r1
c0d06942:	4906      	ldr	r1, [pc, #24]	; (c0d0695c <USBD_CtlError+0x94>)
c0d06944:	4479      	add	r1, pc
c0d06946:	f000 f875 	bl	c0d06a34 <USBD_CtlSendData>
  }
  else {
    USBD_CtlStall(pdev);
  }
}
c0d0694a:	bd80      	pop	{r7, pc}
c0d0694c:	000003ee 	.word	0x000003ee
c0d06950:	00001002 	.word	0x00001002
c0d06954:	00000ffa 	.word	0x00000ffa
c0d06958:	00001008 	.word	0x00001008
c0d0695c:	00001080 	.word	0x00001080

c0d06960 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d06960:	b570      	push	{r4, r5, r6, lr}
c0d06962:	4604      	mov	r4, r0
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d06964:	4823      	ldr	r0, [pc, #140]	; (c0d069f4 <USB_power+0x94>)
c0d06966:	2500      	movs	r5, #0
c0d06968:	22d4      	movs	r2, #212	; 0xd4
c0d0696a:	4629      	mov	r1, r5
c0d0696c:	f7fc fa39 	bl	c0d02de2 <os_memset>

  // init timeouts and other global fields
  os_memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
c0d06970:	4e21      	ldr	r6, [pc, #132]	; (c0d069f8 <USB_power+0x98>)
c0d06972:	4630      	mov	r0, r6
c0d06974:	300c      	adds	r0, #12
c0d06976:	2204      	movs	r2, #4
c0d06978:	4629      	mov	r1, r5
c0d0697a:	f7fc fa32 	bl	c0d02de2 <os_memset>
  os_memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d0697e:	3610      	adds	r6, #16
c0d06980:	2208      	movs	r2, #8
c0d06982:	4630      	mov	r0, r6
c0d06984:	4629      	mov	r1, r5
c0d06986:	f7fc fa2c 	bl	c0d02de2 <os_memset>

  if (enabled) {
c0d0698a:	2c00      	cmp	r4, #0
c0d0698c:	d02d      	beq.n	c0d069ea <USB_power+0x8a>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d0698e:	4c19      	ldr	r4, [pc, #100]	; (c0d069f4 <USB_power+0x94>)
c0d06990:	2500      	movs	r5, #0
c0d06992:	22d4      	movs	r2, #212	; 0xd4
c0d06994:	4620      	mov	r0, r4
c0d06996:	4629      	mov	r1, r5
c0d06998:	f7fc fa23 	bl	c0d02de2 <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d0699c:	4919      	ldr	r1, [pc, #100]	; (c0d06a04 <USB_power+0xa4>)
c0d0699e:	4479      	add	r1, pc
c0d069a0:	4620      	mov	r0, r4
c0d069a2:	462a      	mov	r2, r5
c0d069a4:	f7ff f9b6 	bl	c0d05d14 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d069a8:	4a17      	ldr	r2, [pc, #92]	; (c0d06a08 <USB_power+0xa8>)
c0d069aa:	447a      	add	r2, pc
c0d069ac:	4628      	mov	r0, r5
c0d069ae:	4621      	mov	r1, r4
c0d069b0:	f7ff f9ea 	bl	c0d05d88 <USBD_RegisterClassForInterface>
#ifdef HAVE_IO_U2F
    USBD_RegisterClassForInterface(U2F_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_U2F);
c0d069b4:	2001      	movs	r0, #1
c0d069b6:	4a15      	ldr	r2, [pc, #84]	; (c0d06a0c <USB_power+0xac>)
c0d069b8:	447a      	add	r2, pc
c0d069ba:	4621      	mov	r1, r4
c0d069bc:	f7ff f9e4 	bl	c0d05d88 <USBD_RegisterClassForInterface>
    // initialize the U2F tunnel transport
    u2f_transport_init(&G_io_u2f, G_io_apdu_buffer, IO_APDU_BUFFER_SIZE);
c0d069c0:	22ff      	movs	r2, #255	; 0xff
c0d069c2:	3252      	adds	r2, #82	; 0x52
c0d069c4:	480d      	ldr	r0, [pc, #52]	; (c0d069fc <USB_power+0x9c>)
c0d069c6:	490e      	ldr	r1, [pc, #56]	; (c0d06a00 <USB_power+0xa0>)
c0d069c8:	f7fd fc68 	bl	c0d0429c <u2f_transport_init>
#ifdef HAVE_USB_CLASS_CCID
    USBD_RegisterClassForInterface(CCID_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_CCID);
#endif // HAVE_USB_CLASS_CCID

#ifdef HAVE_WEBUSB
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
c0d069cc:	2002      	movs	r0, #2
c0d069ce:	4a10      	ldr	r2, [pc, #64]	; (c0d06a10 <USB_power+0xb0>)
c0d069d0:	447a      	add	r2, pc
c0d069d2:	4621      	mov	r1, r4
c0d069d4:	f7ff f9d8 	bl	c0d05d88 <USBD_RegisterClassForInterface>
    USBD_LL_PrepareReceive(&USBD_Device, WEBUSB_EPOUT_ADDR , WEBUSB_EPOUT_SIZE);
c0d069d8:	2103      	movs	r1, #3
c0d069da:	2240      	movs	r2, #64	; 0x40
c0d069dc:	4620      	mov	r0, r4
c0d069de:	f7ff f986 	bl	c0d05cee <USBD_LL_PrepareReceive>
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d069e2:	4620      	mov	r0, r4
c0d069e4:	f7ff f9dc 	bl	c0d05da0 <USBD_Start>
  }
  else {
    USBD_DeInit(&USBD_Device);
  }
}
c0d069e8:	bd70      	pop	{r4, r5, r6, pc}

    /* Start Device Process */
    USBD_Start(&USBD_Device);
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d069ea:	4802      	ldr	r0, [pc, #8]	; (c0d069f4 <USB_power+0x94>)
c0d069ec:	f7ff f9ab 	bl	c0d05d46 <USBD_DeInit>
  }
}
c0d069f0:	bd70      	pop	{r4, r5, r6, pc}
c0d069f2:	46c0      	nop			; (mov r8, r8)
c0d069f4:	20002338 	.word	0x20002338
c0d069f8:	20002110 	.word	0x20002110
c0d069fc:	20002130 	.word	0x20002130
c0d06a00:	20001fbc 	.word	0x20001fbc
c0d06a04:	00000f3a 	.word	0x00000f3a
c0d06a08:	000010ce 	.word	0x000010ce
c0d06a0c:	000010f8 	.word	0x000010f8
c0d06a10:	00001118 	.word	0x00001118

c0d06a14 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d06a14:	2160      	movs	r1, #96	; 0x60
c0d06a16:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d06a18:	4801      	ldr	r0, [pc, #4]	; (c0d06a20 <USBD_GetCfgDesc_impl+0xc>)
c0d06a1a:	4478      	add	r0, pc
c0d06a1c:	4770      	bx	lr
c0d06a1e:	46c0      	nop			; (mov r8, r8)
c0d06a20:	00001142 	.word	0x00001142

c0d06a24 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d06a24:	210a      	movs	r1, #10
c0d06a26:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d06a28:	4801      	ldr	r0, [pc, #4]	; (c0d06a30 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d06a2a:	4478      	add	r0, pc
c0d06a2c:	4770      	bx	lr
c0d06a2e:	46c0      	nop			; (mov r8, r8)
c0d06a30:	00001192 	.word	0x00001192

c0d06a34 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d06a34:	b5b0      	push	{r4, r5, r7, lr}
c0d06a36:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d06a38:	2194      	movs	r1, #148	; 0x94
c0d06a3a:	2302      	movs	r3, #2
c0d06a3c:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d06a3e:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d06a40:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d06a42:	21d0      	movs	r1, #208	; 0xd0
c0d06a44:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d06a46:	6a01      	ldr	r1, [r0, #32]
c0d06a48:	428a      	cmp	r2, r1
c0d06a4a:	d300      	bcc.n	c0d06a4e <USBD_CtlSendData+0x1a>
c0d06a4c:	460a      	mov	r2, r1
c0d06a4e:	b293      	uxth	r3, r2
c0d06a50:	2500      	movs	r5, #0
c0d06a52:	4629      	mov	r1, r5
c0d06a54:	4622      	mov	r2, r4
c0d06a56:	f7ff f931 	bl	c0d05cbc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d06a5a:	4628      	mov	r0, r5
c0d06a5c:	bdb0      	pop	{r4, r5, r7, pc}

c0d06a5e <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d06a5e:	b5b0      	push	{r4, r5, r7, lr}
c0d06a60:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d06a62:	6a01      	ldr	r1, [r0, #32]
c0d06a64:	428a      	cmp	r2, r1
c0d06a66:	d300      	bcc.n	c0d06a6a <USBD_CtlContinueSendData+0xc>
c0d06a68:	460a      	mov	r2, r1
c0d06a6a:	b293      	uxth	r3, r2
c0d06a6c:	2500      	movs	r5, #0
c0d06a6e:	4629      	mov	r1, r5
c0d06a70:	4622      	mov	r2, r4
c0d06a72:	f7ff f923 	bl	c0d05cbc <USBD_LL_Transmit>
  return USBD_OK;
c0d06a76:	4628      	mov	r0, r5
c0d06a78:	bdb0      	pop	{r4, r5, r7, pc}

c0d06a7a <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d06a7a:	b510      	push	{r4, lr}
c0d06a7c:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d06a7e:	4621      	mov	r1, r4
c0d06a80:	f7ff f935 	bl	c0d05cee <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d06a84:	4620      	mov	r0, r4
c0d06a86:	bd10      	pop	{r4, pc}

c0d06a88 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d06a88:	b510      	push	{r4, lr}

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d06a8a:	2194      	movs	r1, #148	; 0x94
c0d06a8c:	2204      	movs	r2, #4
c0d06a8e:	5042      	str	r2, [r0, r1]
c0d06a90:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d06a92:	4621      	mov	r1, r4
c0d06a94:	4622      	mov	r2, r4
c0d06a96:	4623      	mov	r3, r4
c0d06a98:	f7ff f910 	bl	c0d05cbc <USBD_LL_Transmit>
  
  return USBD_OK;
c0d06a9c:	4620      	mov	r0, r4
c0d06a9e:	bd10      	pop	{r4, pc}

c0d06aa0 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d06aa0:	b510      	push	{r4, lr}
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d06aa2:	2194      	movs	r1, #148	; 0x94
c0d06aa4:	2205      	movs	r2, #5
c0d06aa6:	5042      	str	r2, [r0, r1]
c0d06aa8:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d06aaa:	4621      	mov	r1, r4
c0d06aac:	4622      	mov	r2, r4
c0d06aae:	f7ff f91e 	bl	c0d05cee <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d06ab2:	4620      	mov	r0, r4
c0d06ab4:	bd10      	pop	{r4, pc}
	...

c0d06ab8 <ux_stack_push>:
    }
  }
  return 0;
}

unsigned int ux_stack_push(void) {
c0d06ab8:	b510      	push	{r4, lr}
  // only push if an available slot exists
  if (G_ux.stack_count < ARRAYLEN(G_ux.stack)) {
c0d06aba:	4c08      	ldr	r4, [pc, #32]	; (c0d06adc <ux_stack_push+0x24>)
c0d06abc:	7820      	ldrb	r0, [r4, #0]
c0d06abe:	2800      	cmp	r0, #0
c0d06ac0:	d108      	bne.n	c0d06ad4 <ux_stack_push+0x1c>
    os_memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d06ac2:	4620      	mov	r0, r4
c0d06ac4:	3024      	adds	r0, #36	; 0x24
c0d06ac6:	2100      	movs	r1, #0
c0d06ac8:	2220      	movs	r2, #32
c0d06aca:	f7fc f98a 	bl	c0d02de2 <os_memset>
#ifdef HAVE_UX_FLOW
    os_memset(&G_ux.flow_stack[G_ux.stack_count], 0, sizeof(G_ux.flow_stack[0]));
#endif // HAVE_UX_FLOW
    G_ux.stack_count++;
c0d06ace:	7820      	ldrb	r0, [r4, #0]
c0d06ad0:	1c40      	adds	r0, r0, #1
c0d06ad2:	7020      	strb	r0, [r4, #0]
  }
  // return the stack top index
  return G_ux.stack_count-1;
c0d06ad4:	b2c0      	uxtb	r0, r0
c0d06ad6:	1e40      	subs	r0, r0, #1
c0d06ad8:	bd10      	pop	{r4, pc}
c0d06ada:	46c0      	nop			; (mov r8, r8)
c0d06adc:	20001e70 	.word	0x20001e70

c0d06ae0 <__aeabi_uidiv>:
c0d06ae0:	2200      	movs	r2, #0
c0d06ae2:	0843      	lsrs	r3, r0, #1
c0d06ae4:	428b      	cmp	r3, r1
c0d06ae6:	d374      	bcc.n	c0d06bd2 <__aeabi_uidiv+0xf2>
c0d06ae8:	0903      	lsrs	r3, r0, #4
c0d06aea:	428b      	cmp	r3, r1
c0d06aec:	d35f      	bcc.n	c0d06bae <__aeabi_uidiv+0xce>
c0d06aee:	0a03      	lsrs	r3, r0, #8
c0d06af0:	428b      	cmp	r3, r1
c0d06af2:	d344      	bcc.n	c0d06b7e <__aeabi_uidiv+0x9e>
c0d06af4:	0b03      	lsrs	r3, r0, #12
c0d06af6:	428b      	cmp	r3, r1
c0d06af8:	d328      	bcc.n	c0d06b4c <__aeabi_uidiv+0x6c>
c0d06afa:	0c03      	lsrs	r3, r0, #16
c0d06afc:	428b      	cmp	r3, r1
c0d06afe:	d30d      	bcc.n	c0d06b1c <__aeabi_uidiv+0x3c>
c0d06b00:	22ff      	movs	r2, #255	; 0xff
c0d06b02:	0209      	lsls	r1, r1, #8
c0d06b04:	ba12      	rev	r2, r2
c0d06b06:	0c03      	lsrs	r3, r0, #16
c0d06b08:	428b      	cmp	r3, r1
c0d06b0a:	d302      	bcc.n	c0d06b12 <__aeabi_uidiv+0x32>
c0d06b0c:	1212      	asrs	r2, r2, #8
c0d06b0e:	0209      	lsls	r1, r1, #8
c0d06b10:	d065      	beq.n	c0d06bde <__aeabi_uidiv+0xfe>
c0d06b12:	0b03      	lsrs	r3, r0, #12
c0d06b14:	428b      	cmp	r3, r1
c0d06b16:	d319      	bcc.n	c0d06b4c <__aeabi_uidiv+0x6c>
c0d06b18:	e000      	b.n	c0d06b1c <__aeabi_uidiv+0x3c>
c0d06b1a:	0a09      	lsrs	r1, r1, #8
c0d06b1c:	0bc3      	lsrs	r3, r0, #15
c0d06b1e:	428b      	cmp	r3, r1
c0d06b20:	d301      	bcc.n	c0d06b26 <__aeabi_uidiv+0x46>
c0d06b22:	03cb      	lsls	r3, r1, #15
c0d06b24:	1ac0      	subs	r0, r0, r3
c0d06b26:	4152      	adcs	r2, r2
c0d06b28:	0b83      	lsrs	r3, r0, #14
c0d06b2a:	428b      	cmp	r3, r1
c0d06b2c:	d301      	bcc.n	c0d06b32 <__aeabi_uidiv+0x52>
c0d06b2e:	038b      	lsls	r3, r1, #14
c0d06b30:	1ac0      	subs	r0, r0, r3
c0d06b32:	4152      	adcs	r2, r2
c0d06b34:	0b43      	lsrs	r3, r0, #13
c0d06b36:	428b      	cmp	r3, r1
c0d06b38:	d301      	bcc.n	c0d06b3e <__aeabi_uidiv+0x5e>
c0d06b3a:	034b      	lsls	r3, r1, #13
c0d06b3c:	1ac0      	subs	r0, r0, r3
c0d06b3e:	4152      	adcs	r2, r2
c0d06b40:	0b03      	lsrs	r3, r0, #12
c0d06b42:	428b      	cmp	r3, r1
c0d06b44:	d301      	bcc.n	c0d06b4a <__aeabi_uidiv+0x6a>
c0d06b46:	030b      	lsls	r3, r1, #12
c0d06b48:	1ac0      	subs	r0, r0, r3
c0d06b4a:	4152      	adcs	r2, r2
c0d06b4c:	0ac3      	lsrs	r3, r0, #11
c0d06b4e:	428b      	cmp	r3, r1
c0d06b50:	d301      	bcc.n	c0d06b56 <__aeabi_uidiv+0x76>
c0d06b52:	02cb      	lsls	r3, r1, #11
c0d06b54:	1ac0      	subs	r0, r0, r3
c0d06b56:	4152      	adcs	r2, r2
c0d06b58:	0a83      	lsrs	r3, r0, #10
c0d06b5a:	428b      	cmp	r3, r1
c0d06b5c:	d301      	bcc.n	c0d06b62 <__aeabi_uidiv+0x82>
c0d06b5e:	028b      	lsls	r3, r1, #10
c0d06b60:	1ac0      	subs	r0, r0, r3
c0d06b62:	4152      	adcs	r2, r2
c0d06b64:	0a43      	lsrs	r3, r0, #9
c0d06b66:	428b      	cmp	r3, r1
c0d06b68:	d301      	bcc.n	c0d06b6e <__aeabi_uidiv+0x8e>
c0d06b6a:	024b      	lsls	r3, r1, #9
c0d06b6c:	1ac0      	subs	r0, r0, r3
c0d06b6e:	4152      	adcs	r2, r2
c0d06b70:	0a03      	lsrs	r3, r0, #8
c0d06b72:	428b      	cmp	r3, r1
c0d06b74:	d301      	bcc.n	c0d06b7a <__aeabi_uidiv+0x9a>
c0d06b76:	020b      	lsls	r3, r1, #8
c0d06b78:	1ac0      	subs	r0, r0, r3
c0d06b7a:	4152      	adcs	r2, r2
c0d06b7c:	d2cd      	bcs.n	c0d06b1a <__aeabi_uidiv+0x3a>
c0d06b7e:	09c3      	lsrs	r3, r0, #7
c0d06b80:	428b      	cmp	r3, r1
c0d06b82:	d301      	bcc.n	c0d06b88 <__aeabi_uidiv+0xa8>
c0d06b84:	01cb      	lsls	r3, r1, #7
c0d06b86:	1ac0      	subs	r0, r0, r3
c0d06b88:	4152      	adcs	r2, r2
c0d06b8a:	0983      	lsrs	r3, r0, #6
c0d06b8c:	428b      	cmp	r3, r1
c0d06b8e:	d301      	bcc.n	c0d06b94 <__aeabi_uidiv+0xb4>
c0d06b90:	018b      	lsls	r3, r1, #6
c0d06b92:	1ac0      	subs	r0, r0, r3
c0d06b94:	4152      	adcs	r2, r2
c0d06b96:	0943      	lsrs	r3, r0, #5
c0d06b98:	428b      	cmp	r3, r1
c0d06b9a:	d301      	bcc.n	c0d06ba0 <__aeabi_uidiv+0xc0>
c0d06b9c:	014b      	lsls	r3, r1, #5
c0d06b9e:	1ac0      	subs	r0, r0, r3
c0d06ba0:	4152      	adcs	r2, r2
c0d06ba2:	0903      	lsrs	r3, r0, #4
c0d06ba4:	428b      	cmp	r3, r1
c0d06ba6:	d301      	bcc.n	c0d06bac <__aeabi_uidiv+0xcc>
c0d06ba8:	010b      	lsls	r3, r1, #4
c0d06baa:	1ac0      	subs	r0, r0, r3
c0d06bac:	4152      	adcs	r2, r2
c0d06bae:	08c3      	lsrs	r3, r0, #3
c0d06bb0:	428b      	cmp	r3, r1
c0d06bb2:	d301      	bcc.n	c0d06bb8 <__aeabi_uidiv+0xd8>
c0d06bb4:	00cb      	lsls	r3, r1, #3
c0d06bb6:	1ac0      	subs	r0, r0, r3
c0d06bb8:	4152      	adcs	r2, r2
c0d06bba:	0883      	lsrs	r3, r0, #2
c0d06bbc:	428b      	cmp	r3, r1
c0d06bbe:	d301      	bcc.n	c0d06bc4 <__aeabi_uidiv+0xe4>
c0d06bc0:	008b      	lsls	r3, r1, #2
c0d06bc2:	1ac0      	subs	r0, r0, r3
c0d06bc4:	4152      	adcs	r2, r2
c0d06bc6:	0843      	lsrs	r3, r0, #1
c0d06bc8:	428b      	cmp	r3, r1
c0d06bca:	d301      	bcc.n	c0d06bd0 <__aeabi_uidiv+0xf0>
c0d06bcc:	004b      	lsls	r3, r1, #1
c0d06bce:	1ac0      	subs	r0, r0, r3
c0d06bd0:	4152      	adcs	r2, r2
c0d06bd2:	1a41      	subs	r1, r0, r1
c0d06bd4:	d200      	bcs.n	c0d06bd8 <__aeabi_uidiv+0xf8>
c0d06bd6:	4601      	mov	r1, r0
c0d06bd8:	4152      	adcs	r2, r2
c0d06bda:	4610      	mov	r0, r2
c0d06bdc:	4770      	bx	lr
c0d06bde:	e7ff      	b.n	c0d06be0 <__aeabi_uidiv+0x100>
c0d06be0:	b501      	push	{r0, lr}
c0d06be2:	2000      	movs	r0, #0
c0d06be4:	f000 f8f0 	bl	c0d06dc8 <__aeabi_idiv0>
c0d06be8:	bd02      	pop	{r1, pc}
c0d06bea:	46c0      	nop			; (mov r8, r8)

c0d06bec <__aeabi_uidivmod>:
c0d06bec:	2900      	cmp	r1, #0
c0d06bee:	d0f7      	beq.n	c0d06be0 <__aeabi_uidiv+0x100>
c0d06bf0:	e776      	b.n	c0d06ae0 <__aeabi_uidiv>
c0d06bf2:	4770      	bx	lr

c0d06bf4 <__aeabi_idiv>:
c0d06bf4:	4603      	mov	r3, r0
c0d06bf6:	430b      	orrs	r3, r1
c0d06bf8:	d47f      	bmi.n	c0d06cfa <__aeabi_idiv+0x106>
c0d06bfa:	2200      	movs	r2, #0
c0d06bfc:	0843      	lsrs	r3, r0, #1
c0d06bfe:	428b      	cmp	r3, r1
c0d06c00:	d374      	bcc.n	c0d06cec <__aeabi_idiv+0xf8>
c0d06c02:	0903      	lsrs	r3, r0, #4
c0d06c04:	428b      	cmp	r3, r1
c0d06c06:	d35f      	bcc.n	c0d06cc8 <__aeabi_idiv+0xd4>
c0d06c08:	0a03      	lsrs	r3, r0, #8
c0d06c0a:	428b      	cmp	r3, r1
c0d06c0c:	d344      	bcc.n	c0d06c98 <__aeabi_idiv+0xa4>
c0d06c0e:	0b03      	lsrs	r3, r0, #12
c0d06c10:	428b      	cmp	r3, r1
c0d06c12:	d328      	bcc.n	c0d06c66 <__aeabi_idiv+0x72>
c0d06c14:	0c03      	lsrs	r3, r0, #16
c0d06c16:	428b      	cmp	r3, r1
c0d06c18:	d30d      	bcc.n	c0d06c36 <__aeabi_idiv+0x42>
c0d06c1a:	22ff      	movs	r2, #255	; 0xff
c0d06c1c:	0209      	lsls	r1, r1, #8
c0d06c1e:	ba12      	rev	r2, r2
c0d06c20:	0c03      	lsrs	r3, r0, #16
c0d06c22:	428b      	cmp	r3, r1
c0d06c24:	d302      	bcc.n	c0d06c2c <__aeabi_idiv+0x38>
c0d06c26:	1212      	asrs	r2, r2, #8
c0d06c28:	0209      	lsls	r1, r1, #8
c0d06c2a:	d065      	beq.n	c0d06cf8 <__aeabi_idiv+0x104>
c0d06c2c:	0b03      	lsrs	r3, r0, #12
c0d06c2e:	428b      	cmp	r3, r1
c0d06c30:	d319      	bcc.n	c0d06c66 <__aeabi_idiv+0x72>
c0d06c32:	e000      	b.n	c0d06c36 <__aeabi_idiv+0x42>
c0d06c34:	0a09      	lsrs	r1, r1, #8
c0d06c36:	0bc3      	lsrs	r3, r0, #15
c0d06c38:	428b      	cmp	r3, r1
c0d06c3a:	d301      	bcc.n	c0d06c40 <__aeabi_idiv+0x4c>
c0d06c3c:	03cb      	lsls	r3, r1, #15
c0d06c3e:	1ac0      	subs	r0, r0, r3
c0d06c40:	4152      	adcs	r2, r2
c0d06c42:	0b83      	lsrs	r3, r0, #14
c0d06c44:	428b      	cmp	r3, r1
c0d06c46:	d301      	bcc.n	c0d06c4c <__aeabi_idiv+0x58>
c0d06c48:	038b      	lsls	r3, r1, #14
c0d06c4a:	1ac0      	subs	r0, r0, r3
c0d06c4c:	4152      	adcs	r2, r2
c0d06c4e:	0b43      	lsrs	r3, r0, #13
c0d06c50:	428b      	cmp	r3, r1
c0d06c52:	d301      	bcc.n	c0d06c58 <__aeabi_idiv+0x64>
c0d06c54:	034b      	lsls	r3, r1, #13
c0d06c56:	1ac0      	subs	r0, r0, r3
c0d06c58:	4152      	adcs	r2, r2
c0d06c5a:	0b03      	lsrs	r3, r0, #12
c0d06c5c:	428b      	cmp	r3, r1
c0d06c5e:	d301      	bcc.n	c0d06c64 <__aeabi_idiv+0x70>
c0d06c60:	030b      	lsls	r3, r1, #12
c0d06c62:	1ac0      	subs	r0, r0, r3
c0d06c64:	4152      	adcs	r2, r2
c0d06c66:	0ac3      	lsrs	r3, r0, #11
c0d06c68:	428b      	cmp	r3, r1
c0d06c6a:	d301      	bcc.n	c0d06c70 <__aeabi_idiv+0x7c>
c0d06c6c:	02cb      	lsls	r3, r1, #11
c0d06c6e:	1ac0      	subs	r0, r0, r3
c0d06c70:	4152      	adcs	r2, r2
c0d06c72:	0a83      	lsrs	r3, r0, #10
c0d06c74:	428b      	cmp	r3, r1
c0d06c76:	d301      	bcc.n	c0d06c7c <__aeabi_idiv+0x88>
c0d06c78:	028b      	lsls	r3, r1, #10
c0d06c7a:	1ac0      	subs	r0, r0, r3
c0d06c7c:	4152      	adcs	r2, r2
c0d06c7e:	0a43      	lsrs	r3, r0, #9
c0d06c80:	428b      	cmp	r3, r1
c0d06c82:	d301      	bcc.n	c0d06c88 <__aeabi_idiv+0x94>
c0d06c84:	024b      	lsls	r3, r1, #9
c0d06c86:	1ac0      	subs	r0, r0, r3
c0d06c88:	4152      	adcs	r2, r2
c0d06c8a:	0a03      	lsrs	r3, r0, #8
c0d06c8c:	428b      	cmp	r3, r1
c0d06c8e:	d301      	bcc.n	c0d06c94 <__aeabi_idiv+0xa0>
c0d06c90:	020b      	lsls	r3, r1, #8
c0d06c92:	1ac0      	subs	r0, r0, r3
c0d06c94:	4152      	adcs	r2, r2
c0d06c96:	d2cd      	bcs.n	c0d06c34 <__aeabi_idiv+0x40>
c0d06c98:	09c3      	lsrs	r3, r0, #7
c0d06c9a:	428b      	cmp	r3, r1
c0d06c9c:	d301      	bcc.n	c0d06ca2 <__aeabi_idiv+0xae>
c0d06c9e:	01cb      	lsls	r3, r1, #7
c0d06ca0:	1ac0      	subs	r0, r0, r3
c0d06ca2:	4152      	adcs	r2, r2
c0d06ca4:	0983      	lsrs	r3, r0, #6
c0d06ca6:	428b      	cmp	r3, r1
c0d06ca8:	d301      	bcc.n	c0d06cae <__aeabi_idiv+0xba>
c0d06caa:	018b      	lsls	r3, r1, #6
c0d06cac:	1ac0      	subs	r0, r0, r3
c0d06cae:	4152      	adcs	r2, r2
c0d06cb0:	0943      	lsrs	r3, r0, #5
c0d06cb2:	428b      	cmp	r3, r1
c0d06cb4:	d301      	bcc.n	c0d06cba <__aeabi_idiv+0xc6>
c0d06cb6:	014b      	lsls	r3, r1, #5
c0d06cb8:	1ac0      	subs	r0, r0, r3
c0d06cba:	4152      	adcs	r2, r2
c0d06cbc:	0903      	lsrs	r3, r0, #4
c0d06cbe:	428b      	cmp	r3, r1
c0d06cc0:	d301      	bcc.n	c0d06cc6 <__aeabi_idiv+0xd2>
c0d06cc2:	010b      	lsls	r3, r1, #4
c0d06cc4:	1ac0      	subs	r0, r0, r3
c0d06cc6:	4152      	adcs	r2, r2
c0d06cc8:	08c3      	lsrs	r3, r0, #3
c0d06cca:	428b      	cmp	r3, r1
c0d06ccc:	d301      	bcc.n	c0d06cd2 <__aeabi_idiv+0xde>
c0d06cce:	00cb      	lsls	r3, r1, #3
c0d06cd0:	1ac0      	subs	r0, r0, r3
c0d06cd2:	4152      	adcs	r2, r2
c0d06cd4:	0883      	lsrs	r3, r0, #2
c0d06cd6:	428b      	cmp	r3, r1
c0d06cd8:	d301      	bcc.n	c0d06cde <__aeabi_idiv+0xea>
c0d06cda:	008b      	lsls	r3, r1, #2
c0d06cdc:	1ac0      	subs	r0, r0, r3
c0d06cde:	4152      	adcs	r2, r2
c0d06ce0:	0843      	lsrs	r3, r0, #1
c0d06ce2:	428b      	cmp	r3, r1
c0d06ce4:	d301      	bcc.n	c0d06cea <__aeabi_idiv+0xf6>
c0d06ce6:	004b      	lsls	r3, r1, #1
c0d06ce8:	1ac0      	subs	r0, r0, r3
c0d06cea:	4152      	adcs	r2, r2
c0d06cec:	1a41      	subs	r1, r0, r1
c0d06cee:	d200      	bcs.n	c0d06cf2 <__aeabi_idiv+0xfe>
c0d06cf0:	4601      	mov	r1, r0
c0d06cf2:	4152      	adcs	r2, r2
c0d06cf4:	4610      	mov	r0, r2
c0d06cf6:	4770      	bx	lr
c0d06cf8:	e05d      	b.n	c0d06db6 <__aeabi_idiv+0x1c2>
c0d06cfa:	0fca      	lsrs	r2, r1, #31
c0d06cfc:	d000      	beq.n	c0d06d00 <__aeabi_idiv+0x10c>
c0d06cfe:	4249      	negs	r1, r1
c0d06d00:	1003      	asrs	r3, r0, #32
c0d06d02:	d300      	bcc.n	c0d06d06 <__aeabi_idiv+0x112>
c0d06d04:	4240      	negs	r0, r0
c0d06d06:	4053      	eors	r3, r2
c0d06d08:	2200      	movs	r2, #0
c0d06d0a:	469c      	mov	ip, r3
c0d06d0c:	0903      	lsrs	r3, r0, #4
c0d06d0e:	428b      	cmp	r3, r1
c0d06d10:	d32d      	bcc.n	c0d06d6e <__aeabi_idiv+0x17a>
c0d06d12:	0a03      	lsrs	r3, r0, #8
c0d06d14:	428b      	cmp	r3, r1
c0d06d16:	d312      	bcc.n	c0d06d3e <__aeabi_idiv+0x14a>
c0d06d18:	22fc      	movs	r2, #252	; 0xfc
c0d06d1a:	0189      	lsls	r1, r1, #6
c0d06d1c:	ba12      	rev	r2, r2
c0d06d1e:	0a03      	lsrs	r3, r0, #8
c0d06d20:	428b      	cmp	r3, r1
c0d06d22:	d30c      	bcc.n	c0d06d3e <__aeabi_idiv+0x14a>
c0d06d24:	0189      	lsls	r1, r1, #6
c0d06d26:	1192      	asrs	r2, r2, #6
c0d06d28:	428b      	cmp	r3, r1
c0d06d2a:	d308      	bcc.n	c0d06d3e <__aeabi_idiv+0x14a>
c0d06d2c:	0189      	lsls	r1, r1, #6
c0d06d2e:	1192      	asrs	r2, r2, #6
c0d06d30:	428b      	cmp	r3, r1
c0d06d32:	d304      	bcc.n	c0d06d3e <__aeabi_idiv+0x14a>
c0d06d34:	0189      	lsls	r1, r1, #6
c0d06d36:	d03a      	beq.n	c0d06dae <__aeabi_idiv+0x1ba>
c0d06d38:	1192      	asrs	r2, r2, #6
c0d06d3a:	e000      	b.n	c0d06d3e <__aeabi_idiv+0x14a>
c0d06d3c:	0989      	lsrs	r1, r1, #6
c0d06d3e:	09c3      	lsrs	r3, r0, #7
c0d06d40:	428b      	cmp	r3, r1
c0d06d42:	d301      	bcc.n	c0d06d48 <__aeabi_idiv+0x154>
c0d06d44:	01cb      	lsls	r3, r1, #7
c0d06d46:	1ac0      	subs	r0, r0, r3
c0d06d48:	4152      	adcs	r2, r2
c0d06d4a:	0983      	lsrs	r3, r0, #6
c0d06d4c:	428b      	cmp	r3, r1
c0d06d4e:	d301      	bcc.n	c0d06d54 <__aeabi_idiv+0x160>
c0d06d50:	018b      	lsls	r3, r1, #6
c0d06d52:	1ac0      	subs	r0, r0, r3
c0d06d54:	4152      	adcs	r2, r2
c0d06d56:	0943      	lsrs	r3, r0, #5
c0d06d58:	428b      	cmp	r3, r1
c0d06d5a:	d301      	bcc.n	c0d06d60 <__aeabi_idiv+0x16c>
c0d06d5c:	014b      	lsls	r3, r1, #5
c0d06d5e:	1ac0      	subs	r0, r0, r3
c0d06d60:	4152      	adcs	r2, r2
c0d06d62:	0903      	lsrs	r3, r0, #4
c0d06d64:	428b      	cmp	r3, r1
c0d06d66:	d301      	bcc.n	c0d06d6c <__aeabi_idiv+0x178>
c0d06d68:	010b      	lsls	r3, r1, #4
c0d06d6a:	1ac0      	subs	r0, r0, r3
c0d06d6c:	4152      	adcs	r2, r2
c0d06d6e:	08c3      	lsrs	r3, r0, #3
c0d06d70:	428b      	cmp	r3, r1
c0d06d72:	d301      	bcc.n	c0d06d78 <__aeabi_idiv+0x184>
c0d06d74:	00cb      	lsls	r3, r1, #3
c0d06d76:	1ac0      	subs	r0, r0, r3
c0d06d78:	4152      	adcs	r2, r2
c0d06d7a:	0883      	lsrs	r3, r0, #2
c0d06d7c:	428b      	cmp	r3, r1
c0d06d7e:	d301      	bcc.n	c0d06d84 <__aeabi_idiv+0x190>
c0d06d80:	008b      	lsls	r3, r1, #2
c0d06d82:	1ac0      	subs	r0, r0, r3
c0d06d84:	4152      	adcs	r2, r2
c0d06d86:	d2d9      	bcs.n	c0d06d3c <__aeabi_idiv+0x148>
c0d06d88:	0843      	lsrs	r3, r0, #1
c0d06d8a:	428b      	cmp	r3, r1
c0d06d8c:	d301      	bcc.n	c0d06d92 <__aeabi_idiv+0x19e>
c0d06d8e:	004b      	lsls	r3, r1, #1
c0d06d90:	1ac0      	subs	r0, r0, r3
c0d06d92:	4152      	adcs	r2, r2
c0d06d94:	1a41      	subs	r1, r0, r1
c0d06d96:	d200      	bcs.n	c0d06d9a <__aeabi_idiv+0x1a6>
c0d06d98:	4601      	mov	r1, r0
c0d06d9a:	4663      	mov	r3, ip
c0d06d9c:	4152      	adcs	r2, r2
c0d06d9e:	105b      	asrs	r3, r3, #1
c0d06da0:	4610      	mov	r0, r2
c0d06da2:	d301      	bcc.n	c0d06da8 <__aeabi_idiv+0x1b4>
c0d06da4:	4240      	negs	r0, r0
c0d06da6:	2b00      	cmp	r3, #0
c0d06da8:	d500      	bpl.n	c0d06dac <__aeabi_idiv+0x1b8>
c0d06daa:	4249      	negs	r1, r1
c0d06dac:	4770      	bx	lr
c0d06dae:	4663      	mov	r3, ip
c0d06db0:	105b      	asrs	r3, r3, #1
c0d06db2:	d300      	bcc.n	c0d06db6 <__aeabi_idiv+0x1c2>
c0d06db4:	4240      	negs	r0, r0
c0d06db6:	b501      	push	{r0, lr}
c0d06db8:	2000      	movs	r0, #0
c0d06dba:	f000 f805 	bl	c0d06dc8 <__aeabi_idiv0>
c0d06dbe:	bd02      	pop	{r1, pc}

c0d06dc0 <__aeabi_idivmod>:
c0d06dc0:	2900      	cmp	r1, #0
c0d06dc2:	d0f8      	beq.n	c0d06db6 <__aeabi_idiv+0x1c2>
c0d06dc4:	e716      	b.n	c0d06bf4 <__aeabi_idiv>
c0d06dc6:	4770      	bx	lr

c0d06dc8 <__aeabi_idiv0>:
c0d06dc8:	4770      	bx	lr
c0d06dca:	46c0      	nop			; (mov r8, r8)

c0d06dcc <__aeabi_lmul>:
c0d06dcc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d06dce:	464f      	mov	r7, r9
c0d06dd0:	4646      	mov	r6, r8
c0d06dd2:	b4c0      	push	{r6, r7}
c0d06dd4:	0416      	lsls	r6, r2, #16
c0d06dd6:	0c36      	lsrs	r6, r6, #16
c0d06dd8:	4699      	mov	r9, r3
c0d06dda:	0033      	movs	r3, r6
c0d06ddc:	0405      	lsls	r5, r0, #16
c0d06dde:	0c2c      	lsrs	r4, r5, #16
c0d06de0:	0c07      	lsrs	r7, r0, #16
c0d06de2:	0c15      	lsrs	r5, r2, #16
c0d06de4:	4363      	muls	r3, r4
c0d06de6:	437e      	muls	r6, r7
c0d06de8:	436f      	muls	r7, r5
c0d06dea:	4365      	muls	r5, r4
c0d06dec:	0c1c      	lsrs	r4, r3, #16
c0d06dee:	19ad      	adds	r5, r5, r6
c0d06df0:	1964      	adds	r4, r4, r5
c0d06df2:	469c      	mov	ip, r3
c0d06df4:	42a6      	cmp	r6, r4
c0d06df6:	d903      	bls.n	c0d06e00 <__aeabi_lmul+0x34>
c0d06df8:	2380      	movs	r3, #128	; 0x80
c0d06dfa:	025b      	lsls	r3, r3, #9
c0d06dfc:	4698      	mov	r8, r3
c0d06dfe:	4447      	add	r7, r8
c0d06e00:	4663      	mov	r3, ip
c0d06e02:	0c25      	lsrs	r5, r4, #16
c0d06e04:	19ef      	adds	r7, r5, r7
c0d06e06:	041d      	lsls	r5, r3, #16
c0d06e08:	464b      	mov	r3, r9
c0d06e0a:	434a      	muls	r2, r1
c0d06e0c:	4343      	muls	r3, r0
c0d06e0e:	0c2d      	lsrs	r5, r5, #16
c0d06e10:	0424      	lsls	r4, r4, #16
c0d06e12:	1964      	adds	r4, r4, r5
c0d06e14:	1899      	adds	r1, r3, r2
c0d06e16:	19c9      	adds	r1, r1, r7
c0d06e18:	0020      	movs	r0, r4
c0d06e1a:	bc0c      	pop	{r2, r3}
c0d06e1c:	4690      	mov	r8, r2
c0d06e1e:	4699      	mov	r9, r3
c0d06e20:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d06e22:	46c0      	nop			; (mov r8, r8)

c0d06e24 <__aeabi_memclr>:
c0d06e24:	b510      	push	{r4, lr}
c0d06e26:	2200      	movs	r2, #0
c0d06e28:	f000 f806 	bl	c0d06e38 <__aeabi_memset>
c0d06e2c:	bd10      	pop	{r4, pc}
c0d06e2e:	46c0      	nop			; (mov r8, r8)

c0d06e30 <__aeabi_memmove>:
c0d06e30:	b510      	push	{r4, lr}
c0d06e32:	f000 f809 	bl	c0d06e48 <memmove>
c0d06e36:	bd10      	pop	{r4, pc}

c0d06e38 <__aeabi_memset>:
c0d06e38:	0013      	movs	r3, r2
c0d06e3a:	b510      	push	{r4, lr}
c0d06e3c:	000a      	movs	r2, r1
c0d06e3e:	0019      	movs	r1, r3
c0d06e40:	f000 f84e 	bl	c0d06ee0 <memset>
c0d06e44:	bd10      	pop	{r4, pc}
c0d06e46:	46c0      	nop			; (mov r8, r8)

c0d06e48 <memmove>:
c0d06e48:	b570      	push	{r4, r5, r6, lr}
c0d06e4a:	4288      	cmp	r0, r1
c0d06e4c:	d90b      	bls.n	c0d06e66 <memmove+0x1e>
c0d06e4e:	188b      	adds	r3, r1, r2
c0d06e50:	4298      	cmp	r0, r3
c0d06e52:	d208      	bcs.n	c0d06e66 <memmove+0x1e>
c0d06e54:	1a99      	subs	r1, r3, r2
c0d06e56:	1e53      	subs	r3, r2, #1
c0d06e58:	2a00      	cmp	r2, #0
c0d06e5a:	d003      	beq.n	c0d06e64 <memmove+0x1c>
c0d06e5c:	5cca      	ldrb	r2, [r1, r3]
c0d06e5e:	54c2      	strb	r2, [r0, r3]
c0d06e60:	3b01      	subs	r3, #1
c0d06e62:	d2fb      	bcs.n	c0d06e5c <memmove+0x14>
c0d06e64:	bd70      	pop	{r4, r5, r6, pc}
c0d06e66:	2a0f      	cmp	r2, #15
c0d06e68:	d809      	bhi.n	c0d06e7e <memmove+0x36>
c0d06e6a:	0005      	movs	r5, r0
c0d06e6c:	2a00      	cmp	r2, #0
c0d06e6e:	d0f9      	beq.n	c0d06e64 <memmove+0x1c>
c0d06e70:	2300      	movs	r3, #0
c0d06e72:	5ccc      	ldrb	r4, [r1, r3]
c0d06e74:	54ec      	strb	r4, [r5, r3]
c0d06e76:	3301      	adds	r3, #1
c0d06e78:	429a      	cmp	r2, r3
c0d06e7a:	d1fa      	bne.n	c0d06e72 <memmove+0x2a>
c0d06e7c:	e7f2      	b.n	c0d06e64 <memmove+0x1c>
c0d06e7e:	000c      	movs	r4, r1
c0d06e80:	4304      	orrs	r4, r0
c0d06e82:	000b      	movs	r3, r1
c0d06e84:	07a4      	lsls	r4, r4, #30
c0d06e86:	d126      	bne.n	c0d06ed6 <memmove+0x8e>
c0d06e88:	0015      	movs	r5, r2
c0d06e8a:	0004      	movs	r4, r0
c0d06e8c:	3d10      	subs	r5, #16
c0d06e8e:	092d      	lsrs	r5, r5, #4
c0d06e90:	3501      	adds	r5, #1
c0d06e92:	012d      	lsls	r5, r5, #4
c0d06e94:	1949      	adds	r1, r1, r5
c0d06e96:	681e      	ldr	r6, [r3, #0]
c0d06e98:	6026      	str	r6, [r4, #0]
c0d06e9a:	685e      	ldr	r6, [r3, #4]
c0d06e9c:	6066      	str	r6, [r4, #4]
c0d06e9e:	689e      	ldr	r6, [r3, #8]
c0d06ea0:	60a6      	str	r6, [r4, #8]
c0d06ea2:	68de      	ldr	r6, [r3, #12]
c0d06ea4:	3310      	adds	r3, #16
c0d06ea6:	60e6      	str	r6, [r4, #12]
c0d06ea8:	3410      	adds	r4, #16
c0d06eaa:	4299      	cmp	r1, r3
c0d06eac:	d1f3      	bne.n	c0d06e96 <memmove+0x4e>
c0d06eae:	240f      	movs	r4, #15
c0d06eb0:	1945      	adds	r5, r0, r5
c0d06eb2:	4014      	ands	r4, r2
c0d06eb4:	2c03      	cmp	r4, #3
c0d06eb6:	d910      	bls.n	c0d06eda <memmove+0x92>
c0d06eb8:	2300      	movs	r3, #0
c0d06eba:	3c04      	subs	r4, #4
c0d06ebc:	08a4      	lsrs	r4, r4, #2
c0d06ebe:	3401      	adds	r4, #1
c0d06ec0:	00a4      	lsls	r4, r4, #2
c0d06ec2:	58ce      	ldr	r6, [r1, r3]
c0d06ec4:	50ee      	str	r6, [r5, r3]
c0d06ec6:	3304      	adds	r3, #4
c0d06ec8:	429c      	cmp	r4, r3
c0d06eca:	d1fa      	bne.n	c0d06ec2 <memmove+0x7a>
c0d06ecc:	2303      	movs	r3, #3
c0d06ece:	192d      	adds	r5, r5, r4
c0d06ed0:	1909      	adds	r1, r1, r4
c0d06ed2:	401a      	ands	r2, r3
c0d06ed4:	e7ca      	b.n	c0d06e6c <memmove+0x24>
c0d06ed6:	0005      	movs	r5, r0
c0d06ed8:	e7ca      	b.n	c0d06e70 <memmove+0x28>
c0d06eda:	0022      	movs	r2, r4
c0d06edc:	e7c6      	b.n	c0d06e6c <memmove+0x24>
c0d06ede:	46c0      	nop			; (mov r8, r8)

c0d06ee0 <memset>:
c0d06ee0:	b570      	push	{r4, r5, r6, lr}
c0d06ee2:	0783      	lsls	r3, r0, #30
c0d06ee4:	d03f      	beq.n	c0d06f66 <memset+0x86>
c0d06ee6:	1e54      	subs	r4, r2, #1
c0d06ee8:	2a00      	cmp	r2, #0
c0d06eea:	d03b      	beq.n	c0d06f64 <memset+0x84>
c0d06eec:	b2ce      	uxtb	r6, r1
c0d06eee:	0003      	movs	r3, r0
c0d06ef0:	2503      	movs	r5, #3
c0d06ef2:	e003      	b.n	c0d06efc <memset+0x1c>
c0d06ef4:	1e62      	subs	r2, r4, #1
c0d06ef6:	2c00      	cmp	r4, #0
c0d06ef8:	d034      	beq.n	c0d06f64 <memset+0x84>
c0d06efa:	0014      	movs	r4, r2
c0d06efc:	3301      	adds	r3, #1
c0d06efe:	1e5a      	subs	r2, r3, #1
c0d06f00:	7016      	strb	r6, [r2, #0]
c0d06f02:	422b      	tst	r3, r5
c0d06f04:	d1f6      	bne.n	c0d06ef4 <memset+0x14>
c0d06f06:	2c03      	cmp	r4, #3
c0d06f08:	d924      	bls.n	c0d06f54 <memset+0x74>
c0d06f0a:	25ff      	movs	r5, #255	; 0xff
c0d06f0c:	400d      	ands	r5, r1
c0d06f0e:	022a      	lsls	r2, r5, #8
c0d06f10:	4315      	orrs	r5, r2
c0d06f12:	042a      	lsls	r2, r5, #16
c0d06f14:	4315      	orrs	r5, r2
c0d06f16:	2c0f      	cmp	r4, #15
c0d06f18:	d911      	bls.n	c0d06f3e <memset+0x5e>
c0d06f1a:	0026      	movs	r6, r4
c0d06f1c:	3e10      	subs	r6, #16
c0d06f1e:	0936      	lsrs	r6, r6, #4
c0d06f20:	3601      	adds	r6, #1
c0d06f22:	0136      	lsls	r6, r6, #4
c0d06f24:	001a      	movs	r2, r3
c0d06f26:	199b      	adds	r3, r3, r6
c0d06f28:	6015      	str	r5, [r2, #0]
c0d06f2a:	6055      	str	r5, [r2, #4]
c0d06f2c:	6095      	str	r5, [r2, #8]
c0d06f2e:	60d5      	str	r5, [r2, #12]
c0d06f30:	3210      	adds	r2, #16
c0d06f32:	4293      	cmp	r3, r2
c0d06f34:	d1f8      	bne.n	c0d06f28 <memset+0x48>
c0d06f36:	220f      	movs	r2, #15
c0d06f38:	4014      	ands	r4, r2
c0d06f3a:	2c03      	cmp	r4, #3
c0d06f3c:	d90a      	bls.n	c0d06f54 <memset+0x74>
c0d06f3e:	1f26      	subs	r6, r4, #4
c0d06f40:	08b6      	lsrs	r6, r6, #2
c0d06f42:	3601      	adds	r6, #1
c0d06f44:	00b6      	lsls	r6, r6, #2
c0d06f46:	001a      	movs	r2, r3
c0d06f48:	199b      	adds	r3, r3, r6
c0d06f4a:	c220      	stmia	r2!, {r5}
c0d06f4c:	4293      	cmp	r3, r2
c0d06f4e:	d1fc      	bne.n	c0d06f4a <memset+0x6a>
c0d06f50:	2203      	movs	r2, #3
c0d06f52:	4014      	ands	r4, r2
c0d06f54:	2c00      	cmp	r4, #0
c0d06f56:	d005      	beq.n	c0d06f64 <memset+0x84>
c0d06f58:	b2c9      	uxtb	r1, r1
c0d06f5a:	191c      	adds	r4, r3, r4
c0d06f5c:	7019      	strb	r1, [r3, #0]
c0d06f5e:	3301      	adds	r3, #1
c0d06f60:	429c      	cmp	r4, r3
c0d06f62:	d1fb      	bne.n	c0d06f5c <memset+0x7c>
c0d06f64:	bd70      	pop	{r4, r5, r6, pc}
c0d06f66:	0014      	movs	r4, r2
c0d06f68:	0003      	movs	r3, r0
c0d06f6a:	e7cc      	b.n	c0d06f06 <memset+0x26>

c0d06f6c <setjmp>:
c0d06f6c:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d06f6e:	4641      	mov	r1, r8
c0d06f70:	464a      	mov	r2, r9
c0d06f72:	4653      	mov	r3, sl
c0d06f74:	465c      	mov	r4, fp
c0d06f76:	466d      	mov	r5, sp
c0d06f78:	4676      	mov	r6, lr
c0d06f7a:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d06f7c:	3828      	subs	r0, #40	; 0x28
c0d06f7e:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d06f80:	2000      	movs	r0, #0
c0d06f82:	4770      	bx	lr

c0d06f84 <longjmp>:
c0d06f84:	3010      	adds	r0, #16
c0d06f86:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d06f88:	4690      	mov	r8, r2
c0d06f8a:	4699      	mov	r9, r3
c0d06f8c:	46a2      	mov	sl, r4
c0d06f8e:	46ab      	mov	fp, r5
c0d06f90:	46b5      	mov	sp, r6
c0d06f92:	c808      	ldmia	r0!, {r3}
c0d06f94:	3828      	subs	r0, #40	; 0x28
c0d06f96:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d06f98:	1c08      	adds	r0, r1, #0
c0d06f9a:	d100      	bne.n	c0d06f9e <longjmp+0x1a>
c0d06f9c:	2001      	movs	r0, #1
c0d06f9e:	4718      	bx	r3

c0d06fa0 <strlen>:
c0d06fa0:	b510      	push	{r4, lr}
c0d06fa2:	0783      	lsls	r3, r0, #30
c0d06fa4:	d027      	beq.n	c0d06ff6 <strlen+0x56>
c0d06fa6:	7803      	ldrb	r3, [r0, #0]
c0d06fa8:	2b00      	cmp	r3, #0
c0d06faa:	d026      	beq.n	c0d06ffa <strlen+0x5a>
c0d06fac:	0003      	movs	r3, r0
c0d06fae:	2103      	movs	r1, #3
c0d06fb0:	e002      	b.n	c0d06fb8 <strlen+0x18>
c0d06fb2:	781a      	ldrb	r2, [r3, #0]
c0d06fb4:	2a00      	cmp	r2, #0
c0d06fb6:	d01c      	beq.n	c0d06ff2 <strlen+0x52>
c0d06fb8:	3301      	adds	r3, #1
c0d06fba:	420b      	tst	r3, r1
c0d06fbc:	d1f9      	bne.n	c0d06fb2 <strlen+0x12>
c0d06fbe:	6819      	ldr	r1, [r3, #0]
c0d06fc0:	4a0f      	ldr	r2, [pc, #60]	; (c0d07000 <strlen+0x60>)
c0d06fc2:	4c10      	ldr	r4, [pc, #64]	; (c0d07004 <strlen+0x64>)
c0d06fc4:	188a      	adds	r2, r1, r2
c0d06fc6:	438a      	bics	r2, r1
c0d06fc8:	4222      	tst	r2, r4
c0d06fca:	d10f      	bne.n	c0d06fec <strlen+0x4c>
c0d06fcc:	3304      	adds	r3, #4
c0d06fce:	6819      	ldr	r1, [r3, #0]
c0d06fd0:	4a0b      	ldr	r2, [pc, #44]	; (c0d07000 <strlen+0x60>)
c0d06fd2:	188a      	adds	r2, r1, r2
c0d06fd4:	438a      	bics	r2, r1
c0d06fd6:	4222      	tst	r2, r4
c0d06fd8:	d108      	bne.n	c0d06fec <strlen+0x4c>
c0d06fda:	3304      	adds	r3, #4
c0d06fdc:	6819      	ldr	r1, [r3, #0]
c0d06fde:	4a08      	ldr	r2, [pc, #32]	; (c0d07000 <strlen+0x60>)
c0d06fe0:	188a      	adds	r2, r1, r2
c0d06fe2:	438a      	bics	r2, r1
c0d06fe4:	4222      	tst	r2, r4
c0d06fe6:	d0f1      	beq.n	c0d06fcc <strlen+0x2c>
c0d06fe8:	e000      	b.n	c0d06fec <strlen+0x4c>
c0d06fea:	3301      	adds	r3, #1
c0d06fec:	781a      	ldrb	r2, [r3, #0]
c0d06fee:	2a00      	cmp	r2, #0
c0d06ff0:	d1fb      	bne.n	c0d06fea <strlen+0x4a>
c0d06ff2:	1a18      	subs	r0, r3, r0
c0d06ff4:	bd10      	pop	{r4, pc}
c0d06ff6:	0003      	movs	r3, r0
c0d06ff8:	e7e1      	b.n	c0d06fbe <strlen+0x1e>
c0d06ffa:	2000      	movs	r0, #0
c0d06ffc:	e7fa      	b.n	c0d06ff4 <strlen+0x54>
c0d06ffe:	46c0      	nop			; (mov r8, r8)
c0d07000:	fefefeff 	.word	0xfefefeff
c0d07004:	80808080 	.word	0x80808080

c0d07008 <strncmp>:
c0d07008:	0003      	movs	r3, r0
c0d0700a:	b530      	push	{r4, r5, lr}
c0d0700c:	2000      	movs	r0, #0
c0d0700e:	2a00      	cmp	r2, #0
c0d07010:	d03b      	beq.n	c0d0708a <strncmp+0x82>
c0d07012:	001c      	movs	r4, r3
c0d07014:	430c      	orrs	r4, r1
c0d07016:	07a4      	lsls	r4, r4, #30
c0d07018:	d120      	bne.n	c0d0705c <strncmp+0x54>
c0d0701a:	2a03      	cmp	r2, #3
c0d0701c:	d91e      	bls.n	c0d0705c <strncmp+0x54>
c0d0701e:	681c      	ldr	r4, [r3, #0]
c0d07020:	680d      	ldr	r5, [r1, #0]
c0d07022:	42ac      	cmp	r4, r5
c0d07024:	d11a      	bne.n	c0d0705c <strncmp+0x54>
c0d07026:	3a04      	subs	r2, #4
c0d07028:	2a00      	cmp	r2, #0
c0d0702a:	d02e      	beq.n	c0d0708a <strncmp+0x82>
c0d0702c:	4d1a      	ldr	r5, [pc, #104]	; (c0d07098 <strncmp+0x90>)
c0d0702e:	1965      	adds	r5, r4, r5
c0d07030:	43a5      	bics	r5, r4
c0d07032:	002c      	movs	r4, r5
c0d07034:	4d19      	ldr	r5, [pc, #100]	; (c0d0709c <strncmp+0x94>)
c0d07036:	422c      	tst	r4, r5
c0d07038:	d00c      	beq.n	c0d07054 <strncmp+0x4c>
c0d0703a:	e026      	b.n	c0d0708a <strncmp+0x82>
c0d0703c:	6818      	ldr	r0, [r3, #0]
c0d0703e:	680c      	ldr	r4, [r1, #0]
c0d07040:	42a0      	cmp	r0, r4
c0d07042:	d10b      	bne.n	c0d0705c <strncmp+0x54>
c0d07044:	3a04      	subs	r2, #4
c0d07046:	2a00      	cmp	r2, #0
c0d07048:	d020      	beq.n	c0d0708c <strncmp+0x84>
c0d0704a:	4c13      	ldr	r4, [pc, #76]	; (c0d07098 <strncmp+0x90>)
c0d0704c:	1904      	adds	r4, r0, r4
c0d0704e:	4384      	bics	r4, r0
c0d07050:	422c      	tst	r4, r5
c0d07052:	d11b      	bne.n	c0d0708c <strncmp+0x84>
c0d07054:	3304      	adds	r3, #4
c0d07056:	3104      	adds	r1, #4
c0d07058:	2a03      	cmp	r2, #3
c0d0705a:	d8ef      	bhi.n	c0d0703c <strncmp+0x34>
c0d0705c:	781c      	ldrb	r4, [r3, #0]
c0d0705e:	7808      	ldrb	r0, [r1, #0]
c0d07060:	3a01      	subs	r2, #1
c0d07062:	42a0      	cmp	r0, r4
c0d07064:	d114      	bne.n	c0d07090 <strncmp+0x88>
c0d07066:	2a00      	cmp	r2, #0
c0d07068:	d010      	beq.n	c0d0708c <strncmp+0x84>
c0d0706a:	1c4c      	adds	r4, r1, #1
c0d0706c:	188a      	adds	r2, r1, r2
c0d0706e:	2800      	cmp	r0, #0
c0d07070:	d105      	bne.n	c0d0707e <strncmp+0x76>
c0d07072:	e00b      	b.n	c0d0708c <strncmp+0x84>
c0d07074:	42a2      	cmp	r2, r4
c0d07076:	d009      	beq.n	c0d0708c <strncmp+0x84>
c0d07078:	3401      	adds	r4, #1
c0d0707a:	2900      	cmp	r1, #0
c0d0707c:	d006      	beq.n	c0d0708c <strncmp+0x84>
c0d0707e:	3301      	adds	r3, #1
c0d07080:	7819      	ldrb	r1, [r3, #0]
c0d07082:	7820      	ldrb	r0, [r4, #0]
c0d07084:	4281      	cmp	r1, r0
c0d07086:	d0f5      	beq.n	c0d07074 <strncmp+0x6c>
c0d07088:	1a08      	subs	r0, r1, r0
c0d0708a:	bd30      	pop	{r4, r5, pc}
c0d0708c:	2000      	movs	r0, #0
c0d0708e:	e7fc      	b.n	c0d0708a <strncmp+0x82>
c0d07090:	0021      	movs	r1, r4
c0d07092:	1a08      	subs	r0, r1, r0
c0d07094:	e7f9      	b.n	c0d0708a <strncmp+0x82>
c0d07096:	46c0      	nop			; (mov r8, r8)
c0d07098:	fefefeff 	.word	0xfefefeff
c0d0709c:	80808080 	.word	0x80808080

c0d070a0 <BASE58ALPHABET>:
c0d070a0:	34333231 38373635 43424139 47464544     123456789ABCDEFG
c0d070b0:	4c4b4a48 51504e4d 55545352 59585756     HJKLMNPQRSTUVWXY
c0d070c0:	6362615a 67666564 6b6a6968 706f6e6d     Zabcdefghijkmnop
c0d070d0:	74737271 78777675 54427a79 00002054     qrstuvwxyzBTT ..

c0d070e0 <C_chain_config>:
c0d070e0:	c0d070da 00000000 00000000 61657263     .p..........crea
c0d070f0:	00726f74 706f7270 6c61736f 70007265     tor.proposaler.p
c0d07100:	6764656c 73007265 00656469 6564726f     ledger.side.orde
c0d07110:	79745f72 6d006570 656b7261 616e5f74     r_type.market_na
c0d07120:	6600656d 006d6f72 74006f74 78655f6f     me.from.to.to_ex
c0d07130:	6e726574 615f6c61 65726464 6d007373     ternal_address.m
c0d07140:	61737365 61006567 6e756f6d 72700074     essage.amount.pr
c0d07150:	00656369 65657266 625f657a 665f7474     ice.freeze_btt_f
c0d07160:	6f006565                                         ee.

c0d07163 <SW_INTERNAL>:
c0d07163:	0190006f                                         o.

c0d07165 <SW_BUSY>:
c0d07165:	00670190                                         ..

c0d07167 <SW_WRONG_LENGTH>:
c0d07167:	85690067                                         g.

c0d07169 <SW_PROOF_OF_PRESENCE_REQUIRED>:
c0d07169:	806a8569                                         i.

c0d0716b <SW_BAD_KEY_HANDLE>:
c0d0716b:	3255806a                                         j.

c0d0716d <U2F_VERSION>:
c0d0716d:	5f463255 00903256                       U2F_V2..

c0d07175 <INFO>:
c0d07175:	00900901                                ....

c0d07179 <SW_UNKNOWN_CLASS>:
c0d07179:	006d006e                                         n.

c0d0717b <SW_UNKNOWN_INSTRUCTION>:
c0d0717b:	ffff006d                                         m.

c0d0717d <BROADCAST_CHANNEL>:
c0d0717d:	ffffffff                                ....

c0d07181 <FORBIDDEN_CHANNEL>:
c0d07181:	00000000 03000000                                .......

c0d07188 <ui_main_nanos>:
c0d07188:	00000003 00800000 00000020 00000001     ........ .......
c0d07198:	00000000 00ffffff 00000000 00000000     ................
c0d071a8:	00750105 0008000d 00000006 00000000     ..u.............
c0d071b8:	00ffffff 00000000 000a0000 00000000     ................
c0d071c8:	00000207 0080000c 0000000b 00000000     ................
c0d071d8:	00ffffff 00000000 0000800a c0d077c8     .............w..
c0d071e8:	00170207 0052001a 008a000b 00000000     ......R.........
c0d071f8:	00ffffff 00000000 001a8008 20001b58     ............X.. 

c0d07208 <ui_main_choose_account_nanos>:
c0d07208:	00000003 00800000 00000020 00000001     ........ .......
c0d07218:	00000000 00ffffff 00000000 00000000     ................
c0d07228:	00030005 0007000c 00000007 00000000     ................
c0d07238:	00ffffff 00000000 00090000 00000000     ................
c0d07248:	00750105 0008000d 00000006 00000000     ..u.............
c0d07258:	00ffffff 00000000 000a0000 00000000     ................
c0d07268:	00000207 0080000c 0000000b 00000000     ................
c0d07278:	00ffffff 00000000 0000800a c0d077c8     .............w..
c0d07288:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07298:	00ffffff 00000000 001a8008 c0d077d3     .............w..

c0d072a8 <ui_main_create_account_nanos>:
c0d072a8:	00000003 00800000 00000020 00000001     ........ .......
c0d072b8:	00000000 00ffffff 00000000 00000000     ................
c0d072c8:	00030005 0007000c 00000007 00000000     ................
c0d072d8:	00ffffff 00000000 00090000 00000000     ................
c0d072e8:	00750105 0008000d 00000006 00000000     ..u.............
c0d072f8:	00ffffff 00000000 000a0000 00000000     ................
c0d07308:	00000207 0080000c 0000000b 00000000     ................
c0d07318:	00ffffff 00000000 0000800a c0d077c8     .............w..
c0d07328:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07338:	00ffffff 00000000 001a8008 c0d077e2     .............w..

c0d07348 <ui_choose_account_zero_nanos>:
c0d07348:	00000003 00800000 00000020 00000001     ........ .......
c0d07358:	00000000 00ffffff 00000000 00000000     ................
c0d07368:	00750105 0008000d 00000006 00000000     ..u.............
c0d07378:	00ffffff 00000000 000a0000 00000000     ................
c0d07388:	00000207 0080000c 0000000b 00000000     ................
c0d07398:	00ffffff 00000000 0000800a c0d077f1     .............w..
c0d073a8:	00170207 0052001a 008a000b 00000000     ......R.........
c0d073b8:	00ffffff 00000000 001a8008 20001b58     ............X.. 

c0d073c8 <ui_choose_account_nanos>:
c0d073c8:	00000003 00800000 00000020 00000001     ........ .......
c0d073d8:	00000000 00ffffff 00000000 00000000     ................
c0d073e8:	00030005 0007000c 00000007 00000000     ................
c0d073f8:	00ffffff 00000000 00090000 00000000     ................
c0d07408:	00750105 0008000d 00000006 00000000     ..u.............
c0d07418:	00ffffff 00000000 000a0000 00000000     ................
c0d07428:	00000207 0080000c 0000000b 00000000     ................
c0d07438:	00ffffff 00000000 0000800a c0d077f1     .............w..
c0d07448:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07458:	00ffffff 00000000 001a8008 20001b58     ............X.. 

c0d07468 <ui_create_account_nanos>:
c0d07468:	00000003 00800000 00000020 00000001     ........ .......
c0d07478:	00000000 00ffffff 00000000 00000000     ................
c0d07488:	00030005 0007000c 00000007 00000000     ................
c0d07498:	00ffffff 00000000 00090000 00000000     ................
c0d074a8:	00750105 0008000d 00000006 00000000     ..u.............
c0d074b8:	00ffffff 00000000 000a0000 00000000     ................
c0d074c8:	00000207 0080000c 0000000b 00000000     ................
c0d074d8:	00ffffff 00000000 0000800a c0d077f1     .............w..
c0d074e8:	00170207 0052001a 008a000b 00000000     ......R.........
c0d074f8:	00ffffff 00000000 001a8008 c0d07800     .............x..

c0d07508 <ui_account_back_nanos>:
c0d07508:	00000003 00800000 00000020 00000001     ........ .......
c0d07518:	00000000 00ffffff 00000000 00000000     ................
c0d07528:	00030005 0007000c 00000007 00000000     ................
c0d07538:	00ffffff 00000000 00090000 00000000     ................
c0d07548:	00000207 0080000c 0000000b 00000000     ................
c0d07558:	00ffffff 00000000 0000800a c0d077f1     .............w..
c0d07568:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07578:	00ffffff 00000000 001a8008 c0d07807     .............x..

c0d07588 <ui_confirm_account_nanos>:
c0d07588:	00000003 00800000 00000020 00000001     ........ .......
c0d07598:	00000000 00ffffff 00000000 00000000     ................
c0d075a8:	00030005 0007000c 00000007 00000000     ................
c0d075b8:	00ffffff 00000000 00070000 00000000     ................
c0d075c8:	00750105 0008000d 00000006 00000000     ..u.............
c0d075d8:	00ffffff 00000000 00060000 00000000     ................
c0d075e8:	00000207 0080000c 0000000b 00000000     ................
c0d075f8:	00ffffff 00000000 0000800a c0d0780c     .............x..
c0d07608:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07618:	00ffffff 00000000 001a8008 20001b58     ............X.. 

c0d07628 <ui_main_exit_nanos>:
c0d07628:	00000003 00800000 00000020 00000001     ........ .......
c0d07638:	00000000 00ffffff 00000000 00000000     ................
c0d07648:	00030005 0007000c 00000007 00000000     ................
c0d07658:	00ffffff 00000000 00090000 00000000     ................
c0d07668:	00000207 0080000c 0000000b 00000000     ................
c0d07678:	00ffffff 00000000 0000800a c0d077c8     .............w..
c0d07688:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07698:	00ffffff 00000000 001a8008 c0d0781c     .............x..

c0d076a8 <ui_sign_tx_nanos>:
c0d076a8:	00000003 00800000 00000020 00000001     ........ .......
c0d076b8:	00000000 00ffffff 00000000 00000000     ................
c0d076c8:	00030005 0007000c 00000007 00000000     ................
c0d076d8:	00ffffff 00000000 00070000 00000000     ................
c0d076e8:	00750005 0008000d 00000006 00000000     ..u.............
c0d076f8:	00ffffff 00000000 00060000 00000000     ................
c0d07708:	00000207 0080000c 0000000b 00000000     ................
c0d07718:	00ffffff 00000000 0000800a c0d07821     ............!x..
c0d07728:	00170207 0052001a 008a000b 00000000     ......R.........
c0d07738:	00ffffff 00000000 001a8008 20001b7e     ............~.. 

c0d07748 <ui_approval_tx_nanos>:
c0d07748:	00000003 00800000 00000020 00000001     ........ .......
c0d07758:	00000000 00ffffff 00000000 00000000     ................
c0d07768:	00030005 0007000c 00000007 00000000     ................
c0d07778:	00ffffff 00000000 00070000 00000000     ................
c0d07788:	00750005 0008000d 00000006 00000000     ..u.............
c0d07798:	00ffffff 00000000 00060000 00000000     ................
c0d077a8:	00000207 0080000c 0000000b 00000000     ................
c0d077b8:	00ffffff 00000000 0000800a c0d07834     ............4x..
c0d077c8:	65747942 61725420 43006564 736f6f68     Byte Trade.Choos
c0d077d8:	64412065 73657264 72430073 65746165     e Address.Create
c0d077e8:	64644120 73736572 6f684300 2065736f      Address.Choose 
c0d077f8:	6f636341 00746e75 61657243 42006574     Account.Create.B
c0d07808:	006b6361 666e6f43 206d7269 6f636341     ack.Confirm Acco
c0d07818:	00746e75 74697845 72655600 20796669     unt.Exit.Verify 
c0d07828:	6e617274 74636173 006e6f69 6e676953     transaction.Sign
c0d07838:	61727420 6361736e 6e6f6974 00000000      transaction....

c0d07848 <USBD_HID_Desc_fido>:
c0d07848:	01112109 22220121 00000000              .!..!.""....

c0d07854 <USBD_HID_Desc>:
c0d07854:	01112109 22220100 f1d00600                       .!...."".

c0d0785d <HID_ReportDesc_fido>:
c0d0785d:	09f1d006 0901a101 26001503 087500ff     ...........&..u.
c0d0786d:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0787d:	a006c008                                         ..

c0d0787f <HID_ReportDesc>:
c0d0787f:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d0788f:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0789f:	0f05c008                                         ..

c0d078a1 <C_usb_bos>:
c0d078a1:	00390f05 05101802 08b63800 a009a934     ..9......8..4...
c0d078b1:	a0fd8b47 b6158876 1e010065 05101c00     G...v...e.......
c0d078c1:	dd60df00 c74589d8 65d29c4c 8a649e9d     ..`...E.L..e..d.
c0d078d1:	0300009f 7700b206 49000000                       .......w...

c0d078dc <HID_Desc>:
c0d078dc:	c0d06849 c0d06859 c0d06869 c0d06879     Ih..Yh..ih..yh..
c0d078ec:	c0d06889 c0d06899 c0d068a9 c0d068b9     .h...h...h...h..

c0d078fc <C_winusb_string_descriptor>:
c0d078fc:	004d0312 00460053 00310054 00300030     ..M.S.F.T.1.0.0.
c0d0790c:	00280077                                         w.

c0d0790e <C_winusb_wcid>:
c0d0790e:	00000028 00040100 00000001 00000000     (...............
c0d0791e:	49570102 4253554e 00000000 00000000     ..WINUSB........
	...

c0d07936 <C_winusb_guid>:
c0d07936:	00000092 00050100 00880001 00070000     ................
c0d07946:	002a0000 00650044 00690076 00650063     ..*.D.e.v.i.c.e.
c0d07956:	006e0049 00650074 00660072 00630061     I.n.t.e.r.f.a.c.
c0d07966:	00470065 00490055 00730044 00500000     e.G.U.I.D.s...P.
c0d07976:	007b0000 00330031 00360064 00340033     ..{.1.3.d.6.3.4.
c0d07986:	00300030 0032002d 00390043 002d0037     0.0.-.2.C.9.7.-.
c0d07996:	00300030 00340030 0030002d 00300030     0.0.0.4.-.0.0.0.
c0d079a6:	002d0030 00630034 00350036 00340036     0.-.4.c.6.5.6.4.
c0d079b6:	00370036 00350036 00320037 0000007d     6.7.6.5.7.2.}...
	...

c0d079c8 <C_winusb_request_descriptor>:
c0d079c8:	0000000a 06030000 000800b2 00000001     ................
c0d079d8:	000800a8 00020002 001400a0 49570003     ..............WI
c0d079e8:	4253554e 00000000 00000000 00840000     NUSB............
c0d079f8:	00070004 0044002a 00760065 00630069     ....*.D.e.v.i.c.
c0d07a08:	00490065 0074006e 00720065 00610066     e.I.n.t.e.r.f.a.
c0d07a18:	00650063 00550047 00440049 00000073     c.e.G.U.I.D.s...
c0d07a28:	007b0050 00450043 00300038 00320039     P.{.C.E.8.0.9.2.
c0d07a38:	00340036 0034002d 00320042 002d0034     6.4.-.4.B.2.4.-.
c0d07a48:	00450034 00310038 0041002d 00420038     4.E.8.1.-.A.8.B.
c0d07a58:	002d0032 00370035 00440045 00310030     2.-.5.7.E.D.0.1.
c0d07a68:	00350044 00300038 00310045 0000007d     D.5.8.0.E.1.}...
c0d07a78:	00000000                                ....

c0d07a7c <USBD_HID>:
c0d07a7c:	c0d065f5 c0d06627 c0d0655d 00000000     .e..'f..]e......
c0d07a8c:	00000000 c0d0674d c0d06765 00000000     ....Mg..eg......
	...
c0d07aa4:	c0d06a15 c0d06a15 c0d06a15 c0d06a25     .j...j...j..%j..

c0d07ab4 <USBD_U2F>:
c0d07ab4:	c0d066d5 c0d06627 c0d0655d 00000000     .f..'f..]e......
c0d07ac4:	00000000 c0d06709 c0d06721 00000000     .....g..!g......
	...
c0d07adc:	c0d06a15 c0d06a15 c0d06a15 c0d06a25     .j...j...j..%j..

c0d07aec <USBD_WEBUSB>:
c0d07aec:	c0d067b1 c0d067dd c0d067e1 00000000     .g...g...g......
c0d07afc:	00000000 c0d067e5 c0d067fd 00000000     .....g...g......
	...
c0d07b14:	c0d06a15 c0d06a15 c0d06a15 c0d06a25     .j...j...j..%j..

c0d07b24 <USBD_DeviceDesc>:
c0d07b24:	02100112 40000000 10152c97 02010201     .......@.,......
c0d07b34:	03040103                                         ..

c0d07b36 <USBD_LangIDDesc>:
c0d07b36:	04090304                                ....

c0d07b3a <USBD_MANUFACTURER_STRING>:
c0d07b3a:	004c030e 00640065 00650067 030e0072              ..L.e.d.g.e.r.

c0d07b48 <USBD_PRODUCT_FS_STRING>:
c0d07b48:	004e030e 006e0061 0020006f 030a0053              ..N.a.n.o. .S.

c0d07b56 <USB_SERIAL_STRING>:
c0d07b56:	0030030a 00300030 02090031                       ..0.0.0.1.

c0d07b60 <USBD_CfgDesc>:
c0d07b60:	00600209 c0020103 00040932 00030200     ..`.....2.......
c0d07b70:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d07b80:	05070100 00400302 01040901 01030200     ......@.........
c0d07b90:	21090201 01210111 07002222 40038105     ...!..!."".....@
c0d07ba0:	05070100 00400301 02040901 ffff0200     ......@.........
c0d07bb0:	050702ff 00400383 03050701 01004003     ......@......@..

c0d07bc0 <USBD_DeviceQualifierDesc>:
c0d07bc0:	0200060a 40000000 00000001              .......@....

c0d07bcc <_etext>:
	...

c0d07c00 <N_storage_real>:
	...
