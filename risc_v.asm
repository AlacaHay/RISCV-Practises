#######################################################
# Kite: An architecture simulator for five-stage      #
# pipeline modeling of RISC-V instruction set         #
# Developed by William J. Song                        #
# School of Electrical Engineering, Yonsei University #
# Version: 1.8                                        #
#######################################################

# Kite program code
#   1. The first instruction starts at PC = 4. PC = 0 is reserved as invalid.
#   2. To terminate the program, let the next PC naturally go out of range.
#   3. All the instructions and labels are case-insensitive.
#   4. The program code supports only the following list of instructions
#      (sorted by alphabetical order in each type).
#      R-type: add, and, div, divu, mul, or, rem, remu, sll, sra, srl, sub, xor
#      I-type: addi, andi, jalr, slli, srai, srli, ld, ori, xori
#      S-type: sd
#      SB-type: beq, bge, blt, bne
#      U-type: lui
#      UJ-type: jal
#      No-type: nop

# The example code below implements Euclidean algorithm for GCD.
# it reads two numbers from x10 and x11, calculates GCD, and
# puts the result in x10 register.
# you will see x10 = 3 in the output if you run the code.
#loop:   beq  x11, x0,  exit
        #remu x5,  x10, x11
        #add  x10, x11, x0
        #add  x11, x5,  x0
        #beq  x0,  x0,  loop
#exit:   sd   x10, 2000(x0)
#addi x1,x0,10
#mul x2,x1,x1
#addi x3,x2,5
#rem x4,x3,x1

#slli x5,x2,3   #immidiate kadar 2^i ile sayiyi carpar 
               #sol (left)=> 2 ile carpma
#srli x6,x2,2   # sag(right) shift  =>2 ile bolme

#addi x13,x0,1024



  
#srai x7,x1,1

#ld x9,8(x13)   # 8 offset  x9 a  x13+8 adresindeki veri yazılır x13=1024 +8 =   1032 deki adreste          tutulan veri yazilir.


#addi x10,x0,-105
#srli x11,x10,1    # isaretli sayilarda logical shift right  cok buyuk pozitif sayilar elde ettirir.
#srai x12,x10,1    #burada ise x12ye 

#addi x14,x0,-50
#slli x15,x14,1     #x15 ,  (-50)* 2^1 den =-100 olur.  Left shiftlerde logical islem yapilir
                   #hep(isaretsiz) islemler
#lab2
#1.soru
#addi x5,x0,42
#addi x6,x0,42
#beq x5,x6,set_flag
#set_flag:
#addi x10,x0,1

#memory islemin yapildigini bellege bildirir
#------------------------------------

#2.soru
#addi x5,x0,-13
#blt x5,x0,negative #dallanmada geri donemiyor diger islemin fetchine  islem bitmeden gecemez.
#bge x5,x0,positive
#negative:
#sub x5,x0,x5
#positive:
#nop  # bir sey yapma demek

#3.soru 
#addi x5,x0,33
#addi x6,x0,12
#blt x5,x6,end
#bge x5,x6,swap
#swap:
#add x7,x0,x5
#add x5,x0,x6
#add x6,x0,x7
#end:

#dallanmada geriye donus yok ama dongulerde var o yuzden sonraki islemin fetchine dallanmada gecilmez.
#branchler tum asamayi bitirip sonra digerine baslar.

#4.soru
#addi x5,x5,0
#addi x6,x5,1
#addi x7,x5,6 #dongu sonu kosulu ust sinir.
#loop:
#bge x6,x7,end_loop
#add x5,x5,x6
#addi x6,x6,1
#blt x6,x7,loop
#end_loop:

#--------------------------------------------------------------------------------------
#lab3

#1.soru
#lui x8,0   ->bellekten isaretcisi ust 20 bit 0 yapıldı
#addi x8,x8,1024 ->  1024. adresten baslatilir kod 
#addi x10,x0,0
#addi x11,x0,1
#sd x10,0(x8)
#sd x11,8(x8)
#addi x12,x0,2
#addi x13,x0,8

#loop:
#bge x12,x13,end

#ld x14,0(x8)
#ld x15,8(x8)

#add x16,x14,x15
#sd x16,16(x8)
#addi x8,x8,8 ->taban adresini sonrakine aktarır mesela ilk 1024 te sonraki x8 aslında 1032yi gosterir          
             #ve 1032 ve 1040 taki(bir sonceki toplami yazdigimiz yer) onları toplar ve 1048 e yazar 
                                 #boyle devam eder
#addi x12,x12,1

#jal x0,loop
#end:


#2.soru
# #2.soru
# lui x8,0
# addi x8,x8,1024
# addi x10,x0,36
# addi x11,x0,60
# sd x10,0(x8)
# sd x11,8(x8)
# ld x10,0(x8)
# ld x11,8(x8)
# ld x15,0(x8) #ekok icin yedeklendi
# ld x16,8(x8) #ekok icin yedeklendi
# 
# 
# ebob_loop:
# beq x11,x0,end_ebob
# rem x12,x10,x11
# addi x10,x11,0 #a ya b yi ata 
# addi x11,x12,0 # b ye a%byi ata
# 
# jal x0,ebob_loop # kosulsuz atlama yapar kosulsuz dongunun basina atlar 
# end_ebob:
# sd x10,16(x8)   # ebob a nin old yerde tutulur sonucu yazar
# 
# #ekok
# mul x12,x15,x16
# ld x17,16(x8)
# div x18,x12,x17
# sd x18,24(x8)



#-----deneme----------
#sayilari toplama

