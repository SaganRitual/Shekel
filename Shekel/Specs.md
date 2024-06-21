# SKPlayground

SKPlayground is a macOS desktop app written in Swift. Its purpose is to enable developers to
easily experiment with various SpriteKit features such as actions and physics. This document
describes the application in detail.

## Application Window

There is only one application window, comprising two main sections, the Playground and the
Dashboard.

### Playground

The Playground is where the action occurs. It will appear initially as a black rectangle on the
left side of the application window. The Playground will have a minimum width of 1024 pixels and
will fill the window's available space not used by the Dashboard. The user will mouse-click on
the Playground to create game entities that can then be dragged around, scaled, and rotated, as
well as receiving actions and physics attributes that the user will assign using the features in
the Dashboard.

Internally, the Playground will be an SKScene inside an SKView.

### Dashboard

The Dashboard occupies the right side of the application window, and will have a fixed width of
400 pixels. It will comprise three main sections: the State, the Commands, and the Tools.

Internally, the Dashboard will be the top-level view of a SwiftUI View hierarchy. The sections
described below are represented by SwiftUI Views.

#### State

The State section of the Dashboard displays various state of the Playground, including the
mouse position as the user moves it about the Playground, and the dimensions of the Playground,
updated whenever the user resizes the application window.

#### Commands

The Commands section of the Dashboard contains buttons to allow the user to execute various
operations on the Playground, for example running all actions, or pausing/unpausing the physics
engine. The Commands section contains a set of radio buttons to allow the user to indicate the
type of game entity to create on click. If "Gremlin" is selected among the radio buttons, a
dropdown menu will appear in the section, with a list of available images to be used
to represent the new entity when the user clicks in the Playground. If "Waypoint" is selected,
the dropdown is not displayed. If "Physics" is selected, a dropdown will appear to indicate
various types of physics entities that the user can create on click, such as joints and fields.

#### Tools

The Tools section will display a message like "Nothing Selected" if no item in the Playground
is selected. If multiple items are selected, the Tools section will display the physics attributes
of the selected items in fields that allow the user to change the values. Visual indicators will
be shown if the values are not the same for all selected entities, and if the user changes the
values in these fields the values will be overridden and set to the same for all selected entities;
this is typical application behavior. If only one item is selected, the same set of physics
attributes is displayed, and below it a section for creating actions to assign to the selected
entity, with two tabs entitled Space and Physics, and below
that section a scrollable view of all actions currently assigned to the selected entity.

##### Space Tab

The Space tab is for assigning space-oriented actions to entities, such as movement, scaling, and rotation.
The tab at first displays a button "Click Here To Start". When the button is clicked, it will
disappear and be replaced by a slider that allows the user to set the duration of the action, and
below that two new buttons, "Click Here When Finished" and "Cancel". The Cancel button will cancel the operation,
restoring the original state of the Playground and the tab itself, displaying the original
"Click Here" button.

When the user clicks "Click Here To Start", the selection handle on the selected entity in the
Playground changes to reflect that the entity may now be moved, scaled, and rotated by dragging
different parts of the handle. When the user clicks "Click Here When Finished", the changes that the
user made to the entity are saved as actions, with the duration specified by the slider value,
and assigned to the entity such that they will be run
later on user demand. The new actions are added to the entity's action queue and representations
for them are added to the scroll view; the sprite and its selection handle are returned to their
original states, and the original "Click Here" button is restored. The user can rearrange the actions
by dragging their representations around in the scroll view.

##### Physics Tab

The Physics tab displays a set of radio buttons allowing the user to select the type of physics
action to assign to the entity. The options are Force, Impulse, Torque, and Angular Impulse.
When Force is selected, a trackpad appears below the radio buttons, below the trackpad a duration slider,
and below the slider a button
entitled "Create Physics Action". The trackpad is a rectangle with a draggable dot in the center, and
x- and y-axes indicated with the origin at the center. The y-axis is positive upward. The user drags
the dot to create a force vector corresponding to the coordinates of the dot. When satisfied with
the vector, the user clicks "Create Physics Action". An action for the force is created and attached
to the entity, using the duration set in the slider. A representation of the action is added to the scroller.
When the Impulse button is selected, the same elements are displayed as for Force, and the user can
create an Impulse action in the same manner as the Force action.

When Torque is selected, the operation is similar to the Force selection, except that instead of a
trackpad, a simple slider is displayed, allowing the user to set the scalar torque value. Angular Impulse
works similarly to Torque, allowing the user to create an Angular Impulse action.

## Selection Marquee

Draws a rectangle on the scene when the user drags the mouse across the scene background.
When the user ends the drag operation by releasing the mouse, a selection operation is
performed on the game entities within the rectangle.

The selection marquee needs access to the following components:

- The scene, in order to draw the visible selection marquee
- The selection controller, in order to trigger the selection operation

## Selection Controller

Manages the selected/non-selected state of the game entities. 

The selection controller needs access to the following components:

- The game, in order to access the individual game entities to select/deselect them

## Game

Manages the set of game entities, creating and deleting them per user inputs

The game needs acces to the following components:

- The scene, in order to trigger creation of entity view sprites

## Scene

Creates and deletes the sprites that represent game entities. Receives and dispatches
mouse input

# Operations

1. Create game entity on mouse click
    1. Create entity view for the entity
    1. Select new entity
    1. Update entity view to show a visible selection indicator
    
1. Select/deselect entity on mouse click or on selection with marquee
1. Move sprite and update entity internally in response to user dragging the sprite with the mouse
1. Scale and/or rotate sprite and update entity internally in response to user dragging special handles on selection indicator

# Entities And Components

1. Entity View
    Some game entities have a visual representation in the GameScene. In some cases this representation
    will be an SKSpriteNode, and in others an SKShapeNode
1. Selectability
    Some game entities are selectable. The selection state is a boolean value in the entity, and will be
    represented visually by an SKShapeNode in the form of a ring that appears around the entity's view
1. Draggability
    Some selectable game entities are draggable: a draggable entity's selection node will receive mouse
    up/down/drag inputs and will move itself and its underlying entity
1. Roscalability
    "Roscale" means rotate and/or scale. Some selectable game entities are roscalable. A roscalable entity's
    selection node will have an additional four SKShapeNodes attached as children at the cardinal points
    along the perimeter of the selection ring. Dragging any one of these sub-handles will rotate and/or
    scale the underlying entity with the mouse movement
1. Physics
    Some entities may have an associated SKPhysicsBody
1. Gremlin
    The primary game entity, represented visually by a cartoonish cyclops sprite in the GameScene. All Gremlins are selectable,
    draggable, and roscalable. All Gremlins also have an associated SKPhysicsBody
1. Waypoint
    Another game entity, represented visually by a flagpole sprite in the GameScene. Waypoints are selectable and draggable
