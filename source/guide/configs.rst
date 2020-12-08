Configs
=======

.. currentmodule:: labml.configs

The configurations provide an API to easily manage hyper-parameters and
other configurable parameters of the experiments. The configuration of
each experiment run are stored. These can be viewed on
`Dashboard <https://github.com/vpj/labmlml_dashboard>`__.

.. code-block:: python

    import torch
    from torch import nn
    
    from labml import tracker, monit, experiment, logger
    from labml.configs import BaseConfigs, option, calculate, hyperparams, aggregate

Define a configuration class
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

    class DeviceConfigs(BaseConfigs):
        use_cuda: bool = True
        cuda_device: int = 0
    
        device: any

Calculated configurations
^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: python

    @option(DeviceConfigs.device)
    def cuda(c: DeviceConfigs):
        is_cuda = c.use_cuda and torch.cuda.is_available()
        if not is_cuda:
            return torch.device("cpu")
        else:
            if c.cuda_device < torch.cuda.device_count():
                return torch.device(f"cuda:{c.cuda_device}")
            else:
                logger.log(f"Cuda device index {c.cuda_device} higher than "
                           f"device count {torch.cuda.device_count()}", Text.warning)
                return torch.device(f"cuda:{torch.cuda.device_count() - 1}")

Inheriting and re-using configuration classes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configs classes can be inherited. This lets you separate configs into
modules instead of passing `monolithic config
object <https://www.reddit.com/r/MachineLearning/comments/g1vku4/d_antipatterns_in_open_sourced_ml_research_code/>`__.

You can even inherit a entire experiment setups and make a few
modifications.

.. code-block:: python

    class Configs(DeviceConfigs):
        model_size: int = 1024
        input_size: int = 10
        output_size: int = 10
            
        model: any = 'two_hidden_layer'
        epochs = 10
        steps_per_epcoch = 1024
        total_steps: int
        variant: str

Defining configurations options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can specify multiple config calculator functions. You pick which one
to use by its name.

.. code-block:: python

    class OneHiddenLayerModule(nn.Module):
        def __init__(self, input_size: int, model_size: int, output_size: int):
            super().__init__()
            self.input_fc = nn.Linear(input_size, model_size)
            self.output_fc = nn.Linear(model_size, output_size)
        
        def forward(x: torch.Tensor):
            x = F.relu(self.input_fc(x))
            return self.output_fc(x)
        
    # This is just for illustration purposes, ideally you should have a configuration
    # for number of hidden layers.
    # A real world example would be different architectures, like a dense network vs a CNN
    class TwoHiddenLayerModule(nn.Module):
        def __init__(self, input_size: int, model_size: int, output_size: int):
            super().__init__()
            self.input_fc = nn.Linear(input_size, model_size)
            self.middle_fc = nn.Linear(model_size, model_size)
            self.output_fc = nn.Linear(model_size, output_size)
        
        def forward(x: torch.Tensor):
            x = F.relu(self.input_fc(x))
            x = F.relu(self.middle_fc(x))
            return self.output_fc(x)
    
    
    @option(Configs.model)
    def one_hidden_layer(c: Configs):
        return OneHiddenLayerModule(c.input_size, c.model_size, c.output_size)
    
    @option(Configs.model)
    def two_hidden_layer(c: Configs):
        return TwoHiddenLayerModule(c.input_size, c.model_size, c.output_size)

Note that the configurations calculators pass only the needed parameters
and not the whole config object. The library forces you to do that.

However, you can directly set the model as an option, with ``__init__``
accepting ``Configs`` as a parameter, it is not a usage pattern we
encourage.

Calculating with predefined functions of lambdas
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can also compute configs with ``lambda`` functions or predefined
functions

.. code-block:: python

    _ = calculate(Configs.total_steps, [Configs.epochs, Configs.steps_per_epcoch], lambda e, s: e * s)

Aggregates
^^^^^^^^^^

You can use aggregates to setup configs that depend on each other. For
example, this is useful when you have LSTM based model and a CNN based
model, and different data loaders for each architecture.

Here we use ``variant`` to set both ``model`` and number of epochs.

.. code-block:: python

    aggregate(Configs.variant, 'small', (Configs.model, 'one_hidden_layer'), (Configs.epochs, 10))
    aggregate(Configs.variant, 'large', (Configs.model, 'two_hidden_layer'), (Configs.epochs, 100))

Hyper-parameters
^^^^^^^^^^^^^^^^

LabML will identify any parameter you explicily specify outside the
declaration of the class as hyper-parameters (in this case ``variant``
because we set it with ``conf.variant = 'large'``. You can also specify
hyper-parameters manually.

The hyper-parameters will be highlighted among other configs in logs and
in dashboard. These will also be logged in to Tensorboard.

.. code-block:: python

    hyperparams(Configs.epochs)
    hyperparams(Configs.total_steps, is_hyperparam=False)

Running the experiment
^^^^^^^^^^^^^^^^^^^^^^

Here’s how you run an experiment with the configurations.

.. code-block:: python

    conf = Configs()
    conf.variant = 'large'
    experiment.create(name='test_configs')
    experiment.configs(conf)
    logger.inspect(model=conf.model)



.. raw:: html

    <pre style="overflow-x: scroll;">
    Prepare model<span style="color: #00A250">...[DONE]</span><span style="color: #208FFB">	16.92ms</span>
    <span style="color: #60C6C8">model: </span><strong>TwoHiddenLayerModule(</strong><span style="color: #C5C1B4">\n</span><strong>  (input_fc): Linear(in_features=10, out_features=1024, bia</strong><span style="color: #DDB62B"> ...</span></pre>


.. code-block:: python

    experiment.start()



.. raw:: html

    <pre style="overflow-x: scroll;">
    <strong><span style="text-decoration: underline">test_configs</span></strong>: <span style="color: #208FFB">66482396392b11eba0aeacde48001122</span>
    	[dirty]: <strong><span style="color: #DDB62B">"link nn"</span></strong></pre>




.. parsed-literal::

    <labml.internal.experiment.watcher.ExperimentWatcher at 0x7f93a76ceb50>




.. raw:: html

    <pre style="overflow-x: scroll;"><span style="color: #C5C1B4"></span>
    <span style="color: #C5C1B4">--------------------------------------------------</span><span style="color: #DDB62B"><strong><span style="text-decoration: underline"></span></strong></span>
    <span style="color: #DDB62B"><strong><span style="text-decoration: underline">LABML WARNING</span></strong></span>
    <span style="color: #DDB62B"><strong><span style="text-decoration: underline"></span></strong></span>LabML App Warning: <span style="color: #60C6C8">empty_token: </span><strong>Please create a valid token at https://web.lab-ml.com.</strong>
    <strong>Click on the experiment link to monitor the experiment and add it to your experiments list.</strong><span style="color: #C5C1B4"></span>
    <span style="color: #C5C1B4">--------------------------------------------------</span></pre>



.. raw:: html

    <pre style="overflow-x: scroll;"><span style="color: #208FFB">Monitor experiment at </span><a href='https://web.lab-ml.com/run?run_uuid=66482396392b11eba0aeacde48001122' target='blank'>https://web.lab-ml.com/run?run_uuid=66482396392b11eba0aeacde48001122</a></pre>


