Picam [source/doc](https://github.com/electricshaman/picam)
---



Picam is an Elixir library that provides a simple API for streaming MJPEG
video and capturing JPEG stills using the camera module on Raspberry PI
devices running Linux.

Features currently supported by the API:
* Set sharpness, contrast, brightness, saturation, ISO, and shutter speed values
* Set the exposuer, sensor, metering, and white balance modes
* Set image and color effects
* Rotate and flip the image vertically and horizontally
* Set the exposure compensation(EV) level
* Change the image size
* Aduset JPEG fidelity through quality level, restart intervals, and region
  of interest
* Enable or disable video stabilization
* Adjust the video framerate
* Display text annotations on the image frame(s)

Installation
----
The package can be installed by adding `picam` to your list of dependencies
in `mix.exs`:
```
def deps do 
   [{:picam, "~> 0.2.0"}]
end
```

Usage
----
`Picam` uses a port application named `raspijpgs` that interfaces with
the underlying Multi-Media Abstraction Layer(MMAL) API in VideoCore.
The port is started by the `Picam.Camera` process.

For example, to write a JPEG still using the `:sketch` image effect to 
`/tmp/frame.jpg`:

```
iex> Picam.Camera.start_link

iex> Picam.set_img_effect(:sketch)

iex> Picam.set_size(640,0)  # 0 atuomatically calculates height

iex> File.write!(Path.join(System.tmp_dir!, "frame.jpg"), Picam.next_frame)

iex> Picam.set_img_effect(:none)  # Disable the effect
```

If you receive an `:unexpected_exit` error immediately after starting the 
`Picam.Camera` process and you're using a V2 camera module, please check
that you've set `gpu_mem` to a value >= 192 in `/boot/config.txt`. You 
can verify this has taken effect in your termianl using `vcgencmd get_mem gpu`.

More than likely you'll want to put the `Picam.Camera` process in your
supervision tree than starting it manually:
```
# lib/my_app/application.ex
children = [
  worker(Picam.Camera, []),
]
```

