<?php

class Application_Form_Papel extends Twitter_Form
{

    protected $editavel;
    protected $tipo;

    public function __construct($tipo=null, $options = null) {
        $this->tipo = strtoupper($tipo);
        if ( strtoupper($tipo)=='EDIT' OR strtoupper($tipo)=='NEW'){
            $this->editavel = null;
        }else if ( strtoupper($tipo) == 'SHOW' ){
            $this->editavel = true;
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
        $id_papel = new Zend_Form_Element_Hidden('id_papel');
        
        $desc_papel = new Zend_Form_Element_Text('desc_papel');
        $desc_papel->setLabel('Papel')
                ->setAttrib('disabled', $this->editavel);
        
        $flg_status_papel = new Zend_Form_Element_Radio('flg_status_papel');
        $flg_status_papel->addMultiOption(1, "Ativo")
                ->addMultiOption(0, 'Inativo')
                ->setLabel('Status')
                ->setAttrib('disabled', $this->editavel);
        
        $dt_inclusao = new Zend_Form_Element_Text('dt_inclusao');
        $dt_inclusao->setLabel('Data de Inclusão')
                ->setAttrib('disabled', $this->editavel);
        
        $dt_alteracao = new Zend_Form_Element_Text('dt_alteracao');
        $dt_alteracao->setLabel('Data de Alteração')
                ->setAttrib('disabled', $this->editavel);
        
        $usr_alterou = new Zend_Form_Element_Text('usr_alterou');
        $usr_alterou->setLabel('Usuário que alterou')
                ->setAttrib('disabled', $this->editavel);
        
        $submit = new Zend_Form_Element_Submit('enviar');
        
        
        $this->addElements(array(
            $desc_papel,
            $flg_status_papel,
        ));
        
        if ($this->tipo != 'NEW'){
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
        $this->addElement("button", "custom", array(
			"class" => "btn-primary",
			"label" => "Voltar",
                        "onclick" => 'window.location =\''.$this->getView()->url(array('controller'=>'papel','action'=>'index')).'\' '
		));
        
    }


}

