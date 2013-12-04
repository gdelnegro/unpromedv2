<?php

class Application_Form_Papel extends Twitter_Form
{

    protected $exibir;
    protected $tipo;

    public function __construct($tipo=null, $options = null) {
        $this->tipo = strtoupper($tipo);
        if ( strtoupper($tipo)=='EDIT' OR strtoupper($tipo)=='NEW'){
            $this->exibir = null;
        }else if ( strtoupper($tipo) == 'SHOW' ){
            $this->exibir = true;
        }
        parent::__construct($options);
    }
    
    public function init()
    {
        /*Método do formulário (post ou get)*/
        $this->setMethod('post');
        /*Atributo HTML do form*/
        $this->setAttrib("horizontal", true);
        
        /*Elementos*/
        $id_cargo = new Zend_Form_Element_Hidden('id_cargo');
        
        $desc_cargo = new Zend_Form_Element_Text('desc_cargo');
        $desc_cargo->setLabel('Papel')
                ->setAttrib('disabled', $this->exibir)
                ->setAttrib('lenght', 30)
                ->setRequired(true)
                ->setFilters(array('StringTrim'))
                ->setValidators(array(
                    array('notEmpty', true, array(
                                'messages' => array(
                                    'isEmpty' => 'Senha nao pode ser nula'
                                )
                        )),
                    ))
                ->setAttrib('disabled', $this->exibir);
        
        $flg_status_papel = new Zend_Form_Element_Radio('flg_status_papel');
        $flg_status_papel->addMultiOption(1, "Ativo")
                ->addMultiOption(0, 'Inativo')
                ->setLabel('Status')
                ->setAttrib('disabled', $this->exibir);
        
        $dt_inclusao = new Zend_Form_Element_Text('dt_inclusao');
        $dt_inclusao->setLabel('Data de Inclusão')
                ->setAttrib('disabled', $this->exibir);
        
        $dt_alteracao = new Zend_Form_Element_Text('dt_alteracao');
        $dt_alteracao->setLabel('Data de Alteração')
                ->setAttrib('disabled', $this->exibir);
        
        $usr_alterou = new Zend_Form_Element_Text('usr_alterou');
        $usr_alterou->setLabel('Usuário que alterou')
                ->setAttrib('disabled', $this->exibir);
        
        $submit = new Zend_Form_Element_Submit('enviar');
        $submit->setAttrib(
        'onclick', 
        'if (confirm("Deseja prosseguir?")) { document.form.submit(); } return false;'
        );
        
        
        $this->addElements(array(
            $id_cargo,
            $desc_cargo,
            $flg_status_papel,
        ));
        
        if ($this->tipo == 'SHOW'){
            $this->addElements(array(
                $dt_inclusao,
                $dt_alteracao,
                $usr_alterou,
            ));
        }
        
        if ($this->tipo != 'SHOW'){
            $this->addElement($submit);
        }
        
        /*Botão Voltar*/
        $this->addElement("button", "voltar", array(
			"class" => "btn-primary",
			"label" => "Voltar",
                        "onclick" => 'window.location =\''.$this->getView()->url(array('controller'=>'papel','action'=>'index')).'\' '
		));
        
        /*Botão Imprimir*/
        $this->addElement("button", "imprimir", array(
			"class" => "btn-primary",
			"label" => "Imprimir",
                        "onclick" => 'window.print()',
                        //"onclick" => 'window.location =\''.$this->getView()->url(array('controller'=>'papel','action'=>'print')).'\' '
		));
        
    }


}