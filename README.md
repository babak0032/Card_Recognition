# Card_Recognition
A system that recognises the number and suit of a card given the image of the card. There are two datasets availabe in this repository, one for traning and one for testing. As the trainig process to classify the suits takes quite a whlile, the files save_models and load_models were added so after training the models once, you can just load them next time. 

Input: The image of the card, with the card on the center, on a light background. Example:

![alt tag](https://github.com/babak0032/Card_Recognition/blob/master/cards/train12.jpg)

Output: Display the number and the suit of the card: "This is 4 of Diamonds"

To see the system's performence, run the test_cards.m file.

Note: This sytem would not work for faced cards such as Jack. 
