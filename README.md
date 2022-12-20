# Written Digit Classifier

<p>In this project, we implement a network in RISC-V assembly language which is able to classify handwritten digits. As inputs, we use the <a href="http://yann.lecun.com/exdb/mnist/">MNIST</a> data set, which is a dataset of 60,000 28x28 images containing handwritten digits ranging from 0-9. We treat these images as “flattened” input vectors sized 784x1. In a similar way to the example before, we perform matrix multiplications with pre-trained weight matrices <code class="language-plaintext highlighter-rouge">m_0</code> and <code class="language-plaintext highlighter-rouge">m_1</code>. Instead of thresholding we use two different non-linearities: The <code class="language-plaintext highlighter-rouge">ReLU</code> and <code class="language-plaintext highlighter-rouge">ArgMax</code> functions.</p>

<p><img src="https://inst.eecs.berkeley.edu/~cs61c/sp20/projects/proj2/MNIST.png" width="600" /></p>

## Using the Classifier
<p>First, draw your own handwritten digits to pass to the neural net. First, open up any basic drawing program like Microsoft Paint. Next, resize the image to 28x28 pixels, draw your digit, and save it as a <code class="language-plaintext highlighter-rouge">.bmp</code> file in the directory <code class="language-plaintext highlighter-rouge">/inputs/mnist/student_inputs/</code>.</p>

<p>Inside that directory, use <code class="language-plaintext highlighter-rouge">bmp_to_bin.py</code> to turn this <code class="language-plaintext highlighter-rouge">.bmp</code> file into a <code class="language-plaintext highlighter-rouge">.bin</code> file for the neural net, as well as an <code class="language-plaintext highlighter-rouge">example.bmp</code> file. To convert it, run the following from inside the <code class="language-plaintext highlighter-rouge">/inputs/mnist/student_inputs</code> directory:</p>
<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>python bmp_to_bin.py example
</code></pre></div></div>
<p>This will read in the <code class="language-plaintext highlighter-rouge">example.bmp</code> file, and create an <code class="language-plaintext highlighter-rouge">example.bin</code> file. We can then input it into our neural net, alongside the provided <code class="language-plaintext highlighter-rouge">m0</code> and <code class="language-plaintext highlighter-rouge">m1</code> matrices.</p>
<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code>java -jar venus.jar main.s -ms 10000000 -it inputs/mnist/bin/m0.bin inputs/mnist/bin/m1.bin inputs/mnist/student_inputs/example.bin  output.bin
</code></pre></div></div>

<p>You can convert and run your own <code class="language-plaintext highlighter-rouge">.bmp</code> files in the same way. This should write a binary matrix file output.bin which contains your scores for each digit, and print out the digit with the highest score.</p>


