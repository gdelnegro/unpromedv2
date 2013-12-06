<?php

class Application_Model_DbTable_Grupo extends Zend_Db_Table_Abstract
{

    protected $_name = 'tb_grupo_acesso';
    protected $_primary = 'id_grupo';
    
    public function pesquisarGrupo($id = null, $where = null, $order = null, $limit = null){
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
    
    public function incluirGrupo(array $request){
        $date = Zend_Date::now()->toString('yyyy-MM-dd');
        $dados = array(
            /*
             * formato:
             * 'nome_campo => valor,
             */
            'desc_grupo'      =>  $request['desc_grupo'],
            //'id_usu_sis'      =>  $request['id_usr'],
            'dt_inclusao'     =>  $date,
            'dt_alteracao'     =>  $date,
            'flg_status_grupo_acesso'      =>  $request['flg_status_grupo_acesso'],            
            //'desc_nome'         =>  $request['desc_nome'],
            //'flg_tipo_usuario'  =>  $request['flg_tipo_usuario'],
            //'usr_alterou'     =>  $request['usr_alterou'],
            
            
        );
        return $this->insert($dados);
    }
    
    public function alterarGrupo(array $request){
        $date = Zend_Date::now()->toString('yyyy-MM-dd');
        $dados = array(
            /*
             * formato:
             * 'nome_campo => valor,
             */
            'desc_grupo'      =>  $request['desc_grupo'],
            //'id_usu_sis'      =>  $request['id_usr'],
            'dt_inclusao'     =>  $date,
            'dt_alteracao'     =>  $date,
            'flg_status_grupo_acesso'      =>  $request['flg_status_grupo_acesso'],            
            //'desc_nome'         =>  $request['desc_nome'],
            //'flg_tipo_usuario'  =>  $request['flg_tipo_usuario'],
            //'usr_alterou'     =>  $request['usr_alterou'],
        );
        $where = $this->getAdapter()->quoteInto("id_grupo = ?", $request['id_grupo']);
        $this->update($dados, $where);
    }
    
    public function getListaGrupo(){
        $select = $this->_db->select()
                ->from($this->_name, array('key'=>'id_grupo','value'=>'desc_grupo'));
        $result = $this->getAdapter()->fetchAll($select);
        
        return $result;
    }

}

