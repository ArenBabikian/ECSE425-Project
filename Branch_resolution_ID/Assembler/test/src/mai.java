public class mai {
    public static void main(String[] args){
        for(int i = 0; i < 32; i++){
            System.out.println("addi $" + i + ", $0, " + (16*i));
        }
    }
}