#lui x8,0                # x8'in üst 20 bitini sıfırla (Adresleme hazırlığı)
#addi x8,x8,1024        # x8 = 1024. Bellek başlangıç adresini (pointer) belirle
#addi x10,x0,0          # x10 = 0. Döngü sayacını (i) sıfırdan başlat
#addi x11,x0,3          # x11 = 3. Döngü sınırını belirle (Döngü 3 kez dönecek)
#addi x14,x0,0          # x14 = 0. Toplam değerini tutacak olan yazmacı sıfırla

#loop:                  # Döngü başlangıç etiketi
#beq x10,x11,end        # Eğer i (x10) == 3 (x11) ise döngüden çık ve 'end'e git
    
#ld x12,0(x8)           # x8'in gösterdiği bellek adresindeki veriyi x12'ye yükle
#add x14,x12,x14        # x14 = x12 + x14 (Gelen sayıyı toplama ekle)
#addi x10,x10,1         # i = i + 1 (Döngü sayacını bir artır)
#addi x8,x8,8           # Bir sonraki sayı için bellek adresini 8 byte ilerlet

#jal x0,loop            # Koşulsuz olarak 'loop' etiketine geri dön (Döngü başı)

#end:                   # Döngü bitiş etiketi
#sd x14,0(x8)           # Toplamı (x14), bellekte kalınan son adrese kaydet
#ld x15,0(x8)           # Sonucu kontrol etmek için x15 yazmacına geri yükle

#tek cift
#addi x10,x0,60
#addi x11,x0,2
#kosul:
#rem x12,x10,x11
#beq x12,x0,cift
#bne x12,x0,tek

#tek:
#addi x13,x0,0
#jal x0,bitis
#cift:
#addi x13,x0,1
#jal x0,bitis


#bitis:
#---------------------------------------------------------
#fibbonacci
# lui x8,0
# addi x8,x8,1024
# addi x1,x0,0
# addi x2,x0,1
# sd x1,0(x8)
# sd x2,8(x8)
# addi x3,x0,2
# addi x4,x0,7

# loop:
# bge x3,x4,end
# ld x5,0(x8)
# ld x6,8(x8)
# add x7,x5,x6

# sd x7,16(x8)
# addi x8,x8,8  # sonrakine gec 
# addi x3,x3,1
# jal x0,loop

# end:


#-------lab4
#1 terse yazma
# lui x8,0
# addi x8,x8,1024
# addi x10,x0,123
# addi x15,x0,10
# loop:
# beq x10,x0,end
# rem x11,x10,x15
# sd x11,0(x8)
# addi x8,x8,8
# div x10,x10,x15
# jal x0,loop

# end:



# #2 factorial
# lui x8,0
# addi x8,x8,1024
# addi x10,x0,7
# addi x11,x0,1  #carpim
# addi x12,x0,1 # sayac
# sd x10,0(x8)
# sd x11,8(x8)
# sd x12,16(x8)

# ld x13,0(x8) #n
# ld x14,8(x8)
# ld x15,16(x8)
# loop:
# bge x15,x13 ,end # buyuk esitse bitir.
# mul x14,x14,x15
# sd x14,24(x8)
# addi x8,x8,8
# addi x15,x15,1

# jal x0,loop
# end:


#----lab5
#1 Asallik
# lui x5,0
# addi x5,x0,1024
# addi x6,x0,7
# addi x7,x0,2  # bolen degeri 2 den basla
# addi x8,x0,0  # bolen sayisi 
# loop:
# rem x11,x6,x7
# bne x11,x0,skip_increment
# addi x8,x8,1

# skip_increment:
# addi x7,x7,1
# bge x7,x6,check_result
# jal x0,loop

# check_result:
# addi x9,x0,1
# blt x8,x9,is_prime   #?? eger asal ise x8 0 olmus olur
# asal degilse bu kisim calisir.
# addi x10,x0,0
# sd x10,0(x5)
# jal x0,end

# is_prime:
#
# addi x10,x0,1
# sd x10,0(x5)

# end:


#2 hamming agirligi (binarydeki 1 sayisi)
#lui x5,0
#addi x5,x5,1024  # luiden gelen ust 0 bitleri ile immetiate i birlestirir.
#addi x6,x0,12 # 01100
#addi x7,x0,0 # sayac 1 leri tutuyor
#addi x8,x0,1  # son bit kontrolu 1 atiyor
#loop:
#and x9,x6,x8
#beq x9,x0,skip_inc  #sayi sifirlanana kadar dongu doner. sonraki basamaga gecmek icin
#addi x7,x7,1  # and sonucu 1 ise

#skip_inc:
#srli x6,x6,1  # saga kaydirir bosalan yeri 0larla doldurur.
#beq x6,x0,done
#jal x0,loop
#done:
#sd x7,0(x5)  #en son bellege yaziliyor

#li (Load Immediate - Anında Yükle) adında sahte bir komut (pseudo-instruction) vardır.
#Sen sadece koduna li x5, 17408 yazarsın. Derleyici arka planda bunu otomatik olarak senin dediğin #gibi lui x5, 4 ve addi x5, x5, 1024 şekline çevirip


#--------------------------------
#   -lab sinavi deneme-
#1
# addi x5,x0,12
# addi x6,x0,12
# beq x5,x6,set_flag
# set_flag:
# addi x10,x0,1

#2

# addi x5,x0,-13
# blt x5,x0,negative
# bge x5,x0,positive
# negative:
# sub x5,x0,x5
# positive:
# nop

#3

# addi x5,x0,30
# addi x6,x0,22
# blt x5,x6,end  #zaten olmasini istedigimiz sey bu
# bge x5,x6,swap
# swap:
# add x7,x5,x0
# add x5,x6,x0
# add x6,x7,x0
# end:


#4


# addi x5,x0,0  #toplami tutuyor
# addi x6,x0,1  # sayac
# addi x7,x0,6 #ust sinir bu 5e kadar 5dahil toplar
# loop:
# bge x6,x7,end
# add x5,x5,x6
# addi x6,x6,1
# jal x0, 
# end:

