<?php

class Application_Model_DbTable_Papel extends Zend_Db_Table_Abstract
{

    protected $_name = 'tb_papel';
    protected $_primary = 'id_cargo';
    
    public function pesquisarPapel($id = null, $where = null, $order = null, $limit = null){
        if( !is_null($id) ){
            $arr = $this->find($id)->toArray();
            return $arr[0];
        }else{
            $select = $this->select()->from($this)->order($order)->limit($limit);
            if(!is_null($where)){
                $select->where($where);
            }
            return $this->fetchAll($select)->toArray();
        }
    }
    
    public function incluirPapel(array $request){
        $date = Zend_Date::now()->toString('yyyy-MM-dd');
        $dados = array(
            /*
             * formato:
             * 'nome_campo => valor,
             */
            'desc_cargo'      =>  $request['desc_cargo'],
            'dt_inclusao'     =>  $date,
            //'dt_alteracao'    =>  $request['dt_alteracao'],    
            'flg_status_papel'      =>  $request['flg_status_papel'],            
            //'usr_alterou'     =>  $request['usr_alterou'], não tem no banco
        );
        return $this->insert($dados);
    }
    
    public function alterarPapel(array $request){
        $date = Zend_Date::now()->toString('yyyy-MM-dd');
        $dados = array(
            /*
             * formato:
             * 'nome_campo => valor,
             */
            'id_cargo'        =>  $request['id_cargo'],
            'desc_cargo'      =>  $request['desc_cargo'],
            //'dt_inclusao'     =>  $request['dt_inclusao'],
            'dt_alteracao'    =>  $date,    
            'flg_status_papel'      =>  $request['flg_status_papel'],            
            //'usr_alterou'     =>  $request['usr_alterou'],
        );
        $where = $this->getAdapter()->quoteInto("id_cargo = ?", $request['id_cargo']);
        $this->update($dados, $where);
    }
    
    public function getListaPapel(){
        $select = $this->_db->select()
                ->from($this->_name, array('key'=>'id_cargo','value'=>'desc_cargo'));
        
        $result = $this->getAdapter()->fetchAll($select);
        
        return $result;
    }


}

