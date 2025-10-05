import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useLang } from '../i18n';
import DownloadMenu from './DownloadMenu'; // Assuming DownloadMenu is created

interface ToolbarProps {
  title: string;
  itemCount?: number;
  dataToDownload?: any;
  downloadFilename?: string;
}

const Toolbar: React.FC<ToolbarProps> = ({ title, itemCount, dataToDownload, downloadFilename }) => {
  const { t } = useLang();
  const navigate = useNavigate();

  const handleBack = () => {
    navigate(-1);
  };

  return (
    <div className="toolbar">
      <button onClick={handleBack} className="back-button">
        <span className="back-icon">←</span>
        {t('back')}
      </button>
      <div className="toolbar-title-group">
        <h2>{title}</h2>
        {itemCount !== undefined && (
          <span className="count-badge">{itemCount}</span>
        )}
      </div>
      {dataToDownload && downloadFilename && (
        <DownloadMenu data={dataToDownload} filename={downloadFilename} />
      )}
    </div>
  );
};

export default Toolbar;