#5


# lui x8,0
# addi x8,x8,1024
# addi x10,x0,0
# addi x11,x0,1
# sd x10,0(x8)
# sd x11,8(x8)

# addi x12,x0,2
# addi x13,x0,7
# fibonacci:
# bge x12,x13,end
# ld x14,0(x8)
# ld x15,8(x8)
# add x16,x14,x15
# sd x16,16(x8)
# addi x8,x8,8
# addi x12,x12,1
# jal x0,fibonacci
# end:

#6


# lui x8,0
# addi x8,x8,1024
# addi x10,x0,36
# addi x11,x0,60
# sd x10,0(x8)
# sd x11,8(x8)

# add x15,x0,x10   #a ve b yedeklenir .
# add x16,x0,x11
# ebob:
# beq x11,x0,end
# rem x12,x10,x11
# add x10,x11,x0
# add x11,x12,x0
# jal x0,ebob
# end:
# sd x10,16(x8)
# ekok:
# add x10,x15,x0
# add x11,x16,x0
# mul x12,x10,x11
# ld x13,16(x8)
# div x14,x12,x13

# sd x14,24(x8)

#7

# lui x8,0
# addi x8,x8,1024
# addi x10,x0,123
# addi x11,x0,10
# loop:
# beq x10,x0,end
# rem x12,x10,x11
# sd x12,0(x8)
# addi x8,x8,8
# div x10,x10,x11
# jal x0,loop
# end:

# addi x16,x0,100

# ld x13,-24(x8)
# ld x14,-16(x8)
# ld x15,-8(x8)

# mul x13,x13,x16
# mul x14,x14,x11
# add x14,x14,x13
# add x14,x14,x15

# sd x14,0(x8)  #tek registerda yazmak istersek.

# 8


# lui x8,0
# addi x8,x8,1024
# addi x10,x0,5
# addi x11,x0,1 # carpim
# addi x12,x0,1 #sayac

# sd x10,0(x8)
# sd x11,8(x8)
# sd x12,16(x8)
# ld x13,0(x8)
# ld x14,8(x8)
# ld x15,16(x8)

# factorial:
# mul x14,x14,x15
# sd x14,24(x8)
# addi x8,x8,8
# addi x15,x15,1
# blt x13,x15,end
# jal x0,factorial
# end:


#9

# lui x5,0        #x5 bellek baslangic adresi
# addi x5,x5,1024
# addi x6,x0,11
# addi x7,x0,2
# addi x8,x0,0

# loop:
# rem x11,x6,x7
# bne x11,x0,skip_increment
# addi x8,x8,1

# skip_increment:
# addi x7,x7,1
# bge x7,x6,check_result
# jal x0,loop

# check_result:
# addi x9,x0,1
# blt x8,x9,is_prime
# addi x10,x0,0
# sd x10,0(x5)
# jal x0,end

# is_prime:
# addi x10,x0,1
# sd x10,0(x5)
# end:


#10

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,12
# addi x7,x0,0  #sayac (1lerin sayisini tutar.)
# addi x8,x0,1

# loop:

# and x9,x6,x8
# bne x9,x8,skip_inc
# addi x7,x7,1

# skip_inc:
# srli x6,x6,1  #right logical bosalan yere 0 
# beq x6,x0,end
# jal x0,loop

# end:
# sd x7,0(x5)  #sonuc bellege yazilir.



#gbt ornek sorularr:
#   Us Alma



# lui x5,0
# addi x5,x5,1024
# addi x10,x0,3   #sayi
# addi x11,x0,4   #ussu
# addi x13,x0,1  #carpim
# addi x14,x0,0   #sayac

# loop:
#    bge x14,x11,end
#    mul x13,x10,x13
#    addi x14,x14,1
#    jal x0,loop
# end:

# sd x13,0(x5)

#   Rakamlar Toplami


# lui x5,0
# addi x5,x5,1024

# addi x10,x0,456 #sayi
# addi x6,x0,10  # mod ve bolme icin
# addi x7,x0,0  #toplami tutar.

# loop:
# rem x8,x10,x6  #son basamagini aldik
# add x7,x7,x8
# div x10,x10,x6
# beq x10,x0,end
# jal x0,loop
# end:
# sd x7,0(x5)

# En Buyuk Sayiyi Bulma

# lui x5,0
# addi x5,x5,1024
# addi x1,x0,1
# addi x2,x0,4

# addi x10,x0,40
# addi x11,x0,2
# addi x12,x0,1
# addi x13,x0,11

# sd x10,0(x5)
# sd x11,8(x5)
# sd x12,16(x5)
# sd x13,24(x5)

# ld x15,0(x5)
# loop:
# bge x1,x2,end
# addi x1,x1,1
# addi x5,x5,8
# ld x14,0(x5)
# blt x15,x14,dallan

# jal x0,loop
# dallan:
# add x15,x0,x14
# jal x0,loop
# end:
# sd x15,8(x5)
 


# #collantz algoritmasi

# lui x5,0
# addi x5,x5,1024

# addi x6,x0,5
# addi x7,x0,1
# addi x9,x0,3

# and x8,x6,x7
# beq x8,x0,cift 
# mul x6,x6,x9

# addi x6,x6,1
# jal x0,end

# cift:
# srli x6,x6,1
# end:
# sd x6,0(x5)

# Ikili Dizi elemanlarini carpma: ic carpim

# lui x7,0
# lui x8,0
# addi x7,x7,1024
# addi x8,x8,2040

# addi x1,x0,10
# addi x2,x0,2
# addi x3,x0,8

# addi x4,x0,3
# addi x5,x0,5
# addi x6,x0,15

# sd x1,0(x7)
# sd x2,8(x7)
# sd x3,16(x7)

