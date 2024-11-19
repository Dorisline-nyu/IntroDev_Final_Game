/// @description Insert description here
// You can write your code in this editor
/*
switch(global.state)
{

	case STATES.COMPUTER: 
		if(in_player_hand = true)
		{
			face_up = true;
		}
		
	case STATES.CHOOSE:
		if(in_player_hand = true)
		{
			face_up = true;
			if(position_meeting(mouse_x, mouse_y, id))
			{
				// show_debug_message(face_index);
				//move card/hover?
				target_y = room_height * 0.75
				
				if(mouse_check_button_pressed(mb_left))
				{
					//selected card moves forward

					//flip the card
					//face_up = true;
					ds_list_add(obj_dealer.player_selected, food_face_index);

					//show_message(food_face_index);
					
				}
				
			}
			else 
			{
				//move card back
				target_y = room_height * 0.8;

			}
		}
	case STATES.RESOLVE:
		
		if(in_computer_hand = true)
		{
			face_up = true;
		}

		break;
}

