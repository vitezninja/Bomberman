# Felhasználói történetek 
|  1  | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Launch the game |
|  |  |  |
| 1 | GIVEN| The game has already been installed but isn't running |
| | WHEN| I launch the game |
| | THEN | The main menu appears |

|  2  | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Play offline |
|  |  |  |
| 1. | GIVEN| The play button has already been clicked |
| | WHEN| I click the offline button |
| | THEN | I am given the option to choose the number of players|
|  |  | |
| 1.1. | GIVEN| The offline button has already been clicked|
| | WHEN| I click the 2 players button |
| | THEN | I am given the option to select a map |
|  |  | |
| 1.1.1. | GIVEN| The 2 players button has already been clicked|
| | WHEN| I select the desired map by clicking on its preview image |
| | THEN | The game starts on the chosen map with two players playing on it|
|  |  | |
| 1.2 | GIVEN| The offline button has already been clicked|
| | WHEN| I click the 3 players button |
| | THEN | I am given the option to select a map|
|  |  | |
| 1.2.1 | GIVEN| The 3 players button has already been clicked|
| | WHEN| I select the desired map by clicking on its preview image |
| | THEN | The game starts on the chosen map with three players playing on it|

|  3  | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Play online |
|  |  |  |
| 1. | GIVEN| The play button has already been clicked |
| | WHEN| I click the online button |
| | THEN | I am given the option to host or join a game|
|  |  | |
| 1.1. | GIVEN| The online button has already been clicked|
| | WHEN| I click the host game button |
| | THEN | I am given the option to select a map to play on with other players joining online|
|  |  | |
| 1.1.1. | GIVEN| The host game button has already been clicked|
| | WHEN| I select the desired map |
| | THEN | I am given the option to start the game whenever I want to using the Start game button|
|  |  | |
| 1.1.1.1. | GIVEN| The desired map has already been selected|
| | WHEN| I click the Start game button |
| | THEN | An online game starts on the selected map with up to 3 players in it who have already connected via the lobby's host id|
|  |  | |
| 1.2. | GIVEN| The online button has already been clicked|
| | WHEN| I click the join game button |
| | THEN | I am given the option to input the host id to connect to a lobby|
|  |  | |
| 1.2.1 | GIVEN| The join game button has already been clicked|
| | WHEN| I input the appropriate host id into the input field and press enter | 
| | THEN | I am connected to the desired game lobby and am waiting for the host to start the game|

|  4  | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Change key bindings |
|  |  |  |
| 1 | GIVEN| I am in the main menu |
| | WHEN| I click the change bindings button |
| | THEN | I am given the option to select the action to be changed|
|  |  |  |
| 1.1 | GIVEN| I have already clicked the change bindings button |
| | WHEN| I select the action to be changed |
| | THEN | I am given the option to press the key for the new binding|
|  |  |  |
| 1.1.1 | GIVEN| I have selected the action to be changed |
| | WHEN| I press the key for the new binding |
| | THEN | The game binds the chosen key to the selected action |

|  5 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Find out the origin of certain assets|
|  |  |  |
| 1 | GIVEN| I am in the main menu |
| | WHEN| I click the credits button |
| | THEN | The credits page appears|

|  6 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Find the artists that inspired the developers |
|  |  |  |
| 1 | GIVEN| I am in the main menu |
| | WHEN| I click the credits button |
| | THEN | The credits page appears|

|  7 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Learn about and understand the game rules and gameplay |
|  |  |  |
| 1 | GIVEN| I am in the main menu |
| | WHEN| I click the info button |
| | THEN | The info page appears|

|  8 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Quit the game from the main menu |
|  |  |  |
| 1 | GIVEN| I am in the main menu |
| | WHEN| I click the quit game button |
| | THEN | The game closes down |

|  9 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Quit the game from a game session |
|  |  |  |
| 1 | GIVEN | I am currently in a game session |
| | WHEN | I press the key with the exit game binding |
| | THEN | The game exits to the main menu|
|  |  |  |
| 1.1 | GIVEN | I am currently in the main menu |
| | WHEN | I click the quit game button |
| | THEN | The game closes down|

|  10 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Move my character in a certain direction in the game session |
|  |  |  |
| 1 | GIVEN | I am currently in a game session |
| | WHEN | I press the key with the desired direction binded to it |
| | THEN | My character moves to that direction |

|  11 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Place a bomb |
|  |  |  |
| 1 | GIVEN | I am currently in a game session |
| | WHEN | I press the key that's binded to the bomb-placing action |
| | THEN | My character places a bomb directly where it stands |

|  12 | User | Story |
| --- | --- | --- |
|     | AS A | Player |
|     | I WANT TO | Use a powerup |
|  |  |  |
| 1 | GIVEN | I am currently in a game session |
| | WHEN | I move my character over the power-up's icon |
| | THEN | My character now has that power-up and can use it using the binded key |
| 1.1 | GIVEN | I currently have a power-up that I picked up |
| | WHEN | I press the key that's binded to the powerup-using action |
| | THEN | My character uses the powerup |