# sd x4,0(x8)
# sd x5,8(x8)
# sd x6,16(x8)

# addi x9,x0,0
# addi x10,x0,3
# addi x14,x0,0
# loop:
# bge x9,x10,end
# ld x11,0(x7)
# ld x12,0(x8)
# addi x7,x7,8
# addi x8,x8,8

# mul x13,x11,x12
# add x14,x14,x13
# addi x9,x9,1
# jal x0,loop

# end:

# 50den buyukse sayi 1 degilse 0 yap



# lui x5,0
# addi x5,x5,1024

# addi x11,x0,0
# addi x12,x0,4
# addi x13,x0,50 

# addi x6,x0,5
# addi x7,x0,55
# addi x8,x0,60
# addi x9,x0,43

# sd x6,0(x5)
# sd x7,8(x5)
# sd x8,16(x5)
# sd x9,24(x5)

# loop:
# bge x11,x12,end
# ld x10,0(x5)
# addi x5,x5,8  #sonraki adrese geciyor.
# addi x11,x11,1
# blt x10,x13,dallan #kucukse

# addi x10,x0,1  #dallanmadiysa buyuktur
  

# jal x0,yaz

# dallan:
# addi x10,x0,0

# yaz:
# sd x10,-8(x5)  #once adresi arttirdigim icin o anki konumuna yazmak icin -8 dedik.
# jal x0,loop

# end:


#   Negatif sayilari sıfırlama

 
# lui x5,0
#  addi x5,x5,1024

#  addi x11,x0,0
#  addi x12,x0,4
 

#  addi x6,x0,-5
#  addi x7,x0,55
#  addi x8,x0,-60
#  addi x9,x0,43

#  sd x6,0(x5)
#  sd x7,8(x5)
#  sd x8,16(x5)
#  sd x9,24(x5)
# loop:
# bge x11,x12,end
# ld x10,0(x5)
# addi x11,x11,1
# addi x5,x5,8 

# blt x10,x0,neg


# jal x0,yaz

# neg:
# addi x10,x0,0
# yaz:
# sd x10,-8(x5)  #adresi arttirdigim icin aslinda yazmam gereken yerin 8 fazlasina gecti o yuzden -8 gerisini yani asil islem yaptigim yere yazariz

# jal x0,loop
# end:

# #  Palindrom Kontrolu

# lui x5,0
# lui x6,0
# addi x5,x5,1024
# addi x6,x6,1048 #dizi sonunu tutar
# addi x11,x0,0
# addi x12,x0,2
# addi x15,x0,1  #flag,  default simetriktir
                 #sonuc x15 te tutuluyor.
# addi x7,x0,15
# addi x8,x0,6
# addi x9,x0,6
# addi x10,x0,15

# sd x7,0(x5)
# sd x8,8(x5)
# sd x9,16(x5)
# sd x10,24(x5)
# loop:

# bge x11,x12,end
# ld x13,0(x5)
# ld x14,0(x6)
# bne x13,x14,dallan
# addi x11,x11,1
# addi x5,x5,8
# addi x6,x6,-8
# jal x0,loop

# dallan:

# addi x15,x0,0  # simetri bozuldu demek

# end:


#  Diziyi Tersine Çevirme

# lui x5,0
# lui x6,0

# addi x5,x5,1024  #ilk 
# addi x6,x6,1064  #son eleman

# addi x7,x0,1
# addi x8,x0,2
# addi x9,x0,3
# addi x10,x0,4
# addi x11,x0,5
# addi x12,x0,6

# sd x7,0(x5)
# sd x8,8(x5)
# sd x9,16(x5)
# sd x10,24(x5)
# sd x11,32(x5)
# sd x12,40(x5)

# loop:
# bge x5,x6,end  #Sol pointer, sağ pointer'a yetiştiyse veya geçtiyse DUR!
# ld x15,0(x5)
# ld x16,0(x6)

# sd x16,0(x5)
# sd x15,0(x6)
# addi x13,x13,1
# addi x5,x5,8
# addi x6,x6,-8
# jal x0,loop

# end:

#  Buble Sort (Kucukten Buyuge Sayilari Siralar)

# lui x5,0

# addi x5,x5,1024
# addi x14,x0,0
# addi x15,x0,3 # son eleman zaten sirali olmus olur. Dis dongu sayaci bu.

# addi x7,x0,11
# addi x8,x0,1
# addi x9,x0,18
# addi x10,x0,3


# sd x7,0(x5)
# sd x8,8(x5)
# sd x9,16(x5)
# sd x10,24(x5)


# dis_dongu:
#  bge x14,x15,end2
#  lui x5,0
#  addi x5,x5,1024
#  addi x6,x0,0
#  addi x11,x0,3

#  loop:
#   bge x6,x11,end1
#   ld x12,0(x5)
#   ld x13,8(x5)

#   blt x12,x13,ilerle

#   #x12>x13 den swap
#   sd x13,0(x5)
#   sd x12,8(x5)



#  ilerle:
#   addi x5,x5,8
#   addi x6,x6,1
#   jal x0,loop

#  end1:
#  addi x14,x14,1
#  jal x0,dis_dongu

# end2:

# #ic loopta sadece bir defa dizi taranir duzgun calismasi icin  n-1 defa ayni islemler tekrarlanmali 


# Bounding Box (max ve mini  tek dongude tespit)

  
# lui x5,0   #bunlar pointer aslında
# addi x5,x5,1024


# addi x7,x0,42
# addi x8,x0,12
# addi x9,x0,89
# addi x10,x0,23
# addi x11,x0,5


# sd x7,0(x5)
# sd x8,8(x5)
# sd x9,16(x5)
# sd x10,24(x5)
# sd x11,32(x5)

# ld x14,0(x5)
# ld x15,0(x5)

# addi x6,x0,0
# addi x12,x0,4

