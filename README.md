# CSE220
Programming assignments for assembly language programming,  concepts of computer organization, and architecture course.

* **hw1**
  * 
* **hw2**
  * int replace1st(char[] string, char toReplace, char replaceWith)
  * int printStringArray(String[] sarray, int startIndex, int endIndex, int length)
  * int verifyIPv4Checksum(byte[] header)
  * (int,int) extraData(Packet[] parray, int n, byte[] msg)
  * int processDatagram(byte[] msg, int M, String[] sarray)
  * int printDatagram(Packet[] parray, int n, byte[] msg, String[] sarray)
* **hw3 dependent on hw2**
  * (int, int) extractUnorederedData(Packet[] parray, int n, byte[] msg, int packetentrysize)
  * int printUnorderedDatagram(Packet[] parray, int n, byte[] msg, String[] sarray, int packetentrysize)
  * int editDistance(String str1, String str2, int m, int n) **recursive**
* **2048 halfword size**
  * 2048.docx has test cases for the functions.
  * game.asm allows the **user to play the actual game**.
    * This file (to play the entire game) was not required for the homework.
    * Allows user to play from a **2x2 board to an 8x8 board**.
    * Row & col of board does not need to be equivalent.
    * With this said, the user **must use the correct mars version** which has the **2048 GUI**.
  * hw4.asm contains all the functions required for this assignment.
  * hw4_examples.asm contains test cases for 2048.docx
  * hw4_test.asm contains test cases which was given by the prof.
  * shift.asm is a continuation of hw4_examples.asm which tests only the shift functions.
  
  * int clear_board(cell[][] board, int num_rows, int num_cols)
  * int place(int[][] board, int n_rows, int n_cols, int row, int col, int val)
  * int start_game(cell[][] board, int num_rows, int num_cols, int r1, int c1, int r2, int c2)
  * int merge_row(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int merge_col(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int shift_row(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int shift_col(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int check_state(cell[][] board, int num_rows, int num_cols)
  * (int, int) user_move(cell[][] board, int num_rows, int num_cols, char dir)
* **2048 word size**
  * int clear_board(cell[][] board, int num_rows, int num_cols)
  * int place(int[][] board, int n_rows, int n_cols, int row, int col, int val)
  * int start_game(cell[][] board, int num_rows, int num_cols, int r1, int c1, int r2, int c2)
  * int merge_row(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int merge_col(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int shift_row(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int shift_col(cell[][] board, int num_rows, int num_cols, int row, int direction)
  * int check_state(cell[][] board, int num_rows, int num_cols)
  * (int, int) user_move(cell[][] board, int num_rows, int num_cols, char dir)
