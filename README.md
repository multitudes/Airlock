# Airlock

This app is currently on TestFlight!  
https://testflight.apple.com/join/rfPbYjXH

## A two minutes meditation app.

The concept of the app is simple. 

We are inviting you to close your eyes and observe your breath for two minutes, the bare minimum of a unit of time. But did you ever realise how long are two minutes when you close your eyes?

<br>
<p align="center">
  <img src="screens/airlock0.png" width="230"  title="Airlock">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="screens/airlock1.png" width="230"  title="Airlock">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="screens/airlock.gif" width="230"  title="Airlock">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<br></br>


You press the button and start to meditate, giving awareness to your breath, just observing. You might think two minutes is not enough, and you would be right, but the purpose here is not enlightenment, but getting the chance to come down for a moment, and get a fresh mind. 
Often we rush through things in life. From a stressful commute, an intense meeting to another challenging situation.  

In all these cases, are we often not aware of how we carry our emotions from place to place, meeting to meeting.  
Two minutes of observing your breath are what you need to collect your thought, examine yourself and your sensation, re-base and be ready again.   
Sometimes important decisions and conversations benefit from a fresh and mindful start.

## Adding a log feature with Core Data

I want to add the possibility to track the meditations and keep them in history. Also I want the user to be able to enter a text based feedback or thought, once a day.  

The first thing to do is designing the data model. I will keep it simple. It is an array of Items. Every item is a meditation and has a date, an optional thought and the length of the meditation, which is optional too, in case the user decides to add a thought indipendently of the meditation. I am thinking of limiting the thoughts to one a day. So the only real mandatory value is the date, with either a thought or a meditation length in minutes.  

### In the Core Data dashboard
I press Cmd+N to create a new file, then select Data Model and name it `Main.xcdatamodeld`, add an entity Item and the attributes as above. 

- “myText”, with the type String.
- “timeMeditated”, with the type Integer 16.
- “creationDate”, with the type Date.





