import { useState, useEffect } from 'react';
import { API_BASE_URL } from '../api/config';

interface TermsDocument {
  id: number;
  version: string;
  filename: string;
  language: string;
  effectiveDate: string;
}

export function TermsDownload() {
  const [documents, setDocuments] = useState<TermsDocument[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(`${API_BASE_URL}/api/legal/terms`)
      .then(res => {
        if (!res.ok) throw new Error('Failed to fetch documents');
        return res.json();
      })
      .then(data => {
        setDocuments(data);
        setLoading(false);
      })
      .catch(err => {
        setError(err.message);
        setLoading(false);
      });
  }, []);

  const buildDownloadUrl = (filename: string, language: string) => `${API_BASE_URL}/api/legal/terms/download?file=${encodeURIComponent(filename)}&lang=${encodeURIComponent(language)}`;

  if (loading) {
    return (
      <div className="flex justify-center items-center p-8">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
        <span className="ml-2">Loading documents...</span>
      </div>
    );
  }

  if (error) return (
      <div className="p-6 bg-red-50 rounded-lg border border-red-200">
        <h2 className="text-xl font-semibold text-red-800 mb-2">Error</h2>
        <p className="text-red-600">{error}</p>
      </div>
    );

  return (
    <div className="p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold text-gray-800 mb-6">Terms & Conditions</h2>
      <p className="text-gray-600 mb-6">
        Download our terms and conditions documents in your preferred language.
      </p>
      
      <div className="space-y-4">
        {documents.map(doc => (
          <div 
            key={doc.id} 
            className="flex justify-between items-center p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors"
          >
            <div className="flex-1">
              <div className="flex items-center gap-3 mb-1">
                <span className="font-semibold text-lg text-gray-800">
                  Version {doc.version}
                </span>
                <span className="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded-full">
                  {doc.language.toUpperCase()}
                </span>
              </div>
              <div className="text-sm text-gray-500">
                Effective Date: {new Date(doc.effectiveDate).toLocaleDateString()}
              </div>
              <div className="text-xs text-gray-400 mt-1">
                File: {doc.filename}
              </div>
            </div>
            
            <a
              href={buildDownloadUrl(doc.filename, doc.language)}
              target="_blank"
              rel="noopener noreferrer"
              className="px-6 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
            >
              Download PDF
            </a>
          </div>
        ))}
      </div>

      {documents.length === 0 && (
        <div className="text-center py-8 text-gray-500">
          No documents available at this time.
        </div>
      )}
    </div>
  );
}
