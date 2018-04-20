import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class BinaryToHex {
    public static String code = "00100000000010110000011111010000\n" +
            "00100000000011110000000000000100\n" +
            "00100000000000010000000000000011\n" +
            "00100000000000100000000000000100\n" +
            "00000000001000100001100000100100\n" +
            "00100000000010100000000000000000\n" +
            "00000001010011110000000000011000\n" +
            "00000000000000000110000000010010\n" +
            "00000001011011000110100000100000\n" +
            "00000000000000110001000000100000\n" +
            "10101101101000100000000000000000\n" +
            "00010000001000000000000000001001\n" +
            "00010000010000000000000000001000\n" +
            "00100000000001000000000000000001\n" +
            "00100000000010100000000000000001\n" +
            "00000001010011110000000000011000\n" +
            "00000000000000000110000000010010\n" +
            "00000001011011000110100000100000\n" +
            "00000000000001000001000000100000\n" +
            "10101101101000100000000000000000\n" +
            "00001000000000000000000000010110\n" +
            "00100000000001000000000000000000\n" +
            "00000000001000100010100000100101\n" +
            "00100000000010100000000000000011\n" +
            "00000001010011110000000000011000\n" +
            "00000000000000000110000000010010\n" +
            "00000001011011000110100000100000\n" +
            "00000000000001010001000000100000\n" +
            "10101101101000100000000000000000\n" +
            "00010100001000000000000000001001\n" +
            "00010100010000000000000000001000\n" +
            "00100000000001100000000000000000\n" +
            "00100000000010100000000000000100\n" +
            "00000001010011110000000000011000\n" +
            "00000000000000000110000000010010\n" +
            "00000001011011000110100000100000\n" +
            "00000000000001100001000000100000\n" +
            "10101101101000100000000000000000\n" +
            "00001000000000000000000000101000\n" +
            "00100000000001100000000000000001\n" +
            "00010001011010111111111111111111\n";
    static String assemblyCode = "0x00000000: addi $t3, $zero, 0x7d0\n" +
            "0x00000004: addi $t7, $zero, 4\n" +
            "0x00000008: addi $at, $zero, 3\n" +
            "0x0000000c: addi $v0, $zero, 4\n" +
            "0x00000010: and $v1, $at, $v0\n" +
            "0x00000014: addi $t2, $zero, 0\n" +
            "0x00000018: mult $t2, $t7\n" +
            "0x0000001c: mflo $t4\n" +
            "0x00000020: add $t5, $t3, $t4\n" +
            "0x00000024: add $v0, $zero, $v1\n" +
            "0x00000028: sw $v0, ($t5)\n" +
            "0x0000002c: beqz $at, 0x54\n" +
            "0x00000030: beqz $v0, 0x54\n" +
            "0x00000034: addi $a0, $zero, 1\n" +
            "0x00000038: addi $t2, $zero, 1\n" +
            "0x0000003c: mult $t2, $t7\n" +
            "0x00000040: mflo $t4\n" +
            "0x00000044: add $t5, $t3, $t4\n" +
            "0x00000048: add $v0, $zero, $a0\n" +
            "0x0000004c: sw $v0, ($t5)\n" +
            "0x00000050: j 0x58\n" +
            "0x00000054: addi $a0, $zero, 0\n" +
            "0x00000058: or $a1, $at, $v0\n" +
            "0x0000005c: addi $t2, $zero, 3\n" +
            "0x00000060: mult $t2, $t7\n" +
            "0x00000064: mflo $t4\n" +
            "0x00000068: add $t5, $t3, $t4\n" +
            "0x0000006c: add $v0, $zero, $a1\n" +
            "0x00000070: sw $v0, ($t5)\n" +
            "0x00000074: bnez $at, 0x9c\n" +
            "0x00000078: bnez $v0, 0x9c\n" +
            "0x0000007c: addi $a2, $zero, 0\n" +
            "0x00000080: addi $t2, $zero, 4\n" +
            "0x00000084: mult $t2, $t7\n" +
            "0x00000088: mflo $t4\n" +
            "0x0000008c: add $t5, $t3, $t4\n" +
            "0x00000090: add $v0, $zero, $a2\n" +
            "0x00000094: sw $v0, ($t5)\n" +
            "0x00000098: j 0xa0\n" +
            "0x0000009c: addi $a2, $zero, 1\n" +
            "0x000000a0: beq $t3, $t3, 0xa0";
    public static void main(String[] args){
        String[] listOfCode = code.split("\n");
        for(int i = 0; i < listOfCode.length; i++){
            int dec = Integer.parseUnsignedInt(listOfCode[i],2);
            String hexString = Integer.toHexString(dec);
            while(hexString.length() < 8){
                hexString = "0" + hexString;
            }
            System.out.println(hexString);
        }
        System.out.println();
        String[] listOfAssembly = assemblyCode.replace("\n", ":").split(":");
        for(int i = 1; i < listOfAssembly.length; i+=2){
            listOfAssembly[i] = listOfAssembly[i].replace("$zero", "$0");
            listOfAssembly[i] = listOfAssembly[i].replace("$at", "$1");
            listOfAssembly[i] = listOfAssembly[i].replace("$v0", "$2");
            listOfAssembly[i] = listOfAssembly[i].replace("$v1", "$3");
            listOfAssembly[i] = listOfAssembly[i].replace("$a0", "$4");
            listOfAssembly[i] = listOfAssembly[i].replace("$a1", "$5");
            listOfAssembly[i] = listOfAssembly[i].replace("$a2", "$6");
            listOfAssembly[i] = listOfAssembly[i].replace("$a3", "$7");
            listOfAssembly[i] = listOfAssembly[i].replace("$t0", "$8");
            listOfAssembly[i] = listOfAssembly[i].replace("$t1", "$9");
            listOfAssembly[i] = listOfAssembly[i].replace("$t2", "$10");
            listOfAssembly[i] = listOfAssembly[i].replace("$t3", "$11");
            listOfAssembly[i] = listOfAssembly[i].replace("$t4", "$12");
            listOfAssembly[i] = listOfAssembly[i].replace("$t5", "$13");
            listOfAssembly[i] = listOfAssembly[i].replace("$t6", "$14");
            listOfAssembly[i] = listOfAssembly[i].replace("$t7", "$15");
            listOfAssembly[i] = listOfAssembly[i].replace("$s0", "$16");
            listOfAssembly[i] = listOfAssembly[i].replace("$s1", "$17");
            listOfAssembly[i] = listOfAssembly[i].replace("$s2", "$18");
            listOfAssembly[i] = listOfAssembly[i].replace("$s3", "$19");
            listOfAssembly[i] = listOfAssembly[i].replace("$s4", "$20");
            listOfAssembly[i] = listOfAssembly[i].replace("$s5", "$21");
            listOfAssembly[i] = listOfAssembly[i].replace("$s6", "$22");
            listOfAssembly[i] = listOfAssembly[i].replace("$s7", "$23");
            listOfAssembly[i] = listOfAssembly[i].replace("$t8", "$24");
            listOfAssembly[i] = listOfAssembly[i].replace("$t9", "$25");
            listOfAssembly[i] = listOfAssembly[i].replace("$k0", "$26");
            listOfAssembly[i] = listOfAssembly[i].replace("$k1", "$27");
            listOfAssembly[i] = listOfAssembly[i].replace("$gp", "$28");
            listOfAssembly[i] = listOfAssembly[i].replace("$sp", "$29");
            listOfAssembly[i] = listOfAssembly[i].replace("$fp", "$30");
            listOfAssembly[i] = listOfAssembly[i].replace("$ra", "$31");

            String re1="\\d\\w\\w++";	// Non-greedy match on filler


            Pattern p = Pattern.compile(re1,Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
            Matcher m = p.matcher(listOfAssembly[i]);
            if (m.find())
            {
                String pattern = m.group().toString();
                String[] patterns = pattern.split("x");
                int temp = Integer.parseUnsignedInt(patterns[1],16);
                listOfAssembly[i] = listOfAssembly[i].replaceFirst(re1,Integer.toString(temp));
            }

            System.out.println(listOfAssembly[i].trim());
        }
    }
}
