
Experiment
==========

labmlml will keep track of experiments if you declare an Experiment. It
will keep track of logs, code diffs, git commits, etc.

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

    <pre>
    <strong><span style="text-decoration: underline">mnist_pytorch</span></strong>: <span style="color: #208FFB">2a81805c946011eabd18acde48001122</span>
    	<strong><span style="color: #DDB62B">Test</span></strong>
    	[dirty]: <strong><span style="color: #DDB62B">"citation"</span></strong></pre>


You can also start from a previously saved checkpoint.

.. code:: python

   experiment.load(run_uuid='XXX')
