/// @description Insert description here
// You can write your code in this editor

switch(global.state)
{
	case STATES.DEAL:
			//player_has_substance_card = false;
			//player_has_food_card = false;
			var _player_num = ds_list_size(player_hand)
			if(_player_num < 3)
			{
				if(position_meeting(mouse_x, mouse_y, obj_substance_card))
				{
					if(mouse_check_button_pressed(mb_left))
					{
						audio_play_sound(sou_deal, 1, false)
						var _dealt_card = ds_list_find_value(substance_deck, ds_list_size(substance_deck) - 1);
						ds_list_delete(substance_deck, ds_list_size(substance_deck) - 1);
						ds_list_add(player_hand, _dealt_card);
						_dealt_card.target_x = room_width/3 + _player_num * hand_x_offset;
						_dealt_card.target_y = room_height * 0.8;
						_dealt_card.in_player_hand = true;
						//player_has_substance_card = true;
						player_choice++;
					}
				}
			}
			/*
			if(position_meeting(mouse_x, mouse_y, obj_food_card))
			{
				if(mouse_check_button_pressed(mb_left))
				{
				var _dealt_card = ds_list_find_value(food_deck, ds_list_size(food_deck) - 1);
				ds_list_delete(food_deck, ds_list_size(food_deck) - 1);
				ds_list_add(player_hand, _dealt_card);
				//show_message(_dealt_card.face_index);
				_dealt_card.target_x = room_width/3 + _player_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.8;
				_dealt_card.in_player_hand = true;
				player_has_food_card = true;
				player_choice++;
				}
			}	
			*/
			if(player_choice == 3)
			{
				global.state = STATES.COMPUTER;
			}
	break;
	
	case STATES.COMPUTER:
		if(move_timer == 0)
		{
		var _computer_num = ds_list_size(computer_hand);
		if(_computer_num < 3)
			{
				audio_play_sound(sou_deal, 1, false)
				var _dealt_card = ds_list_find_value(substance_deck, ds_list_size(substance_deck) - 1);
				ds_list_delete(substance_deck, ds_list_size(substance_deck) - 1);
				ds_list_add(computer_hand, _dealt_card);
				_dealt_card.target_x = room_width/3 + _computer_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.05;
				_dealt_card.in_computer_hand = true;
				_dealt_card.face_up = false;
			}
			else
			{
				//make the computer choose first
				//make the comupter selected card move up
				_computer_selected_card = ds_list_find_value(computer_hand, choose(0, 1, 2));
				_computer_selected_card.target_x = 365;
				_computer_selected_card.target_y = 180;
				ds_list_add(computer_selected, _computer_selected_card);
				ds_list_delete(computer_hand, _computer_selected_card);
				//dealing is false
				global.state = STATES.CHOOSE;
			}
		
		/*\
		//computer_has_food_card = false;
		computer_has_substance_card = false;
		var _computer_num = ds_list_size(computer_hand);
		if(irandom(1) == 0)
			{
				var _dealt_card = ds_list_find_value(substance_deck, ds_list_size(substance_deck) - 1);
				ds_list_delete(substance_deck, ds_list_size(substance_deck) - 1);
				ds_list_add(computer_hand, _dealt_card);
				//show_message(_dealt_card.face_index);
				_dealt_card.target_x = room_width/3 + _computer_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.05;
				computer_has_substance_card = true;
				computer_choice++;
			}
			
			else
			{
				var _dealt_card = ds_list_find_value(food_deck, ds_list_size(food_deck) - 1);
				ds_list_delete(food_deck, ds_list_size(food_deck) - 1);
				ds_list_add(computer_hand, _dealt_card);
				//show_message(_dealt_card.face_index);
				_dealt_card.target_x = room_width/3 + _computer_num * hand_x_offset;
				_dealt_card.target_y = room_height * 0.05;
				computer_has_food_card = true;
				computer_choice++;
			}
			
			 if(computer_choice == 3)
			{
				_computer_selected_card = ds_list_find_value(computer_hand, choose(0, 1, 2));
				_computer_selected_card.target_x = 365;
				_computer_selected_card.target_y = 175;
				ds_list_add(computer_selected, _computer_selected_card);
				ds_list_delete(computer_hand, _computer_selected_card);
				global.state = STATES.CHOOSE;
			}
			*/
		}
	break;
	
	case STATES.CHOOSE:

		if(ds_list_size(player_selected) == 1)
		{
			_computer_selected_card.face_up = true;
			//show_message("hi")
			wait_timer++;
			if(wait_timer >= 50)
			{
				//show_message(_computer_selected_card.face_index)
				global.state = STATES.DRINK;
				wait_timer = 0;
			}
		}
	break;
	
	case STATES.DRINK:
		//show_message(player_selected.food_face_index)
		//var _player_selected_substance = ds_list_find_value(player_selected, 0)
		//var _player_selected_food = ds_list_value(player_selected
		if(ds_list_find_value(player_selected, 0) == 0)
		{
			audio_play_sound(sou_drink, 1, false)
			//player health -1
			player_conscious -= 1;
			if(player_conscious < 1)
			{
				room_goto(roo_lose);
			}
			
		}
		if(ds_list_find_value(player_selected, 0) == 1)
		{
			audio_play_sound(sou_drink, 1, false)
			//player health -2
			player_conscious -= 2;
			if(player_conscious < 1)
			{
				room_goto(roo_lose);
			}
		}
		if(ds_list_find_value(player_selected, 0) == 2)
		{
			audio_play_sound(sou_banana, 1, false)
			player_conscious += 1;
			if(player_conscious > max_consciousness)
			{
				player_conscious = max_consciousness;
			}
		}
		if(_computer_selected_card.substance_face_index == 0)
		{
			audio_play_sound(sou_drink, 1, false)
			computer_conscious -= 1;
			if(computer_conscious < 1)
			{
				room_goto(roo_win);
			}
		}
		if(_computer_selected_card.substance_face_index == 1)
		{
			audio_play_sound(sou_drink, 1, false)
			computer_conscious -= 2;
			if(computer_conscious < 1)
			{
				room_goto(roo_win);
			}
		}
		if(_computer_selected_card.substance_face_index == 2)
		{
			audio_play_sound(sou_banana, 1, false)
			computer_conscious += 1;
			if(computer_conscious > max_consciousness)
			{
				computer_conscious = max_consciousness;
			}
		}
		
		global.state = STATES.RESOLVE
		/*
		//if(ds_list_find_value(player_selected, 0) == 2)
		//{
			//player health -1 and computer health - 1
			//player_conscious -= 1;
		//}
		if(food_face_index == 0)
		{
			//player health +2
			player_conscious = +2;
		}
		if(food_face_index == 1)
		{
			//player health +1
			player_conscious++;
		}
		if(food_face_index == 2)
		{
			//player health -1
			player_conscious--;
		}
		
		 else
		 {
			 global.state = STATES.RESOLVE
		 }
		 */
	
	break;
	
	case STATES.RESOLVE:
		if(move_timer == 0)
		{
			
			var _hand_num = ds_list_size(player_hand);
			var _computer_hand_num = ds_list_size(computer_hand);
				if(_hand_num > 0)
				{
				
					var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
					ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
					ds_list_add(substance_discard, _hand_card);
					//ds_list_add(substance_discard, player_selected); I'M SO DUMB
					_hand_card.in_deck = false;
					_hand_card.in_player_hand = false;
					_hand_card.face_up = false;
					player_choice = 0;
				
					if(_computer_hand_num > 0)
					{

						var _computer_hand_card = ds_list_find_value(computer_hand, ds_list_size(computer_hand) - 1);
						ds_list_delete(computer_hand, ds_list_size(computer_hand) - 1);
						ds_list_add(substance_discard, _computer_hand_card);
						_computer_hand_card.in_deck = false;
						_computer_hand_card.in_computer_hand = false;
						_computer_hand_card.face_up = false;
				
					}

				}
				else
				{
				for(var _i = 0; _i < ds_list_size(substance_discard); _i++)
					{
						substance_discard[| _i].depth = ds_list_size(substance_discard) - _i;
						substance_discard[| _i].target_x = room_width * 0.65;
						substance_discard[| _i].target_y = y - (2 * _i);
					}
			
					ds_list_clear(player_selected);
					ds_list_clear(computer_selected);
					if(ds_list_size(substance_deck) == 0)
					{
						global.state = STATES.RESHUFFLE;
					}
					else
					{
					
						global.state = STATES.DEAL;
					}
			}
	/*
		var _hand_num = ds_list_size(player_hand);
		var _computer_hand_num = ds_list_size(computer_hand);
			if(_hand_num > 0)
			{
				if(player_has_substance_card = true)
				{
					var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
					ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
					ds_list_add(substance_discard, _hand_card);
					ds_list_add(substance_discard, player_selected);
					_hand_card.target_x = room_width * 0.8;
					_hand_card.target_y = y - ds_list_size(substance_discard);
					_hand_card.in_player_hand = false;

				
					for(var _i = 0; _i < ds_list_size(substance_discard); _i++)
					{
					substance_discard[| _i].depth = num_substance_cards - _i;
					substance_discard[| _i].target_y = y - (2 * _i);
					}
				}
				if(player_has_food_card = true)
				{
					var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
					ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
					ds_list_add(food_discard, _hand_card);
					ds_list_add(food_discard, player_selected);
					_hand_card.target_x = room_width * 0.1;
					_hand_card.target_y = y - ds_list_size(food_discard);
					_hand_card.in_player_hand = false;

				
					for(var _i = 0; _i < ds_list_size(food_discard); _i++)
					{
					food_discard[| _i].depth = num_food_cards - _i;
					food_discard[| _i].target_y = y - (2 * _i);
					}
				}
			}
			if(_computer_hand_num > 0)
			{
				if(computer_has_substance_card = true)
				{
					var _computer_hand_card = ds_list_find_value(computer_hand, ds_list_size(computer_hand) - 1);
					ds_list_delete(computer_hand, ds_list_size(computer_hand) - 1);
					ds_list_add(substance_discard, _computer_hand_card);
					_computer_hand_card.target_x = room_width * 0.8;
					_computer_hand_card.target_y = y - ds_list_size(substance_discard);
					_computer_hand_card.in_computer_hand = false;
				
					for(var _i = 0; _i < ds_list_size(substance_discard); _i++)
					{
						substance_discard[| _i].depth = num_substance_cards - _i;
						substance_discard[| _i].target_y = y - (2 * _i);
					}
				}
				if(computer_has_food_card = true)
				{
					var _computer_hand_card = ds_list_find_value(computer_hand, ds_list_size(computer_hand) - 1);
					ds_list_delete(computer_hand, ds_list_size(computer_hand) - 1);
					ds_list_add(food_discard, _computer_hand_card);
					_computer_hand_card.target_x = room_width * 0.1;
					_computer_hand_card.target_y = y - ds_list_size(food_discard);
					_computer_hand_card.in_computer_hand = false;
				
					for(var _i = 0; _i < ds_list_size(food_discard); _i++)
					{
						food_discard[| _i].depth = num_food_cards - _i;
						food_discard[| _i].target_y = y - (2 * _i);
					}
				}
				
			}

			//else
			{
				ds_list_clear(player_selected);
				ds_list_clear(computer_selected);
				/*
				if(ds_list_size(substance_deck) == 0)
				{
					global.state = STATES.RESHUFFLE;
				}
				else
				{
					
					global.state = STATES.DEAL;
				}
				*/
			//}
		/*
		var _card_chosen = ds_list_size(player_selected)
		if(_card_chosen > 0)
		{
			ds_list_add(substance_discard, _card_chosen);
			//show_message(_card_chosen)
			_card_chosen.target_x = 600;
			_card_chosen.target_y = 350;
			ds_list_clear(player_selected);
			show_message(player_selected)
		}
		*/
		//else
		//{
			/*
			if(ds_list_size(substance_deck) == 0)
			{
				global.state = STATES.RESHUFFLE
			}
			else
			{
				//global.state = STATES.DEAL
			}
			*/
		//}
		}
	break;
	
	case STATES.RESHUFFLE:
		//if(move_timer == 0)
		//{
		var _reshuffle_num = ds_list_size(substance_discard)
		if(_reshuffle_num > 0)
		{
			var _reshuffle_card = ds_list_find_value(substance_discard, ds_list_size(substance_discard) - 1)
			ds_list_delete(substance_discard, ds_list_size(substance_discard) - 1);
			ds_list_add(substance_deck, _reshuffle_card);
			//_reshuffle_card.target_x = 400;
			//_reshuffle_card.target_y = y;
		}
		else
		{
			global.state = STATES.DEAL;
		}
		
		randomize();
		ds_list_shuffle(substance_deck)
		
		for(var _i = 0; _i < ds_list_size(substance_deck); _i++)
		{
			substance_deck[| _i].depth = ds_list_size(substance_deck) - _i;
			substance_deck[| _i].target_x = 200;
			substance_deck[| _i].target_y = y - (2 * _i);
		}
		
		//}
	break;
	
}

move_timer++;
if(move_timer == 16)
{
	move_timer = 0;
}