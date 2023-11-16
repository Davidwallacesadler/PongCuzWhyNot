# PongCuzWhyNot
https://github.com/Davidwallacesadler/PongCuzWhyNot/assets/22184380/48851bc8-afbf-4df9-84d5-bda6f7e91069

In an attempt to learn a bit more about game dev and working with Godot I'm following the [20 games challenge](https://20_games_challenge.gitlab.io/games/) and this is game 1! 

I implemented a super basic ai, menu, and sounds to make the game a little more complete. I ended up using the physics system for the ball which was great but made the game a little too predictable so I added a random impulse when the ball hits a paddle.

## Interesting Takeaways

- In order for the ball (a `RigidBody2D`) to collide with the paddles (both `CharacterBody2D`s) and only have the ball be effected by the collision has to do with the collision layer/mask. Just need to remember the layer == where the object lives, mask == what the object detects.
- I still am struggling with the basic structure of an app/game. Not sure if everything is a subnode of main or when to use signals or not.
- I need to look into how to best change/navigate the scene tree.
