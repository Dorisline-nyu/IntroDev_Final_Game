/// @description Insert description here
// You can write your code in this editor

enum STATES
{

	DEAL,
	COMPUTER,
	CHOOSE,
	DRINK,
	RESOLVE,
	RESHUFFLE

}

global.state = STATES.DEAL;

hand_x_offset = 100;
num_substance_cards = 30;
//num_food_cards = 15;

//food_deck = ds_list_create();
substance_deck = ds_list_create();
//player
player_hand = ds_list_create();
player_selected = ds_list_create();
player_choice = 0;
//player_has_food_card = false;
//player_has_substance_card = false;
//player_selected_card = ds_list_create();
//computer
computer_hand = ds_list_create();
computer_selected = ds_list_create();
computer_choice = 0;
//computer_has_food_card = false;
//computer_has_substance_card = false;
//discard
//food_discard = ds_list_create();
substance_discard = ds_list_create();
//timer
move_timer = 0;
//scores
player_conscious = 10;
computer_conscious = 10;
max_consciousness = 10;

for (var _i = 0; _i < num_substance_cards; _i++)
{
	var _new_substance_card = instance_create_layer(x, y, "Cards", obj_substance_card);
	_new_substance_card.substance_face_index = _i % 3;
	_new_substance_card.face_up = false;
	_new_substance_card.in_player_hand = false;
	_new_substance_card.in_computer_hand = false;
	_new_substance_card.target_x = 400;
	_new_substance_card.target_y = y;
	ds_list_add(substance_deck, _new_substance_card);
	
}
randomize();
ds_list_shuffle(substance_deck)

for(var _i = 0; _i < num_substance_cards; _i++)
{
	substance_deck[| _i].depth = num_substance_cards - _i;
	substance_deck[| _i].target_y = y - (2 * _i);
}
/*
for (var _i = 0; _i < num_food_cards; _i++)
{
	var _new_food_card = instance_create_layer(x, y, "Cards", obj_food_card);
	_new_food_card.food_face_index = _i % 3;
	_new_food_card.face_up = false;
	_new_food_card.in_player_hand = false;
	_new_food_card.in_computer_hand = false;
	_new_food_card.target_x = 300;
	_new_food_card.target_y = y;
	ds_list_add(food_deck, _new_food_card);
	
}
randomize();
ds_list_shuffle(food_deck)

for(var _i = 0; _i < num_food_cards; _i++)
{
	food_deck[| _i].depth = num_food_cards - _i;
	food_deck[| _i].target_y = y - (2 * _i);
}
*/