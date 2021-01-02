Experiment
==========

|Github| |Open In Colab|

labmlml will keep track of experiments if you declare an Experiment. It
will keep track of logs, code diffs, git commits, etc.

.. |Github| image:: https://img.shields.io/github/stars/lab-ml/labml?style=social
   :target: https://github.com/lab-ml/labml
.. |Open In Colab| image:: https://colab.research.google.com/assets/colab-badge.svg
   :target: https://colab.research.google.com/github/lab-ml/labml/blob/master/guides/experiment.ipynb

.. code-block:: python

    %%capture
    !pip install labml

.. code-block:: python

    from labml import experiment

The ``name`` defaults to the calling python filename. However when
invoking from a Jupyter Notebook it must be provided because the library
cannot find the calling file name. ``comment`` can be changed later from
`Dashboard <https://github.com/vpj/labmlml_dashboard>`__.

.. code-block:: python

    experiment.create(name="mnist_pytorch",
                      comment="Test")

Starting an experiments creates folders, stores the experiment
configurations, git commits, and source diffs.

.. code-block:: python

    experiment.start()



.. raw:: html

    <pre style="overflow-x: scroll;">
    <strong><span style="text-decoration: underline">mnist_pytorch</span></strong>: <span style="color: #208FFB">2ade3718392c11ebaaadacde48001122</span>
    	<strong><span style="color: #DDB62B">Test</span></strong>
    	[dirty]: <strong><span style="color: #DDB62B">"link nn"</span></strong></pre>




.. parsed-literal::

    <labml.internal.experiment.watcher.ExperimentWatcher at 0x7fea72e508d0>




.. raw:: html

    <pre style="overflow-x: scroll;"><span style="color: #C5C1B4"></span>
    <span style="color: #C5C1B4">--------------------------------------------------</span><span style="color: #DDB62B"><strong><span style="text-decoration: underline"></span></strong></span>
    <span style="color: #DDB62B"><strong><span style="text-decoration: underline">LABML WARNING</span></strong></span>
    <span style="color: #DDB62B"><strong><span style="text-decoration: underline"></span></strong></span>LabML App Warning: <span style="color: #60C6C8">empty_token: </span><strong>Please create a valid token at https://web.lab-ml.com.</strong>
    <strong>Click on the experiment link to monitor the experiment and add it to your experiments list.</strong><span style="color: #C5C1B4"></span>
    <span style="color: #C5C1B4">--------------------------------------------------</span></pre>



.. raw:: html

    <pre style="overflow-x: scroll;"><span style="color: #208FFB">Monitor experiment at </span><a href='https://web.lab-ml.com/run?run_uuid=2ade3718392c11ebaaadacde48001122' target='blank'>https://web.lab-ml.com/run?run_uuid=2ade3718392c11ebaaadacde48001122</a></pre>


You can also start from a previously saved checkpoint.

.. code:: python

   experiment.load(run_uuid='XXX')
