//This code works on GitHub! Just copy paste the code and create your page and it should work!
import de.bezier.guido.*; //importing a button program where the buttons are able to be turned on or off, the buttons will be used as the mines and tiles in the minesweeper game!
private MSButton[][] buttons; //a 2D array that holds a certain amount of rows of buttons, and columns of buttons, the buttons can be turns on and off, and will be visible on the screen.
private ArrayList <MSButton> mines; //an ArrayList that holds the number of mines in the program
private final static int NUM_ROWS = 20; //the number of rows in the program
private final static int NUM_COLS = 20; //the number of columns in the program
private final static int NUM_MINES = 40; //the total number of mines in the program
void setup (){ //setup for the game, the return type is void so there is nothing to return
    size(400, 400); //sets the size of the minesweeper game
    background(203); //sets the background to gray
    textAlign(CENTER,CENTER); //aligns the text to the center, this will be used when the mines get the labels
    Interactive.make(this); //taken from Mr. Simon's code
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
    int c = (int)(Math.random()*NUM_ROWS);   //randomizes the column that the mine should be added, NUM_ROWS is used because the number of rows and columns are the same
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
public void displayLosingMessage(){ //displays the message if you lose
    for(int r = 0;r<mines.size();r++){ //loops to see all the mines
      mines.get(r).clicked=true; //if you happened to click a mine, then you are going to be called a loser
    }
    stroke(255,0,0); //highlights the outside of the mines in red, signifying that you lost
}
public void displayWinningMessage(){ //if winning message is true, then this will happen
    stroke(0,255,0); //the borders of all the mines will turn green, meaning that you won
}
public boolean isValid(int r, int c){ //function to check if any specific tile is a valid position, this will be used to check for the next function which counts the mines, if you don't have this, then the game will crash because of an array out of bounds error
     if(c<0||r<0){ //if the row or column is less then 0, then it is not a spot on the 2D array
    return false; //if the above condition is true, then this will return false, which will be important for the next function
  }
  if(r>NUM_ROWS-1){ //if r is greater than the number of rows-1, then it is not a valid position in the 2D array, and thus would go out of bounds
    return false; //if the above condition is true, then this will return false, which will be important for the next function
  }
  if(c>NUM_COLS-1){ //if c is greater than the number of columns-1, then it is not a valid position in the 2D array, and thus would go out of bounds
    return false; //if the above condition is true, then this will return false, which will be important for the next function
  }
  return true; //if none of the above conditions are true, then the position MUST be valid on the 2D array, and thus you return true, and else statement is not needed here because the return statement signifies that it's an else/final statement in the function
}
public int countMines(int row, int col){ //counts the number of mines 1 space from the tile you clicked on
  int SARYNEVERCLEAR = 0; //variable to count the mines
  for(int r = row-1; r <= row+1; r++){ //for loop that loops through the number of rows
    for(int c = col-1; c <= col+1; c++){ //nested for loop that loops through the number of columns, the nested loop means that it will loop through both the rows and the columns
      if(isValid(r,c) && mines.contains(buttons[r][c])){ //uses the isValid function, which will check to see if the position in the 2D array is a valid position, if that is true, then it will check to see if the tiles exactly 1 spot away from the tile you clicked contains a mine, the statement checks all including the tile itself, which is why the next if statement is necessary
        SARYNEVERCLEAR++; //adds if the above condition is true
      }
    }
  }
  if(mines.contains(buttons[row][col])){ //checks to see if the tile itself is a mine, if true then you'll have to deduct 1 mine from your variable
    SARYNEVERCLEAR--; //deducts 1 mine
  }
  return SARYNEVERCLEAR; //returns the total number of mines exactly 1 spot away from the tile you clicked on
}
public class MSButton{ //creates the new MSButton class
    private int myRow, myCol; //creates 2 private int values to represent the number of rows and number of columns
    private float x,y, width, height; //creates 4 float variables to represent the length and width of each rectangle, as well as the x and y position
    private boolean clicked, flagged; //creates 2 boolean variables to represent whether or not a buttons has been clicked or flagged
    private String myLabel; //creates a string that will allow for a label to be put on each tile which will represent the number of mines adjacent to it
   
    public MSButton (int row, int col){ //initializes the values of every variable in the class
        width = 400/NUM_COLS; //initializes the width integer, which will be used to make the button rectangles
        height = 400/NUM_ROWS; //initializes the height integer, which will be used to make the button rectangles
        myRow = row; //sets the row equal to row
        myCol = col; //sets the column equal to column
        x = myCol*width; //sets x equal to the column number multiplied by the width
        y = myRow*height; //sets y equal to the row number multiplied by the height
        myLabel = ""; //sets the label equal to an empty string for the time being
        flagged = clicked = false; //sets flagged, and clicked to false
        Interactive.add(this); //taken from Mr. Simon's code
    }
    public void mousePressed (){ //function to click on tiles
      clicked = true; //boolean starts as true
        if(mouseButton == RIGHT){ //if you right click
          flagged = !flagged; //flagged changes its current position, if it's flagged, it's unflagged, if it's unflagged, its flagged
          clicked = false; //clicked then shifts to false;
          myLabel = ""; //label is empty because you don't want to reveal any mines
        }
        else if(mines.contains(this)){ //if you click and the tile is a mine
          displayLosingMessage(); //you lose
          }
      else if(countMines(this.getR(),this.getC())>0){ //if the tile in the position has over 0 mines
         myLabel = countMines(myRow,myCol) + ""; //the label is now the amount of mines around the tile
      }
      else{ //if neither is true
        for(int g = -1;g<=1;g++){ //outer loop to traverse the array
          for(int l = -1;l<=1;l++){ //inner loop to traverse the array
            if(isValid(myRow+g,myCol+l)==true && buttons[myRow+g][myCol+l].clicked==false){ //statement to check if the tile around it is valid, as well as if the tile has been clicked
            buttons[myRow+g][myCol+l].mousePressed(); //if it hasn't been clicked, it checks to see if the tile is a mine, if it's not, it reveals it and how many mines are adjacent, otherwise is continues going
          }
        }
      }
    }
  }
    public void draw (){ //draw function, no return type
       if(flagged) //if the tile is flagged
          fill(0); //the tile turns black
        else if(clicked && mines.contains(this)) //else if the tile is clicked, and the tile contains a mine
           fill(255,0,0); //turn all the mines red
        else if(clicked) //else if the tile is clicked, and the tile is not a mine
           fill(200); //turn it white-greyish
        else //otherwise
            fill(100); //the tile remains a darker grey
        rect(x, y, width, height); //creates rectangles with the dimension x, y, and positions, width, height
        fill(0); //fills it black
        text(myLabel,x+width/2,y+height/2); //created the label that's in the middle of the rectangle
    }
    public void setLabel(String newLabel){ //setter to set the old label to the new label
        myLabel = newLabel; //sets the old label to the new label
    }
    public void setLabel(int newLabel){ //sets the label, using the integer value of newLabel
        myLabel = ""+ newLabel; //makes the label equal the integer value of new label
    }
    public boolean isFlagged(){ //boolean function to check if something is flagged
        return flagged; //if it is, return true
    }
    public int getR(){ //getter function for row
      return myRow; //returns the row
    }
    public int getC(){ //getter function for the column
      return myCol; //returns the column
    }
}
