/// @desc Core Player Logic

//Get player inputs
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_space);

//Calculate movement
var _move = key_right - key_left;

hsp = _move * walksp;

vsp = vsp + grv;

if (place_meeting(x,y+1,o_Wall)) && (key_jump)
{
	vsp = -jumpsp
}

//Horizontal collision
if (place_meeting(x+hsp,y,o_Wall))
{
	while (!place_meeting(x+sign(hsp),y,o_Wall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp;

//Vertical collision
if (place_meeting(x,y+vsp,o_Wall))
{
	while (!place_meeting(x,y+sign(vsp),o_Wall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp;

//Animation
if (!place_meeting(x,y+1,o_Wall))
{
	sprite_index = s_PlayerA;
	image_speed = 0;
	if(vsp > 0) image_index = 1; else image_index = 0;
}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = s_Player;
	}
	else
	{
		sprite_index = s_PlayerR;
	}
}

if (hsp !=0) image_xscale = sign(hsp);

// Dying, will set player back to beginning of level
if (y >= room_height + 128)
{ 
	y = 320;
	x = 5;
}

// Jump Boost meeting and collision event, will make gravity less
if (place_meeting(x,y+vsp,o_JumpBoost))
{
	grv = 0.25;
	instance_destroy(o_JumpBoost);
}

// Anti Jump Boost, will reset gravity back to its original setting
if (place_meeting(x,y+vsp,o_AntiJump))
{
	grv = 0.3;
	instance_destroy(o_AntiJump);
}