# loop:
# bge x6,x12,end
# addi x5,x5,8
# addi x6,x6,1
# ld x16,0(x5)
# blt x14,x16,max
# bge x15,x16,min
# jal x0,loop  #max ve mine gitmeden dongunun basina gitti sayi arada bir yerde demek yani

# max:
# add x14,x16,x0
# jal x0,loop  # bunu koymazsak kod min bolgesine girerdi max olan sayıyı min olarak degistirirdi.
# min:
# add x15,x0,x16
# jal x0,loop  # donguye devam icin gerekli yoksa kod ende gecerdi islemler tekrarlanamazdi
# end:


#  Dizideki Tek Cift Elemanları Ayrıştırma

# lui x4,0
# lui x5,0
# lui x6,0

# addi x4,x4,1024
# addi x5,x5,1024
# addi x5,x5,1024
# addi x6,x6,1024
# addi x6,x6,1024
# addi x6,x6,1024



# addi x7,x0,42
# addi x8,x0,12
# addi x9,x0,89
# addi x10,x0,23
# addi x11,x0,5
# addi x12,x0,4

# addi x13,x0,0
# addi x14,x0,6

# sd x7,0(x4)
# sd x8,8(x4)
# sd x9,16(x4)
# sd x10,24(x4)
# sd x11,32(x4)
# sd x12,40(x4)

# loop:
# bge x13,x14,end
# ld x15,0(x4)
# andi x16,x15,1
# addi x4,x4,8
# addi x13,x13,1
# beq x16,x0,cift
# sd x15,0(x6)  #3072 itibari ile tekler tutuluyor
# addi x6,x6,8
# jal x0,loop
# cift:
# sd x15,0(x5)  #2048den itibaren ciftler tutuluyor
# addi x5,x5,8
# jal x0,loop
# end:

#   Fonksiyonlar 
# lui x1,0
# addi x1,x1,1024
# addi x10,x0,6
# jal x1,kare
# beq x0,x0,end
# end:
# kare: 
# mul x10,x10,x10
# jalr x0,0(x1)

# # buble sort

# lui x5,0
# addi x5,x0,1024


#  addi x6,x0,-5
#  addi x7,x0,55
#  addi x8,x0,-60
#  addi x9,x0,43

#  sd x6,0(x5)
#  sd x7,8(x5)
#  sd x8,16(x5)
#  sd x9,24(x5)
# addi x10,x0,0
# addi x11,x0,3   # dongu 3 kere doner sona kalan eleman zaten sirali olmus olur

# outer_loop:
# lui x5,0
# addi x5,x5,1024
# addi x12,x0,0
# addi x13,x0,3
# bge x10,x11,end2
# inner_loop:
# bge x12,x13,end1
# ld x14,0(x5)
# ld x15,8(x5)

# blt x14,x15,ilerle  #eger sayılar sıralıysa direkt sonrakine kayar.
# sd x14,8(x5)
# sd x15,0(x5)

# ilerle:   #arrtırmaları ilerle de yaparız.
# addi x5,x5,8
# addi x12,x12,1 
# jal x0,inner_loop
# end1:
# addi x10,x10,1
# jal x0,outer_loop
# end2:
#---------------------------------------denemelerr-----
# lui x5,0
# addi x5,x5,1024
# addi x6,x0,123
# sd x6,0(x5)
# addi x7,x0,10 #mod ve bolme islemi icin
# loop:
# beq x6,x0,end
# rem x8,x6,x7
# addi x5,x5,8
# sd x8,0(x5)
# div x6,x6,x7
# jal x0,loop
# end:
# nop


# dizi elemanların max mini

# lui x5,0
# addi x5,x5,1024



# addi x6,x0,12
# addi x7,x0,1
# addi x8,x0,6
# addi x9,x0,43

# sd x6,0(x5)
# sd x7,8(x5)
# sd x8,16(x5)
# sd x9,24(x5)

# addi x10,x0,0
# addi x11,x0,3  # zaten ilk elemanlari dongu disinda alıyoruz o yuzden n-1 defa donmeli dongu.

# ld x12,0(x5)  #min
# ld x13,0(x5)  #max
# loop:

# bge x10,x11,end
# addi x10,x10,1
# addi x5,x5,8
# ld x14,0(x5)
# bge x14,x13,max
# blt x14,x12,min
# jal x0,loop  # ne max ne minse sayı
# max:
# add x13,x14,x0
# jal x0,loop

# min:
# add x12,x14,x0
# jal x0,loop

# end:

#   Diziyi tersten yazma
# lui x4,0
# addi x4,x4,1024

# lui x5,0
# addi x5,x5,1064

# addi x6,x0,1
# addi x7,x0,2
# addi x8,x0,3
# addi x9,x0,4
# addi x10,x0,5
# addi x11,x0,6

# sd x6,0(x4)
# sd x7,8(x4)
# sd x8,16(x4)
# sd x9,24(x4)
# sd x10,32(x4)
# sd x11,40(x4)



# loop:
# bge x4,x5,end
# ld x12,0(x4)
# ld x13,0(x5)
# sd x12,0(x5)
# sd x13,0(x4)
# addi x4,x4,8
# addi x5,x5,-8
# jal x0,loop
# end: 


# Collatz 

# lui x5,0
# addi x5,x5,1024

# addi x7,x0,10
# sd x7,0(x5)
# addi x8,x0,1
# addi x9,x0,3
# loop:
# beq x7,x8,end
# and x10,x7,x8
# beq x10,x8,tek
# srli x7,x7,1  #sayıyı 2ye boler cifttir tek degilse 
# addi x5,x5,8
# sd x7,0(x5)

# jal x0,loop

# tek:
# mul x7,x7,x9
# addi x7,x7,1
# addi x5,x5,8
# sd x7,0(x5)

