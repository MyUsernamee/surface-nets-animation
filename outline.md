# Surface nets

## Greetings

### Hook

  Talk about how this is the algorithm that is rarley talked about but outperforms the current status quo.
  Talk about how it is faster and produces better results as well.
  Talk about how it stupidly parrelelizable

# Introduction

  Roll back and talk about what both marching cubes and surface nets aim to do.

# SDFS

  What is a SDF?
   Breiefly explain what is is and how it works.
   Why would we want to mesh it?
  What is the currently most talked about and used way to do this?

# Marching cubes (old method)

   Introduce marching cubes
   Explain it is the most talked about and used in games
   Explain its short comings.
    Walk through how it works quickly
    Explain the LUT
    Explain how we would normally make this better.
    Explain how to make it a nice mesh this requires deduplication and data from the previouse iteration.

# Introduction of Surface nets

  Introduce surface nets
   Explain how it doesn't require a lut, doesn't require data from prevouse iterations, and doesn't require deduplication
  Start with underlying concerpt that along a edge if it goes from negavtive to positive there is a surface
  Start with the quads phase where we place a "line" or quad for 3d on that edge if there is a surface between.
  Show the resulting mesh.
  Talk about how this is greate but it looks like minecraft.
  Now exaplin how instead of placing individual quads we jut put a vert ad each cell center and use indicies it index them
  Same result, lest quads.
  Now what if we choose the points better.
  We find the intersection point along each edge and average them
  Like magic we get a good looking mesh.
  We can also calculate normals for free by using the finite difference method.
  Surface nets!!!!
  Now we can talk about how because generating the verticies and generating the indicies doesn't requireus
  to know data about the other cells we can multi thread both and do both at the same time.

# Comparison

  Theroy is great and all but is this actually better?
  Side by side looks Comparison
  Wire frame
  Frame time Comparison

  Generation time Comparison

  Surface nets are even fast enough to generate in real time :)

# Conclusion

  Not only are surface nets better and faster than marching cubes but the underlying concept for it is simpler to understnad.
  
  So why is not everyone using.
   Not sure.
   Not talked about?
   Only like 2 video and maybe three articles on it?
   Marching cubes is easy to implement without having to understand it because of the LUT.
   Without interpolation Marching cubes is faster for generation?

# Final thoughts
  
  Thank you for watching and I hope to see you in the future.
  Maybe we can go into LODs in the next video???

