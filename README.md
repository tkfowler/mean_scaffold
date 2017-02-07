<h1>Mean Scaffold</h1>
<h4>Get a MEAN stack CRUD app up and running quickly from the command line</h4>
<p>Highly customizable before and after your code is compiled. Currently compatible with the stock MEAN stack.</p>
<h2>Setup</h2>
<p>Find a directory where you want to start your app. We'll call this your 'super root', as Mean Scaffold will create a root directory within this directory for your app.<p>
<hr>
<h2>Install</h2>
<h3>npm install -g mean-scaffold</h3>
<h5>You can now run the command 'mean-scaffold' from the directory of your choice.</h5>
<hr>
<h2>Model Setup</h2>
<p>Your command line will prompt you for the following:</p>
<ol>
  <li>Project Name</li>
  <li>Model Name</li>
  <li>Attribute Name</li>
  <li>Attribute Type</li>
  <li>Another Attribute in this Model? If yes, repeat step 3</li>
  <li>Another Model? If yes, repeat step 2</li>
</ol>
<hr>
<h2>Associations</h2>
<p>Currently supports a one-to-many relationship. The parent class must be declared first with an attribute name of the related class (singular), and attribute type of ObjectsArray. The child class must be declared directly after the parent, with an attribute name of the related class (singular), and attribute type of ObjectId.</p>
<p>Example:</p>
<p>Model: User</p>
<p>Attribute Name: post</p>
<p>Attribute Type: ObjectsArray</p>
<p>Model: Post</p>
<p>Attribute Name: user</p>
<p>Attribute Type: ObjectId</p>
<h2>Done</h2>

Made By: Sheldon Bazzell, Thomas Fowler, Wallis Wong, Garrett Katashima

Copyright (c) 2004-2010 by Internet Systems Consortium, Inc. ("ISC") Copyright (c) 1995-2003 by Internet Software Consortium

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