# jal x0,loop

# end:
#  nop

#mutlak deger
# addi x5,x0,12
# blt x5,x0,negatif
# jal x0,end
# negatif:
# sub x5,x0,x5
# end:
# nop

# Palindrom 

# lui x5,0
# addi x5,x5,1024

# addi x7,x0,1002
# sd x7,0(x5)
# addi x8,x0,10
# add x15,x0,x7
# addi x10,x0,0
# loop:
# beq x7,x0,end
# rem x9,x7,x8
# sd x9,0(x5)
# mul x10,x10,x8
# add x10,x10,x9
# addi x5,x5,8


# div x7,x7,x8
# jal x0,loop
# end:
# beq x10,x15,pal
# addi x11,x0,0
# jal x0,bitis
# pal:
# addi x11,x0,1  # x11de palindrom olup olmadıgı tutulur.
# bitis:


# us alma 

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,5  # sayi
# addi x7,x0,4  #üssü
# addi x8,x0,0
# addi x9,x0,1 #carpimlari tutar.
# loop:
# bge x8,x7,end
# mul x9,x9,x6
# addi x8,x8,1
# jal x0,loop
# end:
# sd x9,0(x5)

# sayılar toplamı

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,5
# addi x7,x0,0 #toplam
# addi x8,x0,0 #sayac 
# loop:
# bge x8,x6,end
# addi x8,x8,1
# add x7,x7,x8
# jal x0,loop
# end:
# sd x7,0(x5)


# sayinin rakamlar toplamı

# lui x5,0
# addi x5,x5,1024

# addi x6,x0,456
# sd x6,0(x5)
# addi x7,x0,0  # toplamı tutar
# addi x8,x0,10 # bolme ve mod alma
# loop:
# beq x6,x0,end
# rem x9,x6,x8
# add x7,x7,x9
# addi x5,x5,8
# sd x9,0(x5)
# div x6,x6,x8
# jal x0,loop
# end:
# sd x7,8(x5)

# Ebob Ekok
# lui x8,0
# addi x8,x8,1024
# addi x6,x0,36
# addi x7,x0,60

# sd x6,0(x8)
# sd x7,8(x8)

# add x9,x0,x6
# add x10,x0,x7  # yedek

# ebob:
# beq x7,x0,end
# rem x11,x6,x7
# add x6,x0,x7
# add x7,x0,x11
# jal x0,ebob
# end:
# sd x6,16(x8)

# ekok:
# ld x12,16(x8) #ebob gelir
# mul x13,x9,x10
# div x13,x13,x12

# sd x13,24(x8)

# factorial


# lui x5,0
# addi x5,x5,1024
# addi x6,x0,5

# sd x6,0(x5)
# addi x7,x0,1  #carpimlari tutar.

# addi x8,x0,0  #sayac

# sd x7,8(x5)
# addi x5,x5,8
# beq x6,x0,end
# loop:
# bge x8,x6,end
# addi x8,x8,1
# mul x7,x7,x8
# sd x7,8(x5)
# addi x5,x5,8
# jal x0,loop

# end:

# Fibbonacci

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,0     #fib(0)
# addi x7,x0,1     #fib(1)
# sd x6,0(x5)
# sd x7,8(x5)
# addi x8,x0,0
# addi x9,x0,5
# loop:
# bge x8,x9,end
# ld x10,0(x5)
# ld x11,8(x5)
# addi x5,x5,8
# add x12,x10,x11
# sd x12,8(x5)
# addi x8,x8,1
# jal x0,loop
# end:       ##! optimizasyon için bellege gitmek uzun süreceği için  biz registerları kaydırarak da
             ## hesaplama yapabiliriz.

#ic carpim



# lui x4,0
# lui x5,0

# addi x4,x4,1024
# addi x5,x5,1024
# addi x5,x5,1024

# addi x6,x0,1
# addi x7,x0,2
# addi x8,x0,5

# sd x6,0(x4)
# sd x7,8(x4)
# sd x8,16(x4)

# addi x9,x0,1
# addi x10,x0,2
# addi x11,x0,5

# sd x9,0(x5)
# sd x10,8(x5)
# sd x11,16(x5)
# addi x15,x0,0
# addi x16,x0,3
# addi x17,x0,0
# loop:
# bge x15,x16,end
# ld x12,0(x4)
# ld x13,0(x5)
# mul x14,x12,x13
# add x17,x17,x14
# addi x4,x4,8
# addi x5,x5,8
# addi x15,x15,1
# jal x0,loop


#1 

# addi x5,x0,42
# addi x6,x0,42
# beq x5,x6,set_flag

# set_flag:
# addi x10,x0,1

#2

# addi x5,x0,-13
# blt x5,x0,neg
# bge x5,x0,poz
# neg:
# sub x5,x0,x5
# poz:
# nop

#3
# addi x5,x0,33
# addi x6,x0,12
# blt x5,x6,end
# bge x5,x6,swap
# swap:
# add x7,x0,x5
# add x5,x0,x6
# add x6,x0,x7
# end:

#4
# addi x5,x0,0  #toplam
# addi x6,x0,1 # sayac
# addi x7,x0,5  #n
# loop:
# blt x7,x6,end
# add x5,x5,x6
# addi x6,x6,1
# jal x0,loop
# end:

#5 fib
# lui x5,0
# addi x5,x5,1024
# addi x6,x0,0
# addi x7,x0,1
# sd x6,0(x5)
# sd x7,8(x5)
# addi x8,x0,0
# addi x9,x0,4
# loop:
# bge x8,x9,end
# ld x10,0(x5)
# ld x11,8(x5)
# add x12,x10,x11
# sd x12,16(x5)
# addi x5,x5,8
# addi x8,x8,1
# jal x0,loop # unutmaaaa
# end:


