Use virtualenv
--------------

.. sourcecode:: bash

    virtualenv --distribute --unzip-setuptools project

    cd project

    # Ativa o virtualenv no Unix
    source bin/activate

    # Ativa o virtualenv no Windows
    Scripts\activate

    pip install django

Virtualenv Tips for Windows
---------------------------

Scripts\\django-admin.bat
~~~~~~~~~~~~~~~~~~~~~~~~~

.. sourcecode:: bat

    @python "%VIRTUAL_ENV%\Scripts\django-admin.py" %*

Scripts\\manage.bat
~~~~~~~~~~~~~~~~~~~

.. sourcecode:: bat

    @python "%VIRTUAL_ENV%\manage.py" %*

Virtualenv Tips for Unix
------------------------

.. sourcecode:: bash

    # Crie um alias no seu ~/.bashrc ou ~/.profile
    alias manage='python $VIRTUAL_ENV/manage.py'

Reduza a barreira de contribuição
---------------------------------

* `Virtualenv-Bootstrap <https://github.com/henriquebastos/virtualenv-bootstrap>`_
* Com isso o setup é só:

    .. sourcecode:: bash

        git clone repositorio
        cd repositorio
        python bootstrap

Requirements.txt
----------------

* Procure manter apenas 1 ``requirements.txt``.
* Explicite a versão das dependências: ``pip freeze``
* Mantenha as preferêncais do desenvolvedor de fora.
* Principalmente o IPython.

Nome de app é difícil...
------------------------

.. container:: small

    .. sourcecode:: bash

        ~repositorio$ django-admin.py startproject project .

        ~repositorio$ cd project

        ~project$ django-admin.py startapp core

Use as convenções do Django
---------------------------

.. sourcecode:: bash

    ~project$ mkdir -p core/templates/core
    ~project$ mkdir -p core/static/{css,img,js}

Projeto *dentro* do repositório
-------------------------------

.. container:: small

    ::

        repositorio/
            manage.py
            project/
                __init__.py
                settings.py
                urls.py
                wsgi.py
                core/
                    __init__.py
                    models.py
                    urls.py
                    views.py
                    static/
                    templates/
                        core/
                    tests/
                        __init__.py
