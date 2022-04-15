import de.bezier.guido.*; //importing a button program where the buttons are able to be turned on or off, the buttons will be used as the mines and tiles in the minesweeper game!
private MSButton[][] buttons; //a 2D array that holds a certain amount of rows of buttons, and collumns of buttons, the buttons can be turns on and off, and will be visible on the screen.
private ArrayList <MSButton> mines; //an ArrayList that holds the number of mines in the program
private final static int NUM_ROWS = 20; //the number of rows in the program
private final static int NUM_COLS = 20; //the number of collumns in the program
private final static int NUM_MINES = 80; //the total number of mines in the program
void setup (){ //setup for the game, the return type is void so there is nothing to return
    size(400, 400); //sets the size of the minesweeper game in pixels
    background(203); //sets the background to gray
    textAlign(CENTER,CENTER); //aligns the text to the center, this will be used when the mines get the labels
    Interactive.make(this);
    buttons = new MSButton[NUM_ROWS][NUM_COLS]; //initializes the new 2D array for the buttons/mines
    for(int r = 0;r<NUM_ROWS;r++){ //outer loop to make the 2D array of buttons
      for(int c = 0;c<NUM_COLS;c++){ //inner loop to make the 2D array of buttons
        buttons[r][c] = new MSButton(r,c); //makes the 2D array "parts" MSbuttons
      }
    }
    mines = new ArrayList<MSButton>(); //initializes the mine arrayList
    setMines(); //calling the setMines function
}
public void setMines(){ //the setMines function
  while(mines.size()<NUM_MINES){ //while loop that randomly adds mines as long as the number of mines is less than the number of mines allowed
    int r = (int)(Math.random()*NUM_ROWS); //randomizes the row that the mine should be located
    int c = (int)(Math.random()*NUM_ROWS);   //randomizes the collumn that the mine should be added, NUM_ROWS is used because the number of rows and collumns are the same
    if(!mines.contains(buttons[r][c])){ //checks to see if there is not a mine already in the randomly chosen location
      mines.add(buttons[r][c]); //adds a mine to the location if there is no mine located there
    }
  }
}
public void draw (){ //draw function, no return type is used here, so void is used
    background(0); //makes the background black
    if(isWon() == true) //checks to see if the player has won
        displayWinningMessage(); //displays winning message if above statement is true
        text("You Win",200,200); //display text if you win
}
public boolean isWon(){ //isWon function, to see if the player won
    int sum = 0; //sum starts at 0, and is true when sum = mines.size()
    for(int r = 0;r<mines.size();r++){ //checks to see if you've flagged enough mines
      if(mines.get(r).flagged == true){ //checks to see if a mine is flagged or not
          sum++; //adds if the mine is flagged
        }     
    }
    if(sum==mines.size()){ //if the sum is equal to the amount of mines, then you win
      return true; //returns true because you win
    }
    return false; //returns false because not all of the mines have been flagged
}
public void displayLosingMessage(){
    for(int r = 0;r<mines.size();r++){
      mines.get(r).clicked=true;
    }
    stroke(255,0,0);
}
public void displayWinningMessage(){
    stroke(0,255,0);
}
public boolean isValid(int r, int c){
     if(c<0||r<0){
    return false;
  }
  if(r>NUM_ROWS-1){
    return false;
  }
  if(c>NUM_COLS-1){
    return false;
  }
  return true;
}
public int countMines(int row, int col){ //counts the number of mines 1 space from the tile you clicked on
  int SARYNEVERCLEAR = 0;
  for(int r = row-1; r <= row+1; r++){
    for(int c = col-1; c <= col+1; c++){
      if(isValid(r,c) && mines.contains(buttons[r][c])){
        SARYNEVERCLEAR++;
      }
    }
  }
  if(mines.contains(buttons[row][col])){
    SARYNEVERCLEAR--;
  }
  return SARYNEVERCLEAR;
}
public class MSButton{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
    public MSButton ( int row, int col ){
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this );
    }
    public void mousePressed (){
      clicked = true;
        if(mouseButton == RIGHT){
          flagged = !flagged;
          clicked = false;
          myLabel = "";
        }else if(mines.contains(this)){
          displayLosingMessage();}
      else if(countMines(this.getR(),this.getC())>0){
         myLabel = countMines(myRow,myCol) + "";
      }else{
        for(int g = -1;g<=1;g++){
          for(int l = -1;l<=1;l++){
            if(isValid(myRow+g,myCol+l)==true && buttons[myRow+g][myCol+l].clicked==false){
            buttons[myRow+g][myCol+l].mousePressed();
          }
        }
      }
    }
  }
    public void draw (){    
       if (flagged)
          fill(0);
        else if( clicked && mines.contains(this) )
           fill(255,0,0);
        else if(clicked)
           fill( 200 );
        else
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel){
        myLabel = newLabel;
    }
    public void setLabel(int newLabel){
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged(){
        return flagged;
    }
    public int getR(){
      return myRow;
    }
    public int getC(){
      return myCol;
    }
}