#ebob-ekok

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,36
# addi x7,x0,60
# sd x6,0(x5)
# sd x7,8(x5)
# add x8,x0,x6
# add x9,x0,x7
# ebob:
# beq x7,x0,end
# rem x10,x6,x7
# add x6,x7,x0
# add x7,x10,x0
# jal x0,ebob
# end:
# sd x6,16(x5)
# ekok:
# ld x11,16(x5)
# mul x12,x8,x9
# div x13,x12,x11

# sd x13,24(x5)

#lab4
#1
# lui x8,0
# addi x8,x8,1024

# addi x9,x0,123
# sd x9,0(x8)
# addi x10,x0,10
# loop:
# beq x9,x0,end
# rem x11,x9,x10
# sd x11,8(x8)
# addi x8,x8,8
# div x9,x9,x10
# jal x0,loop
# end:


#2

# lui x8,0
# addi x8,x8,1024

# addi x10,x0,5
# addi x11,x0,1  #carpim 
# addi x12,x0,0  #sayac
# sd x10,0(x8)
# sd x11,8(x8)
# sd x12,16(x8)

# ld x13,0(x8)
# ld x14,8(x8)
# ld x15,16(x8)
# loop:
# bge x15,x13,end
# addi x15,x15,1
# mul x14,x14,x15
# sd x14,24(x8)
# addi x8,x8,8
# jal x0,loop
# end:

#lab5 
#1 asallık
# lui x5,0
# addi x5,x5,1024
# addi x6,x0,5
# addi x7,x0,2
# addi x8,x0,0  # bolen sayisi
# loop:
# rem x9,x6,x7
# bne x9,x0,skip
# addi x8,x8,1
# skip:
# addi x7,x7,1
# bge x7,x6,check
# jal x0,loop
# check:
# addi x9,x0,1
# blt x8,x9,is_prime
# addi x10,x0,0
# sd x10,0(x5)
# jal x0,end
# is_prime:
# addi x10,x0,1
# sd x10,0(x5)
# end:

#Fibbonacci

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,0  #fib(0)
# addi x7,x0,1  #fib(1)
# sd x6,0(x5)
# sd x7,8(x5)
# addi x8,x0,0
# addi x9,x0,6  #dongu 6 kez doner  01/234567
# loop:
# bge x8,x9,end
# ld x10,0(x5)
# ld x11,8(x5)
# add x12,x10,x11
# sd x12,16(x5)
# addi x5,x5,8
# addi x8,x8,1
# jal x0,loop
# end: 

# Asallik:
# lui x5,0
# addi x5,x5,1024
# addi x6,x0,15
# addi x7,x0,2
# addi x8,x0,0  # bolen sayisi
# loop:
# rem x9,x6,x7
# bne x9,x0,skip
# addi x8,x8,1
# skip:
# bge x7,x6,check_result
# addi x7,x7,1

# jal x0,loop
# check_result:
# addi x9,x0,1
# bge x9,x8,asal
# addi x10,x0,0
# jal x0,end

# asal:
# addi x10,x0,1
# end:

# sd x10,0(x5)

# üs alma
#lui x5,0
#addi x5,x5,1024
#addi x6,x0,3
#addi x7,x0,5
#addi x8,x0,0
#addi x9,x8,1
#sd x9,0(x5)
#loop:
#bge x8,x7,end
#mul x9,x9,x6
#sd x9,8(x5)
#addi x5,x5,8
#addi x8,x8,1
#jal x0,loop
#end:

#ebob-ekok

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,36
# addi x7,x0,60
# sd x6,0(x5)
# sd x7,8(x5)
# add x8,x0,x6
# add x9,x0,x7

# ebob_loop:
# beq x7,x0,end
# rem x10,x6,x7
# add x6,x0,x7
# add x7,x0,x10
# jal x0,ebob_loop
# end:
# sd x6,16(x5)
# #ekok
# mul x11,x8,x9
# div x11,x11,x6
# sd x11,24(x5)


#Factorial

# lui x5, 0           # x5'in ust 20 bitine 0 yukle (x5 = 0)
# addi x5, x5, 1024   # x5 = 1024 (Verilerin yazilacagi taban bellek adresi)
# addi x6, x0, 6      # x6 = 6 (Faktoriyeli alinacak hedef sayi)
# addi x7, x0, 1      # x7 = 1 (Carpim sonucu, baslangicta yutan eleman olmamasi icin 1)
# addi x8, x0, 1      # x8 = 1 (Dongu sayaci)
# 
# sd x7, 0(x5)        # 0! = 1 istisnasini temsil etmesi icin 1024 adresine kaydet
# 
# # loop:
# # blt x6, x8, end     # Hedef(x6) < Sayac(x8) ise 'end' etiketine dallan
# # mul x7, x7, x8      # x7 = x7 * x8 (Yeni faktoriyel degerini hesapla)
# # addi x8, x8, 1      # Sayaci (x8) bir artir
# # sd x7, 8(x5)        # Yeni sonucu mevcut bellek adresinin 8 byte ilerisine kaydet
# # addi x5, x5, 8      # Bellek isaretcisini (x5) 8 byte ileri tasi (veriler ust uste binmesin)
# # jal x0, loop        # Kosulsuz 'loop' etiketine don
# 
# # end:                # Dongu kirildiginda gelinecek bitis noktasi


#Collantz Alg

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,10
# sd x6,0(x5)
# addi x7,x0,2
# addi x8,x0,1
# addi x10,x0,3
# loop:
# beq x6,x8,end
# rem x9,x6,x7
# beq x9,x0,cift
# #cift degilse tektir
# mul x6,x6,x10
# addi x6,x6,1
# sd x6,8(x5)
# addi x5,x5,8
# jal x0,loop
# cift:
# srli x6,x6,1  #pozitifi 2 ye bolmek icin kullanilir.
# sd x6,8(x5)
# addi x5,x5,8
# jal x0,loop
# end:


