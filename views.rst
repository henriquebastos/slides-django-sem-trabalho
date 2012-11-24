Views são buracos negros
------------------------

Refatore

* Conversões de dados da requisição nos forms;
* Representação dos dados com template filters;
* Queries encadeadas encapsuladas no Manager;
* Sinais para notificar eventos à outras apps;

Refatore novamente!

* Crie camadas de serviço quando muitos modelos mudarem simultaneamente.

Decorators empilhados repetidamente são sintoma
-----------------------------------------------

* Pode estar faltando um ``middleware``;
* Falta uma classe base para as views;

Relatórios em PDF
-----------------

* Morte ao Reportlab!
* Vida longa ao `wkhtmltopdf <http://pypi.python.org/pypi/wkhtmltopdf/0.2>`_

Exemplo
-------

.. container:: tiny

    .. sourcecode:: python

        import subprocess
        from tempfile import NamedTemporaryFile
        from django.template.loader import render_to_string


        def view(request):
            context = {...}
            html = render_to_string('template.html', context)

            with NamedTemporaryFile(suffix=".html") as f:
                f.write(html)
                f.flush()

                subprocess.call([settings.WKHTMLTOPDF_PATH, f.name, '/tmp/report.pdf'])
                content = open('/tmp/report.pdf', 'rb').read()

            response = HttpResponse(mimetype='application/force-download')
            response['Content-Disposition'] = 'attachment; filename=report.pdf'
            response.write(content)

            return response


Organize o fluxo das views
--------------------------

.. container:: small

    .. sourcecode:: python

        def subscribe(request):
            if request.method == 'POST':
                form = SubscriptionForm(request.POST)
                if form.is_valid():
                    s = form.save()
                    return HttpResponseRedirect(s.get_absolute_url())
            else:
                form = SubscriptionForm()

            return direct_to_template(request,
                                      'subscriptions/subscription_form.html',
                                      {'form': form})

Single Responsability
---------------------

.. container:: small

    .. sourcecode:: python

        def subscribe(request):
            if request.method == 'POST':
                return create(request)
            else:
                return new(request)

        def new(request):
            return direct_to_template(request,
                                      'subscriptions/subscription_form.html',
                                      {'form': SubscriptionForm()})
        def create(request):
            form = SubscriptionForm(request.POST)
            if not form.is_valid():
                return direct_to_template(request,
                                          'subscriptions/subscription_form.html',
                                          {'form': form})
            s = form.save()
            return HttpResponseRedirect(s.get_absolute_url())

Reaproveite o que está pronto
-----------------------------

.. sourcecode:: python

    from django.views.generic import CreateView

    class SubscriptionCreate(CreateView):
        model = Subscription
        form_class = SubscriptionForm
