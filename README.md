[![Travis](https://travis-ci.org/pmoelgaard/screenshot_capture.svg)](Travis)

# screenshot_capture
Ruby Library for [the screenshotlayer API](https://screenshotlayer.com/).   
Capture highly customizable snapshots of any website. Powerful Screenshot API for any application

---

## Installation

Add this line to your application's Gemfile:

```
gem 'screenshot_capture'

```

And then execute:

```
$ bundle

```

Or install it yourself as:

```
$ gem install screenshot_capture

```

---

## Configuration

Before using the screenshotlayer API client you have to setup your account and obtain your API Access Key.  
You can get it by signing up at [https://screenshotlayer.com/product](https://screenshotlayer.com/product).

---

## API Overview
All endpoints in the public API is available through this library.

- capture

---

## Usage

The general API is documented here: [https://pdflayer.com/documentation](https://screenshotlayer.com/documentation).  
You can find parameters, result set definitions and status codes documented here as well.

In the examples directory you can find demos and samples of general usage of all the API functions.

### Setup

```
@client = ScreenshotLayer::Client.new( [access_key], [secret_keyword] )

```

#### Required Parameters

###### access_key
Your unique key that you can find on the dashboard of your account under the screenshotlayer account.

###### secret_key
A userdefined private key that you can find on the dashboard of your account under the screenshotlayer account, it's used to encrypt parameters to prevent unauthorised usage of your account.

#### Optional Parameters

###### Secure (only available for Basic, Pro and Enterprise accounts)
Boolean value to indicate if the calls to the API should use a secure protocol or insecure (HTTP/HTTPS). Defaults to false (HTTP, insecure).

---

## Convert (simple case)

Takes a URL and returns the captured image.

###### Define Query
Second we define an options object.
All the options are documented here: [https://screenshotlayer.com/documentation](https://screenshotlayer.com/documentation)

```
options = ScreenshotLayer::CaptureOptions.new()

```

###### Call Client
We then place the actual call to the API, passing in the URL we wish to capture as PDF and the options we defined above.

```
response = @client.capture(url, options)

``` 

###### Response

```
[The binary content of the image file] (Defaults to PNG)

```

---

## Capture (w. filename)

Takes a URL, saves the image to a local file defined by the export argument and returns a response object.

###### Define Query

We define an options object, and sets the ```filename``` option.
This option is specific to the RubyGem and not documented in the API found on screenshotlayer.
If the directory doesn't exist, it will be created.

```
options = ScreenshotLayer::CaptureOptions.new()
options.filename = '[local_file_system]/some_directory]/my_file.png'

```

###### Simple Request (using Callback)

```
response = @client.capture(url, options)

```

###### Response
```
{
	"success": true,
    "info": "The image has been saved to your local file system",
    "file_name": "path_to_local_file.png"
}
```

---

## Example Application

In the [rootdir]/example directory there is a fully functional application which runs all requests against all the endpoints in the API, the examples above can be seen there as source code.

The example application uses a process.env variable to hold the access key.

---

## Tests

The tests are written using the rspec testing library.  
**RSpec** [http://rspec.info/](http://rspec.info/)

In order to run the tests, the following environment variables needs to be set:

```
ACCESS_KEY = [access_key]
SECRET_KEYWORD = [secret_keyword]
EXPORT_FTP = [path_to_ftp_account]
```


---

## Customer Support

Need any assistance? [Get in touch with Customer Support](mailto:support@apilayer.net?subject=%screenshotlayer%5D).

---

## Updates
Stay up to date by following [@apilayernet](https://twitter.com/apilayernet) on Twitter.

---

## Legal

All usage of the languagelayer website, API, and services is subject to the [pdflayer Terms & Conditions](https://pdflayer.com/terms) and all annexed legal documents and agreements.

---

## Author
Peter Andreas Moelgaard ([GitHub](https://github.com/pmoelgaard), [Twitter](https://twitter.com/petermoelgaard))

---

## License
Licensed under the The MIT License (MIT)

Copyright (&copy;) 2016 Peter Andreas Moelgaard & apilayer

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