#palindrom kont.
# lui x5,0
# addi x5,x5,1024
# addi x6,x0,1221
# addi x7,x0,10
# addi x8,x0,0
# add x10,x0,x6
# addi x11,x0,0
# loop:
# beq x6,x0,kontrol
# rem x9,x6,x7
# mul x8,x8,x7
# add x8,x8,x9
# div x6,x6,x7
# sd x8,0(x5)
# addi x5,x5,8
# jal x0,loop
# kontrol:
# beq x8,x10,pal
# jal x0,end
# pal:
# addi x11,x0,1
# end:
# sd x11,0(x5)
# nop


# Sayilar Toplami

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,1089
# addi x7,x0,0   #toplam
# addi x8,x0,10  #mod ve bolme icin
# loop:
# beq x6,x0,end
# rem x9,x6,x8
# add x7,x7,x9
# div x6,x6,x8
# jal x0,loop
# end:
# sd x7,0(x5)

# Sayiyi tersten yazma

#lui x5,0
#addi x5,x5,1024
#addi x6,x0,175
#addi x7,x0,10
#addi x8,x0,0
#loop:
#beq x6,x0,end 
#rem x9,x6,x7
#mul x8,x8,x7
#add x8,x8,x9
#sd x8,0(x5)
#addi x5,x5,8
#div x6,x6,x7
#jal x0,loop
#end:
#nop

#Mukemmel Sayi Kontrolu

# lui x5,0
# addi x5,x5,1024
# addi x6,x0,28 #pozitif sayi
# addi x7,x0,0  # bolen toplami
# addi x8,x0,1  # bolen
# addi x10,x0,0  #mukkemel flag def=0
# add x11,x0,x6
# srli x11,x11,1

# loop:
# blt x11,x8,kontrol
# rem x9,x6,x8
# bne x9,x0,skip
# add x7,x7,x8
# skip:
# addi x8,x8,1
# jal x0,loop
# kontrol:
# beq x6,x7,muq

# sd x10,0(x5)
# jal x0,end
# muq:
# addi x10,x0,1
# sd x10,0(x5)
# end:
# sd x7,8(x5)


# Arrayde max min kontrolu
# lui x5,0
# addi x5,x5,1024
# addi x6,x0,12
# addi x7,x0,30
# addi x8,x0,23
# sd x6,0(x5)
# sd x7,8(x5)
# sd x8,16(x5)
# addi x9,x0,0
# addi x10,x0,2

# ld x11,0(x5)   #max
# ld x12,0(x5)   #min
# addi x5,x5,8
# loop:
# bge x9,x10,end
# ld x13,0(x5)
# addi x5,x5,8
# addi x9,x9,1
# bge x13,x11,max
# blt x13,x12,min
# jal x0,loop

# max:
# add x11,x0,x13
# jal x0,loop

# min:
# add x12,x0,x13
# jal x0,loop

# end:
# sd x11,0(x5)
# sd x12, 8(x5)



# Armstrong  Sayi

#     lui x5,0
# addi x5,x5,1024
# addi x6,x0,1634
# addi x7,x0,10
# addi x8,x0,0  #toplami tutar
# add x14,x0,x6 #sayiyi yedekle karsilastirma icin 
# addi x13,x0,0  #flag
# addi x12,x0,0   # basamak sayisini tutar
# add x15,x6,x0
# basamak:
# beq x15,x0,loop
# div x15,x15,x7
# addi x12,x12,1
# jal x0,basamak

# loop:
# beq x6,x0,end
# rem x9,x6,x7
# div x6,x6,x7

# addi x10,x0,1
# addi x11,x0,0

# us:
# bge x11,x12,end_us
# mul x10,x10,x9
# addi x11,x11,1
# jal x0,us
# end_us:
# add x8,x8,x10
# jal x0,loop
# end:
# sd x8,0(x5)
# bne x8,x14,degil
# addi x13,x0,1
# degil:
# nop

# sd x13,8(x5)


#Buble Sort tekrar 
# lui x5,0
# addi x5,x5,1024

# addi x6,x0,23
# addi x7,x0,34
# addi x8,x0,2

# sd x6,0(x5)
# sd x7,8(x5)
# sd x8,16(x5)

# addi x9,x0,0
# addi x10,x0,3
# loop_out:
# bge x9,x10,end_out
# addi x13,x0,0
# addi x14,x0,2
# lui x5,0    #bellek adreslerini her dış dongude baslagica sabitler
# addi x5,x5,1024  
# inner_loop:
# bge x13,x14,end_inner
# ld x11,0(x5)
# ld x12,8(x5)

# blt x11,x12,swap_skip
# sd x11,8(x5)
# sd x12,0(x5)

# swap_skip:
# addi x5,x5,8
# addi x13,x13,1
# jal x0,inner_loop
# end_inner:
# addi x9,x9,1
# jal x0,loop_out
# end_out:
# nop



# Buble sort
lui x5,0
addi x5,x5,1024
addi x6,x0,12
addi x7,x0,22
addi x8,x0,5

sd x6,0(x5)
sd x7,8(x5)
sd x8,16(x5)
addi x9,x0,0
addi x10,x0,3
outer_loop:
bge x9,x10,end_out
addi x11,x0,0
addi x12,x0,2
lui x5,0
addi x5,x5,1024
inner_loop:
bge x11,x12,end_inner
ld x13,0(x5)
ld x14,8(x5)
blt x13,x14,swap_skip
sd x13,8(x5)
sd x14,0(x5)
swap_skip:
addi x11,x11,1
addi x5,x5,8
jal x0,inner_loop
end_inner:
/addi x9,x9,1
jal x0,outer_loop
end_out:
nop

