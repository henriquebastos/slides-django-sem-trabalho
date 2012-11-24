.. include:: <s5defs.txt>

.. container:: center, huge

    Trabalhando com Django

    para não ter trabalho

.. container:: center, small

    Henrique Bastos


Quem?
-----

.. class:: incremental

* `@henriquebastos <http://twitter.com/henriquebastos>`_
* henrique@bastos.net
* http://henriquebastos.net
* http://welcometothedjango.com.br


Quem?
-----

.. container:: center, huge

    .. image:: assets/loogica_logo.svg
        :height: 250px
        :width: 600 px

.. container:: center, huge

    .. image:: assets/dekode_logo.svg
        :height: 250px
        :width: 600 px

Motivação
---------

* Zen

O setup influencia tudo
-----------------------

.. class:: incremental

* Comporte-se como um Chef de cozinha.
* Live Software: Código bom é codigo rodando.
* Top-Down: template primeiro, modelo depois.


.. include:: setup.rst

.. include:: settings.rst


Mantenha o URLCONF limpo
------------------------

.. container:: small

    .. sourcecode:: python

        # urls.py
        from django.conf.urls import patterns, include, url

        urlpatterns = patterns('django.views.generic.simple',
            url(r'^$', 'direct_to_template', {'template': 'index.html'}),
        )

.. class:: red

*Nope*


Mantenha o urls.py o mais limpo possível
----------------------------------------

.. container:: small

    .. sourcecode:: python

        # urls.py
        from django.conf.urls import patterns, include, url

        urlpatterns = patterns('project.core.views',
            url(r'^$', 'homepage', name='homepage'),
        )
         
        # views.py
        from django.views.generic.simple import direct_to_template

        def homepage(request):
            return direct_to_template(request, template='index.html')

.. class:: green

*Yep*


.. include:: views.rst

O Template é do seu Designer!
-----------------------------

* Passe tipos de alto nível para o contexto;
* Não defina a representação dos seus objetos na view;
* Use template filters:

.. sourcecode:: django

    {{ subscription.created_at|date:"d/m/Y" }}
    {{ text|escape|linebreaks }}
    {{ text|truncatewords:"30" }}

Cuidado com {% include %}
-------------------------

* Use como *snippet* em um mesmo template;
* Evite usar o mesmo *snippet* em mais de um template;
* {% includes %} genéricos incham os contextos;
* Use {% extends %} para *cabeçalho* e *rodapé*;


Isole o conteúdo com i18n
-------------------------

* Deixe a turma do marketing definir o conteúdo;
* No models.py use o ``ugettext_lazy``;
* No resto use o ``ugettext``;
* Pluralização é com o ``ungettext``;
* Use mesmo que seu sistema seja apenas em *pt_BR*;

Django Admin
------------

* Aceite a natureza do Admin;
* Se precisa mudar muito implemente CustomViews;
* Decore sua CustomView com *@admin_view*;
* Reimplemente o ``ModelAdmin.get_urls``;

.. include:: models.rst

.. include:: form.rst

.. include:: tests.rst

Obrigado
--------

* `@henriquebastos <http://twitter.com/henriquebastos>`_
* henrique@bastos.net
* http://henriquebastos.net
* http://welcometothedjango.com.br
